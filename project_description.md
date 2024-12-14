# Mediatool Projektbeschreibung

## Überblick
**Mediatool** ist ein modulares, auf der Kommandozeile basierendes Tool, das für die effiziente Verwaltung von Mediendateien entwickelt wurde. Es ist speziell darauf ausgelegt, große Datenmengen zu verarbeiten, während es umfassende Flexibilität und eine klare, benutzerfreundliche CLI-Schnittstelle bietet. Das Tool wird hauptsächlich in Python entwickelt, um Plattformunabhängigkeit und Skalierbarkeit sicherzustellen. Die Installationsskripte sind in Shell (bash, zsh usw.) geschrieben, um maximale Kompatibilität mit unterschiedlichen Umgebungen zu gewährleisten.

Das Projekt funktioniert ohne grafische Benutzeroberfläche (reines CLI) und bietet optional Fortschrittsanzeigen oder Ausgaben direkt im Terminal. Es wurde entwickelt, um robust, erweiterbar und benutzerfreundlich zu sein, insbesondere für fortgeschrittene Nutzer:innen, die mit Medienarchiven, Umbenennung, Codecs und mehr arbeiten.

Ausführbare Datei (Binary):
Das fertige Tool wird als eigenständige, ausführbare Datei (Binary) gebündelt, die ohne zusätzliche Abhängigkeiten direkt auf Zielsystemen ausgeführt werden kann. Dafür wird das Tool mit einem Python-Compiler wie PyInstaller oder cx_Freeze in eine All-in-One-Binary konvertiert, die alle Module und Abhängigkeiten integriert. Dies ermöglicht die Nutzung auf Systemen ohne vorinstalliertes Python.

---

## Kernfunktionen

### Hauptskript
- Zentrales Kontrollskript (`mediatool.py`), das alle Module verwaltet und ausführt.
- Unterstützt detailliertes Logging (verschiedene Stufen: DEBUG, INFO, WARNING usw.).
- Ermöglicht benutzerdefinierte Eingabe-/Ausgabeverzeichnisse und CLI-Argumente.

### Module
1. **Install:**
   - Installiert Mediatool-Abhängigkeiten und richtet die Umgebung ein.
2. **Purge:**
   - Entfernt Abhängigkeiten und bereinigt das System.
3. **Extract:**
   - Entpacken von Formaten wie `zip`, `rar`, `7z`, `tar` und mehr.
   - Jedes Format hat ein eigenes Submodul, um Modularität und Stabilität sicherzustellen.
4. **Compress:**
   - Komprimiert Dateien in dieselben Formate, die im Extract-Modul unterstützt werden.
5. **Rename:**
   - Umbenennen von Mediendateien (Filme, Serien) mit Tools wie `filebot` oder eigener Logik.
6. **Codec:**
   - Konvertierung von Video- und Audiocodecs mit Tools wie `ffmpeg` für maximale Flexibilität.

---

## Tests und Experimente
Tests und Experimente werden in einem dedizierten Ordner namens `/projectroot/lab` durchgeführt. Hier werden Dummy-Dateien und verschiedene Archiv-/Kompressionsmethoden getestet. Der Lab-Ordner ist speziell darauf ausgelegt, Edge Cases einfach reproduzieren zu können.

---

## Entwicklungspriorität
Das Projekt startet mit der Implementierung folgender Module:
1. **Install**
2. **Purge**
3. **Extract**
4. **Compress**

Nach der Fertigstellung dieser Basismodule folgen:
5. **Rename**
6. **Codec**

---

## Dokumentation
Eine **ausführliche Dokumentation** wird nach und nach basierend auf dem erstellten Code entwickelt. Diese Dokumentation dient als Grundlage für die Nutzung und Weiterentwicklung des Projekts sowie für externe Beiträge. Die Dokumentation wird laufend aktualisiert, um die wichtigsten Aspekte des Tools abzudecken und Benutzer:innen Schritt für Schritt durch die Funktionen zu führen.

---

## Zielgruppe
- **Fortgeschrittene Nutzer:innen:**
  Personen, die regelmäßig große Medienarchive verwalten und Tools für das Entpacken, Komprimieren, Umbenennen und Konvertieren benötigen.
- **Linux-Enthusiast:innen:**
  Nutzer:innen, die mit CLI-Tools vertraut sind und modulare, anpassbare Software bevorzugen.
- **Entwickler:innen:**
  Personen, die die Funktionalität des Tools erweitern oder anpassen möchten.

