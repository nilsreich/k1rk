FROM oven/bun:latest

WORKDIR /app

# Kopiere die Package-Dateien und installiere Abhängigkeiten
COPY package.json bun.lockb* ./
RUN bun install

# Kopiere den Rest des Codes
COPY . .

# Baue die Anwendung
RUN bun run build

# Exponiere den Port
EXPOSE 3000

# Starte die Anwendung
CMD ["bun", "run", "start"]
