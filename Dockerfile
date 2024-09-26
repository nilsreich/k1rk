# Stage 1: Build Stage
FROM oven/bun:latest AS builder

WORKDIR /app

# Kopiere die Package-Dateien und installiere Abhängigkeiten
COPY package.json bun.lockb* ./
RUN bun install

ENV NODE_ENV=production

# Uncomment the following line in case you want to disable telemetry during runtime.
ENV NEXT_TELEMETRY_DISABLED=1

# Kopiere den restlichen Code und baue die Anwendung
COPY . .
RUN bun run build

# Stage 2: Production Stage
FROM oven/bun:latest

WORKDIR /app

# Kopiere nur die notwendigen Dateien aus der Build-Stage
COPY --from=builder /app/.next/ ./.next/
COPY --from=builder /app/package.json ./
COPY --from=builder /app/bun.lockb ./
COPY --from=builder /app/next.config.js ./

# Installiere nur die Produktionsabhängigkeiten
RUN bun install --production

# Exponiere den Port
EXPOSE 3000

# Starte die Anwendung
CMD ["bun", "run", "start"]