---

## Verwendete Technologien
- **Python:** Hauptprogrammiersprache für die Kernfunktionen und Module.
- **Bash/Zsh:** Für Installationsskripte und systemnahe Aufgaben.
- **Externe Tools** (optionale Integration):
  - `ffmpeg` für die Codec-Konvertierung.
  - `filebot` für die Umbenennung von Medien.
  - Archivierungstools wie `7z`, `rar`, `zip`, `tar` usw.

---

## Verzeichnisstruktur
Das Tool ist modular aufgebaut, um Skalierbarkeit und Wartbarkeit zu gewährleisten:

siehe dazu das file "projectroot/project_description"

# Liste der Optionen

## **1. Allgemeine Optionen**
Diese Optionen sind universell und sollten in fast jedem Modul verfügbar sein:

| **Kurzform** | **Langform**  | **Beschreibung**                                                    |
|--------------|---------------|----------------------------------------------------------------------|
| `-h`         | `--help`      | Zeigt eine Hilfemeldung und die verfügbaren Optionen an.             |
| `-v`         | `--version`   | Gibt die Version des Tools aus.                                     |
| `-l`         | `--log-level` | Setzt das Log-Level (`DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`). |
| `-c`         | `--config`    | Pfad zu einer Konfigurationsdatei.                                  |
| `-d`         | `--dry-run`   | Simuliert den Vorgang ohne Änderungen vorzunehmen.                  |
| `--quiet`    | `--quiet`     | Unterdrückt alle Ausgaben, außer Fehlern.                           |

---

## **2. Dateiquellen und -ziele**
Diese Optionen dienen dazu, Eingabe- und Ausgabeziele flexibel anzugeben:

| **Kurzform** | **Langform**  | **Beschreibung**                                                   |
|--------------|---------------|-------------------------------------------------------------------|
| `-s`         | `--source`    | Pfad zur Eingabedatei oder zum Eingabeverzeichnis.                |
| `-t`         | `--target`    | Pfad zur Ausgabedatei oder zum Ausgabeverzeichnis.                |
| `-r`         | `--recursive` | Rekursives Verarbeiten von Verzeichnissen.                        |
| `-e`         | `--exclude`   | Liste von Dateien/Verzeichnissen, die ausgeschlossen werden sollen. |
| `-i`         | `--include`   | Liste von Dateien/Verzeichnissen, die eingeschlossen werden sollen. |
| `-f`         | `--file`      | Gibt eine spezifische Datei an, die verarbeitet werden soll.       |
| `-o`         | `--output`    | Alternativer Name für die Ausgabe (z. B. Archivname oder Dateiname).|

---

## **3. Archiv- und Kompressionsoptionen**
Spezifisch für `extract` und `compress` Module:

| **Kurzform** | **Langform**   | **Beschreibung**                                                  |
|--------------|----------------|------------------------------------------------------------------|
| `-z`         | `--zip`        | Verwendet das ZIP-Format.                                        |
| `-7`         | `--7z`         | Verwendet das 7z-Format.                                         |
| `-r`         | `--rar`        | Verwendet das RAR-Format.                                        |
| `-t`         | `--tar`        | Verwendet das TAR-Format.                                        |
| `--password` | `--password`   | Passwort für geschützte Archive.                                |
| `--overwrite`| `--overwrite`  | Überschreibt bestehende Dateien ohne Nachfrage.                 |
| `--keep`     | `--keep`       | Behalte Originaldateien nach der Komprimierung/Extraktion.      |
| `--strip`    | `--strip`      | Entfernt Verzeichnisstrukturen beim Entpacken.                  |

---

## **4. Codec-Optionen**
Nützlich für das Modul `codec`, um Mediadateien zu konvertieren:

| **Kurzform** | **Langform**      | **Beschreibung**                                                |
|--------------|-------------------|----------------------------------------------------------------|
| `-i`         | `--input`         | Pfad zur Eingabedatei (z. B. Videodatei).                      |
| `-c`         | `--codec`         | Gibt den Codec an (z. B. `h264`, `aac`, `mp3`).                |
| `-b`         | `--bitrate`       | Gibt die Bitrate an (z. B. `128k`, `1M`).                      |
| `-fr`        | `--frame-rate`    | Setzt die Framerate (z. B. `30`, `60`).                        |
| `-res`       | `--resolution`    | Gibt die Zielauflösung an (z. B. `1920x1080`).                 |
| `--audio`    | `--audio-only`    | Extrahiert nur die Audiospur.                                  |
| `--video`    | `--video-only`    | Entfernt die Audiospur und behält nur das Video.               |

