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

# Entferne Quellcode und kopiere alle Dateien in den .next-Ordner
RUN rm -rf pages public styles components
RUN mkdir -p .next
RUN cp -r * .next/

# Optional: Entferne das node_modules-Verzeichnis, um Platz zu sparen
RUN rm -rf node_modules

# Installiere die Abhängigkeiten erneut
RUN bun install

# Setze das Arbeitsverzeichnis auf den .next-Ordner
WORKDIR /app/.next

# Exponiere den Port
EXPOSE 3000

# Starte die Anwendung
CMD ["bun", "run", "start"]
