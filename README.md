# Deprecated Script: RAR File Extractor

## 🚨 End of Life (EOL) Notice

```
=================================================================
== This script is EOL and no longer supported.                 ==
== Work is ongoing for its successor at                        ==
== https://github.com/Turukmoorea/mediatool                    ==
=================================================================
```

```
=================================================================
== Dieses Skript ist EOL und wird nicht mehr unterstützt.      ==
== Es wird am Nachfolger gearbeitet. Mehr Informationen unter: ==
== https://github.com/Turukmoorea/mediatool                    ==
=================================================================
```

---

## Overview / Übersicht

This script, created by **Turukmoorea** on **14.12.2024**, is a utility designed for extracting **RAR files**. It was developed specifically to handle compressed RAR archives and has been confirmed to work reliably for these file types. The script is no longer actively supported as of the above date.

Dieses Skript, erstellt von **Turukmoorea** am **14.12.2024**, ist ein Werkzeug zum Extrahieren von **RAR-Dateien**. Es wurde speziell für die Verarbeitung von komprimierten RAR-Archiven entwickelt und arbeitet zuverlässig mit diesen Dateitypen. Das Skript wird ab dem oben genannten Datum nicht mehr aktiv unterstützt.

Development efforts have shifted to a modular project that is available [here](https://github.com/Turukmoorea/mediatool/tree/dev_mediatool).

Die Entwicklungsarbeit wurde auf ein modulares Projekt verlagert, das [hier](https://github.com/Turukmoorea/mediatool/tree/dev_mediatool) verfügbar ist.

---

## Features / Funktionen

### Supported Operations / Unterstützte Operationen:
- Extract compressed RAR files.
- Handle multi-part RAR archives.
- Optionally delete original files after extraction.
- Default source and destination directories.
- Verbose mode for detailed logging.

- Extrahieren von komprimierten RAR-Dateien.
- Verarbeitung von mehrteiligen RAR-Archiven.
- Optionale Löschung der Originaldateien nach der Extraktion.
- Standard-Quell- und Zielverzeichnisse.
- Ausführlicher Modus für detaillierte Protokollierung.

---

### Usage / Nutzung

#### English:
Run the script with the following options:

```
Usage: ./script.sh -s [source_directory] -d [destination_directory] -f [specific_file] -o [options]

Options:
  -h, --help         Show help message and exit.
  -s [source]        Specify the source directory (default: current directory).
  -d [destination]   Specify the destination directory (default: './extracted').
  -f [file]          Specify a specific file or multi-part archive to extract.
  -r, --remove       Remove original files after extraction.
  --part-allow       Enable processing of all part files.
  -v                 Enable verbose mode.
```

#### Deutsch:
Das Skript kann mit folgenden Optionen verwendet werden:

```
Verwendung: ./script.sh -s [Quellverzeichnis] -d [Zielverzeichnis] -f [spezifische_Datei] -o [Optionen]

Optionen:
  -h, --help         Zeige Hilfe an und beende das Skript.
  -s [Quelle]        Gebe das Quellverzeichnis an (Standard: aktuelles Verzeichnis).
  -d [Ziel]          Gebe das Zielverzeichnis an (Standard: './extracted').
  -f [Datei]         Gebe eine spezifische Datei oder ein mehrteiliges Archiv an.
  -r, --remove       Entferne die Originaldateien nach dem Entpacken.
  --part-allow       Aktiviere die Verarbeitung aller Datei-Teile.
  -v                 Aktiviere den ausführlichen Modus.
```

---

## Requirements / Anforderungen
- `unrar` tool for handling RAR files. The script will prompt to install it if missing.
- `unrar`-Tool für die Verarbeitung von RAR-Dateien. Das Skript fordert zur Installation auf, falls es fehlt.

---

## Limitations / Einschränkungen
- This script only supports RAR file extraction.
- Multi-part archives are processed only if properly named (e.g., `part1.rar`).

- Dieses Skript unterstützt ausschließlich das Extrahieren von RAR-Dateien.
- Mehrteilige Archive werden nur verarbeitet, wenn sie korrekt benannt sind (z. B. `part1.rar`).