---

## **5. Rename-Optionen**
Spezifisch für das Modul `rename`:

| **Kurzform** | **Langform** | **Beschreibung**                                                   |
|--------------|--------------|-------------------------------------------------------------------|
| `-p`         | `--pattern`  | Muster zur Umbenennung (z. B. `S{season}E{episode}`).             |
| `-m`         | `--move`     | Verschiebt die Dateien an einen neuen Speicherort.               |
| `--dry-run`  | `--dry-run`  | Zeigt, wie Dateien umbenannt würden, ohne Änderungen vorzunehmen. |
| `--force`    | `--force`    | Erzwingt das Überschreiben von Dateien.                          |
| `--preview`  | `--preview`  | Zeigt eine Vorschau der neuen Dateinamen.                        |

---

## **6. Logging und Debugging**
Optionen, um die Protokollierung und Fehlerbehebung zu steuern:

| **Kurzform** | **Langform**   | **Beschreibung**                                               |
|--------------|----------------|--------------------------------------------------------------|
| `-q`         | `--quiet`      | Unterdrückt alle Ausgaben außer Fehlern.                      |
| `-d`         | `--debug`      | Zeigt Debugging-Informationen an.                             |
| `-l`         | `--log-level`  | Setzt das Log-Level (`DEBUG`, `INFO`, `WARNING`, `ERROR`).    |
| `--log-file` | `--log-file`   | Gibt eine Datei an, in der Logs gespeichert werden.           |

---

## **7. Mehrsprachigkeit**
Falls Mehrsprachigkeit unterstützt wird:

| **Kurzform** | **Langform**  | **Beschreibung**                                               |
|--------------|---------------|--------------------------------------------------------------|
| `--lang`     | `--language`  | Sprache des Tools einstellen (`en`, `de`, usw.).              |


# Ziel: Eigenständige, ausführbare Datei

Das langfristige Ziel des Projekts ist die Bereitstellung von **Mediatool** als **All-in-One Binary**, die unabhängig von externen Abhängigkeiten direkt auf verschiedenen Systemen ausgeführt werden kann. Dafür wird eine Bündelung aller Module und Abhängigkeiten in eine einzelne ausführbare Datei durchgeführt.

---

## **Technische Umsetzung**

### **1. Python-Binary-Konverter**
- Tools wie **PyInstaller**, **cx_Freeze** oder **py2exe** werden verwendet, um das gesamte Python-Projekt in eine ausführbare Datei umzuwandeln.

### **2. Plattformübergreifend**
- Das Binary wird in erster Linie für **Linux** erstellt, mit möglichen Erweiterungen für **Windows** und **macOS**.

### **3. Ohne externe Abhängigkeiten**
- Alle Python-Bibliotheken sowie externe Tools wie **ffmpeg**, **7z** oder **unrar** werden in das Binary integriert.

---

## **Vorteile der Binary-Lösung**

### **1. Einfachheit**
- Nutzer:innen müssen nur die Binary herunterladen und ausführen, ohne zusätzliche Abhängigkeiten oder Installationen vorzunehmen.

### **2. Portabilität**
- Das Tool kann auf verschiedenen Systemen eingesetzt werden, ohne Änderungen an der Umgebung vorzunehmen.

### **3. Sicherheit**
- Alle kritischen Module und Abhängigkeiten sind gebündelt und vor Manipulation geschützt.

---

## **Geplante Schritte für die Binary-Erstellung**

### **1. Modulare Entwicklung**
- Alle Funktionen werden zunächst als separate Module implementiert, um die Modularität und Testbarkeit sicherzustellen.

### **2. Bündelung mit PyInstaller**
- Sobald die Module fertiggestellt sind, wird das gesamte Projekt mit einem Tool wie PyInstaller in ein Binary umgewandelt:
  ```bash
  pyinstaller --onefile mediatool.py
  ```

### **3. Test der Binary**
- Die generierte Binary wird auf verschiedenen Linux-Systemen getestet, um sicherzustellen, dass alle Funktionen wie erwartet arbeiten.

### **4. Optimierung und Größe**
- Unnötige Dateien und Abhängigkeiten werden entfernt, um die Größe der Binary zu minimieren.
