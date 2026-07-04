import Parser, {
	type Language,
	type QueryCapture,
} from "@keqingmoe/tree-sitter";
import { createRequire } from "module";
import path from "path";
import fs from "fs";
const require = createRequire(import.meta.url);

interface GrammarAuthor {
	name: string;
	email?: string;
	url?: string;
}

interface TreeSitterMetadata {
	version: string; // Required (SemVer)
	license?: string; // Valid SPDX license
	description?: string;
	authors: GrammarAuthor[]; // Required
	links?: {
		repository: string;
		funding?: string;
	};
	namespace?: string; // Defaults to "io.github.tree-sitter"
}

interface GeneratedBindings {
	c?: boolean; // Default: true
	go?: boolean; // Default: true
	java?: boolean; // Default: true
	node?: boolean; // Default: true
	python?: boolean; // Default: true
	rust?: boolean; // Default: true
	swift?: boolean; // Default: false
	zig?: boolean; // Default: false
	[customLanguage: string]: boolean | undefined;
}

interface TreeSitterGrammarConfig {
	name: string;
	// Basic parser info
	scope: string; // Required (e.g., "source.js")
	path?: string; // Default: "."
	"external-files"?: string[];

	// Language detection
	"file-types"?: string[];
	"first-line-regex"?: string;
	"content-regex"?: string;
	"injection-regex"?: string;

	// Query paths
	highlights?: string; // Default: "queries/highlights.scm"
	locals?: string; // Default: "queries/locals.scm"
	injections?: string; // Default: "queries/injections.scm"
	tags?: string; // Default: "queries/tags.scm"
}

// The top-level schema for tree-sitter.json
interface TreeSitterConfig {
	/**
	 * Grammars defined by this package. Older tree-sitter setups sometimes defined this
	 * directly at the root object, while modern setups use an array or dictionary wrapper.
	 * Adjust if your specific ecosystem uses an array of TreeSitterGrammarMetadata blocks.
	 */
	grammars: TreeSitterGrammarConfig[];
	metadata: TreeSitterMetadata;
	bindings: GeneratedBindings;

	// Fallback signature to allow mixing in root-level grammar configurations if needed
	[key: string]: unknown;
}

// The structural blueprint of our final cache object
interface TreeSitterGrammarInfo {
	language: Language;
	grammar: TreeSitterGrammarConfig;
	config: TreeSitterConfig;
	queries: {
		highlights: string;
	};
	modulePath: string;
}

type TreeSitterGrammars = {
	[filetype: string]: TreeSitterGrammarInfo;
};

/**
 * Recursively searches for node_modules directories starting from a root path
 * and looks for packages that begin with 'tree-sitter-'.
 */
function findTreeSitterModules(startDir: string): string[] {
	const modules: string[] = [];

	function scan(dir: string): void {
		// skip hidden caches/git folders
		if (dir.match(/\/\./)) return;

		try {
			const files = fs.readdirSync(dir);

			// If we are inside a node_modules folder, check the packages
			if (path.basename(dir) === "node_modules") {
				for (const file of files) {
					const fullPath = path.join(dir, file);

					// Handle scoped modules (e.g., @my-scope/tree-sitter-javascript)
					if (file.startsWith("@")) {
						const scopedFiles = fs.readdirSync(fullPath);
						for (const scopedFile of scopedFiles) {
							if (scopedFile.startsWith("tree-sitter-")) {
								modules.push(path.join(fullPath, scopedFile));
							}
						}
					} else if (file.startsWith("tree-sitter-")) {
						modules.push(fullPath);
					}
				}
			}

			// Recurse down into directories to find nested node_modules
			for (const file of files) {
				const fullPath = path.join(dir, file);
				if (fs.statSync(fullPath).isDirectory()) {
					// Only traverse into node_modules or source directories, avoid deep package internals
					if (file === "node_modules" || !dir.includes("node_modules")) {
						scan(fullPath);
					}
				}
			}
		} catch (err) {
			// Handle permission errors or broken symlinks gracefully
		}
	}

	scan(startDir);
	// Deduplicate in case symlinks or monorepos cause double hits
	return [...new Set(modules)];
}

// Reads files and combines the contents into a single file.
function readFiles(paths: string[], strict = false): string {
	let text = "";
	for (const path of paths) {
		const content = fs.readFileSync(path, "utf8");
		if (content) {
			text += content + "\n";
		} else if (strict) {
			throw new Error(`Expected ${path} to exist`);
		}
	}
	return text;
}

function normalizeToList<T>(input: T | T[]): T[] {
	return Array.isArray(input) ? input : [input];
}

function readQueriesFromGrammar(
	grammar: TreeSitterGrammarConfig,
	modulePath: string,
) {
	const paths = normalizeToList(
		grammar.highlights ?? ["queries/highlights.scm"],
	).map((highlightRelativePath) => {
		if (highlightRelativePath.startsWith("node_modules")) {
			// the module won't have it since it's a sibling in our node_modules
			return path.join(process.cwd(), highlightRelativePath);
		} else {
			// otherwise it's usually a queries/ path from the module root
			return path.join(modulePath, highlightRelativePath);
		}
	});
	return {
		highlights: readFiles(paths),
	};
}

