FROM oven/bun:latest

WORKDIR /app

# Kopiere die Package-Dateien und installiere Abhängigkeiten
COPY package.json bun.lockb* ./
RUN bun install

ENV NODE_ENV=production

# Deaktiviere Telemetrie während der Laufzeit
ENV NEXT_TELEMETRY_DISABLED=1

# Kopiere den restlichen Code und baue die Anwendung
COPY . .
RUN bun run build

# Entferne unnötige Quellcodedateien, um die Bildgröße zu reduzieren
RUN rm -rf pages public styles components

# Exponiere den Port
EXPOSE 3000

# Starte die Anwendung
CMD ["bun", "run", "start"]
