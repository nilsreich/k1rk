FROM oven/bun:latest

WORKDIR /app

# Kopiere die Package-Dateien und installiere Abhängigkeiten
COPY package.json bun.lockb* ./
RUN bun install

# Kopiere den Rest des Codes
COPY . .

ENV NODE_ENV=production

# Uncomment the following line in case you want to disable telemetry during runtime.
ENV NEXT_TELEMETRY_DISABLED=1

# Baue die Anwendung
RUN bun run build

# Exponiere den Port
EXPOSE 3000

# Starte die Anwendung
CMD ["bun", "run", "start"]