/**
 * Builds a lookup table that automatically finds all installed tree-sitter-* node_modules mapped by supported filetypes.
 * Additionally finds and returns the corresponding query files.
 */
const grammarLookup: TreeSitterGrammars = {};
// Start scanning from the current working directory
const modulePaths = findTreeSitterModules(
	path.join(process.cwd(), "node_modules"),
);

for (const modulePath of modulePaths) {
	const jsonPath = path.join(modulePath, "tree-sitter.json");

	try {
		if (!fs.existsSync(jsonPath)) {
			throw new Error(`no tree-sitter.json in ${modulePath}`);
		}

		let config = JSON.parse(
			fs.readFileSync(jsonPath, "utf8"),
		) as TreeSitterConfig;

		if (!config?.grammars) throw new Error("grammars field not present");

		for (const grammar of config.grammars) {
			let language = require(modulePath) as
				| Language
				| { [key: string]: Language }; // tree-sitter-typescript's module is in this format.
			const languages = language.nodeTypeInfo
				? [language as Language]
				: (Object.values(language) as Language[]);
			for (const lang of languages) {
				const grammarInfo: TreeSitterGrammarInfo = {
					language: lang,
					grammar,
					config,
					modulePath,
					queries: readQueriesFromGrammar(grammar, modulePath),
				};

				const filetypes = grammar["file-types"] ?? [];
				if (grammar["name"]) filetypes.push(grammar["name"]);
				for (const filetype of [...new Set(filetypes)]) {
					grammarLookup[filetype] = grammarInfo;
				}
			}
		}
	} catch (error) {
		const errorMessage = error instanceof Error ? error.message : String(error);
		console.error(
			`Failed to load or cache module at ${modulePath}:`,
			errorMessage,
		);
	}
}

var matchHtmlRegExp = /["'&<>]/;
function escapeHtml(text: string) {
	var str = "" + text;
	var match = matchHtmlRegExp.exec(str);

	if (!match) {
		return str;
	}

	var escape;
	var html = "";
	var index = 0;
	var lastIndex = 0;

	for (index = match.index; index < str.length; index++) {
		switch (str.charCodeAt(index)) {
			case 34: // "
				escape = "&quot;";
				break;
			case 38: // &
				escape = "&amp;";
				break;
			case 39: // '
				escape = "&#39;";
				break;
			case 60: // <
				escape = "&lt;";
				break;
			case 62: // >
				escape = "&gt;";
				break;
			default:
				continue;
		}

		if (lastIndex !== index) {
			html += str.substring(lastIndex, index);
		}

		lastIndex = index + 1;
		html += escape;
	}

	return lastIndex !== index ? html + str.substring(lastIndex, index) : html;
}

// given a capture name, return a space-separated string of classes specifiying increasingly specific classes
// eg. ts-punctuation ts-punctuation-bracket
function getCaptureClasses(capture: QueryCapture): string[] {
	const parts = capture.name.split(".");
	const classes: string[] = [];
	let current = "ts";
	for (const part of parts) {
		current += "-" + part;
		classes.push(current);
	}
	return classes;
}

export async function highlightCode(
	code: string,
	lang_or_extension: string | null,
): Promise<string | null> {
	if (!lang_or_extension) {
		return null;
	}
	const grammar = grammarLookup[lang_or_extension];
	// console.log({
	// 	grammarLookup,
	// 	grammar,
	// 	lang_or_extension,
	// });
	if (!grammar) {
		return null;
	}

	const parser = new Parser();
	parser.setLanguage(grammar.language);

	const tree = parser.parse(code);
	if (!tree) {
		return null;
	}
	const events: Array<{
		index: number;
		type: "open" | "close";
		className?: string;
		length?: number;
		start: number;
	}> = [];

	const highlightQueries = new Parser.Query(
		grammar.language,
		grammar.queries.highlights,
	);
	for (const capture of highlightQueries.captures(tree.rootNode)) {
		const start = capture.node.startIndex;
		const end = capture.node.endIndex;
		console.log({ capture });
		if (end > start) {
			events.push({
				index: start,
				type: "open",
				className: getCaptureClasses(capture).join(" "),
				length: end - start,
				start: start,
			});
			events.push({
				index: end,
				type: "close",
				start: start,
			});
		}
	}

	events.sort((a, b) => {
		if (a.index !== b.index) {
			return a.index - b.index;
		}
		if (a.type !== b.type) {
			return a.type === "close" ? -1 : 1;
		}
		if (a.type === "open") {
			return (b.length || 0) - (a.length || 0);
		} else {
			return b.start - a.start;
		}
	});

	let result = "";
	let lastIndex = 0;
	for (const event of events) {
		if (event.index > lastIndex) {
			result += escapeHtml(code.slice(lastIndex, event.index));
			lastIndex = event.index;
		}
		if (event.type === "open") {
			result += `<span class="${event.className}">`;
		} else {
			result += `</span>`;
		}
	}
	if (lastIndex < code.length) {
		result += escapeHtml(code.slice(lastIndex));
	}

	return result;
}
