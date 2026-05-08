FROM oven/bun:latest AS builder

WORKDIR /app
ENV NODE_ENV=production

COPY --link bun.lock package.json ./
RUN bun install --ci
COPY --link . .

RUN bun run build
