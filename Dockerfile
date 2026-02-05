FROM oven/bun:${BUN_VERSION} AS builder

WORKDIR /app
ENV NODE_ENV=production

# Copy package files first
COPY --link bun.lock package.json ./

# Add conditional installation of svelte-adapter-bun and update config
RUN if ! grep -q "svelte-adapter-bun" package.json; then \
    bun add -D svelte-adapter-bun; \
    fi

# Install dependencies
RUN bun install --ci

# Copy remaining files
COPY --link . .

# Build the application
RUN bun --bun run vite build
