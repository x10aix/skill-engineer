# Skill-Engineer: Architektur & Funktionsweise

**Version:** 3.1 (Stateful Design, Native XML-Tags, Anti-Halluzination)

🇬🇧 [Read in English](README.md)

⚠️ **CRITICAL WARNING:** This Skill is designed EXCLUSIVELY for Agent-First IDEs with file-system access (Antigravity, Cursor, Claude Code). Do **NOT** use in generic Web-Chats (ChatGPT, Claude.ai, Gemini Advanced). The core "Stateful Setup Phase" requires local write permissions to physically rewrite the `SKILL.md` file.

## Supported Platforms (Profiles)
- **Google Antigravity:** Native Support. (Perfect match for YAML-Frontmatter & Progressive Disclosure).
- **Cursor IDE:** Native Support. (Agents correctly read XML tags and execute the 4-Phase routing).
- **Claude Code / Root CLIs:** Native Support. (The Dedup-Scan is restricted to local queries to prevent runaway `find /` commands).

---

Der *Skill-Engineer* ist ein Meta-Agent. Er dient nicht dazu, dem Endnutzer direkt bei einer Fachaufgabe zu helfen, sondern er entwickelt, auditiert und konfiguriert andere Agenten (Skills). Er zwingt das zugrundeliegende LLM zu methodischer Strenge, eliminiert generische Floskeln und verhindert "Yes-Man"-Verhalten.

> **Credits & Architektur:** Die Implementierung der *"Progressive Disclosure Architektur"* (Auslagern von Kontext in `references/` und `scripts/` zur Schonung des Context Windows) beruht maßgeblich auf den Konzepten des **Skill-Creator** von **Clawdbot** (Entwickler: Peter Steinberger).

---

## 1. Die Setup-Phase (Stateful Configuration)
Der Skill-Engineer ist ein **Stateful Agent**. Er besitzt einen `<configuration>`-Block direkt in seinem eigenen Code.

* **Bei Erststart (`STATUS: UNCONFIGURED`):** 
  Der Agent blockiert alle anderen Workflows. Er liest seine aktuelle Laufzeit aus (z.B. Plattform = Antigravity, LLM = Gemini, Sprache = Deutsch) und schlägt diese als System-Defaults vor. Bestätigt der Nutzer, nutzt der Agent seine Dateisystem-Rechte, um den Block in seiner eigenen `SKILL.md` physisch auf `CONFIGURED` umzuschreiben.
* **Im Normalbetrieb (`STATUS: CONFIGURED`):**
  Der Agent fragt den Nutzer nicht mehr nach Parametern (Ziel-LLM, Plattform etc.), sondern wendet seine fest verdrahteten Defaults stillschweigend als Gesetz an. Das spart Tokens und reduziert die Nutzer-Friktion dramatisch.
* **Befehl `/config`:**
  Der Nutzer kann jederzeit `/config` tippen, um die gespeicherten Defaults im Dateisystem überschreiben zu lassen.

---

## 2. Der Umgebungs-Scan (Dedup-Prüfung)
Bevor der Agent mit der Generierung beginnt, durchsucht er den aktuellen Projekt-Workspace und das globale Tools-Verzeichnis.
* Findet er bereits einen thematisch ähnlichen Skill (z.B. einen bestehenden `csv-converter`), pausiert er.
* Er gibt eine kurze Gegenüberstellung aus und stellt die **Stand-Alone Dedup-Frage**: *"Sollen wir den existierenden Skill editieren (Modus C), ihn klonen/anpassen, oder komplett neu starten?"*
* Dies verhindert unkontrolliertes Skill-Wachstum und Redundanz.

---

## 3. Die 4 Betriebs-Modi (Input-Routing)
Gibt es kein Dedup-Problem (oder der Nutzer wünscht explizit einen Neubau), greift das intelligente Routing:

1. **Modus A (Leere Leinwand):** Der Nutzer hat nur eine grobe Idee. Der Agent startet das vollständige 7-Fragen-Interview.
2. **Modus B (Vorarbeit vorhanden):** Der Nutzer liefert ein Dokument (z.B. Company Guidelines). Der Agent führt eine harte **Gap-Analyse** durch. Zeigt der Nutzer Floskeln ("Zielgruppe: Alle"), weist der Agent das als ungültig ab und hakt nach, bis die genaue funktionale Mechanik geklärt ist.
3. **Modus C (Audit / Edit):** Für bestehende Skills.
   * **C-Audit:** Der Agent prüft einen Alt-Skill gegen das 9-Punkte-Qualitätsgate und legt einen Report vor, bevor er den Code anfasst.
   * **C-Edit:** Der Agent führt eine definierte Detailänderung in einer Alt-Datei sofort aus (z.B. "Füge Regel X hinzu") und prüft nur den geänderten Bereich.
4. **Modus D (Quick Draft):** Der Bypass. Wenn der Skill trivial ist (z.B. ein reines Werkzeug wie "Formatierer für Git-Commits"), überspringt der Agent das Interview und die Persona-Definition komplett und wirft sofort ein Light-Template aus.

---

## 4. Adversarial Validation (Self-Doubt)
Der Skill-Engineer ist programmiert, sich nicht sofort zufrieden zu geben.
Bevor er in Phase 3 den finalen Skill generiert (Strategie-Vorschlag), muss er zwingend einen **Gegeneinwand (Veto)** gegen seinen eigenen Ansatz formulieren. 
Gibt es keine logische Schwachstelle, muss er stattdessen den gefährlichsten operativen **Edge Case** benennen, an dem der zukünftige Ziel-Skill voraussichtlich scheitern könnte.

---

## 5. Das 9-Punkte-Qualitätsgate
Bevor der Skill-Engineer einen Ziel-Skill herausgibt, jadt er ihn im Hintergrund (oder im Audit reportiert an den Nutzer) durch diese Checkliste:

1. Keine Floskeln ("Du bist ein Experte")
2. Mechanik statt Adjektive (Positiv- und Negativ-Beispiele statt dem Wort "hilfreich")
3. Tabus vorhanden
4. Workflow ausführbar
5. Beispiel (Few-Shot) vorhanden
6. Triggering präzise definiert
7. Plattform-Konformität (YAML-Frontmatter etc.)
8. Referenzen validiert
9. **Anti-Halluzination by Design** *(Neu)*

### Deep-Dive: Die Anti-Halluzinations-Mechanik
Ein Skill, der Dinge erfindet oder unbelegte Annahmen trifft, ist toxisch. Das 9. Qualitätsgate erzwingt:
* **Tool-Validierung:** Setzt der Ziel-Skill Tools wie E-Mail-APIs voraus? Dann zwingt der Skill-Engineer den Agenten, einen Environment-Check als Schritt 1 in seinen Workflow einzubauen.
* **Verbotene Frameworks:** Alle genannten Frameworks, APIs und Personen müssen real recherchiert sein. Fehlt ein Such-Tool, bekommen sie den Hard-Tag `<!-- UNBESTÄTIGT -->`.
* **Vererbte Self-Correction:** Komplexere Ziel-Skills bekommen vom Engineer eine Regel injiziert, die sie zwingt, als letzten Schritt (Double-Check) ihren eigenen Output kritisch gegen die schärfsten Tabus und typischen Fehlerquellen *dieses spezifischen Skills* zu prüfen, bevor er an den Nutzer geht.

---

*(Dieses Dokument ist eine automatisch generierte Systembeschreibung des Agenten)*
