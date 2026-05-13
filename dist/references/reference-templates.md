# Reference Templates — Scaffolding-Muster für Reference-Dateien

Dieses Dokument dient als Vorlage für den Skill-Engineer in **Phase 3 (Skill Output)**, wenn Reference-Dateien für neue Skills erstellt werden. Wähle das passende Template basierend auf dem Dateityp.

🇬🇧 *This document is bilingual. English instructions below each German section.*

## Datei-Typen und empfohlene Strukturen

| Typ | Wann verwenden | Empfohlene Struktur | Statisch/Dynamisch |
|:---|:---|:---|:---|
| **Entscheidungsbaum** | Regeln mit Wenn/Dann-Logik (≥3 Verzweigungen) | Mermaid-Diagramm + Bedingungstabelle | Statisch |
| **Entscheidungsbaum** | Triviale lineare Logik (≤2 Verzweigungen) | Inline-Text oder kurze Tabelle | Statisch |
| **Inventar/Liste** | Persistente, wachsende Daten | Tabelle mit Status-Spalte + Pflegeregeln | 🔄 Dynamisch |
| **Checkliste** | Validierung vor Output | Kopierbare ☐-Liste + Schnell-Check-Block | Statisch |
| **Template** | Wiederholbare Output-Formate | Wireframe/Skeleton + Variablen-Markierung | Statisch |
| **Workflow/Script** | Mehrstufige Prozesse | Nummerierte Schritte + Entscheidungspunkte | Statisch |

---

## Template 1: Entscheidungsbaum (Mermaid)

Verwende Mermaid für Entscheidungsbäume mit ≥3 Verzweigungen. Mermaid ist sowohl für User (visuelles Rendering) als auch für LLMs (strukturierte Syntax) optimal lesbar.

```markdown
# [Titel] — Entscheidungsbaum

> Beschreibung: [Wann und warum dieses Dokument konsultiert wird]

## Entscheidungslogik

‍```mermaid
graph TD
    START["Ausgangsfrage?"] -->|"Bedingung A"| A["Aktion A"]
    START -->|"Bedingung B"| B["Aktion B"]
    START -->|"Bedingung C"| C{"Unter-Entscheidung?"}
    C -->|"Ja"| C1["Aktion C1"]
    C -->|"Nein"| C2["Aktion C2"]
‍```

## Bedingungstabelle

| Bedingung | Erfüllt? | Aktion |
|:---|:---|:---|
| [Bedingung A] | ☐ | [Aktion A] |
| [Bedingung B] | ☐ | [Aktion B] |
```

---

## Template 2: Dynamisches Inventar (Living Document)

Für Dateien, die im laufenden Betrieb wachsen (Keyword-Listen, Negativkeywords, Asset-Inventare etc.).

**Pflicht-Elemente:** Datum, Pflegeregeln, Status-Tracking.

```markdown
# [Titel] — [Kontext]

> Letzte Aktualisierung: [YYYY-MM-DD]
> Status: [Planungsphase / Aktiv / Archiviert]
> ⚠️ Diese Datei wird [wöchentlich/monatlich] aktualisiert.

## [Hauptkategorie]

| # | Eintrag | Status | Hinweis |
|---|:---|:---|:---|
| 1 | [Eintrag 1] | ✅ Aktiv | [Kommentar] |
| 2 | [Eintrag 2] | ⏳ In Prüfung | [Kommentar] |
| 3 | [Eintrag 3] | 🔲 Geplant | [Kommentar] |

## Pflegeregeln

1. **Wann aktualisieren:** [Trigger beschreiben]
2. **Wer aktualisiert:** [Agent/Nutzer/Automatisch]
3. **Wie hinzufügen:** [Format für neue Einträge]
4. **Wie entfernen:** [Bedingung für Löschung/Archivierung]
```

---

## Template 3: Checkliste (Validierung)

Für Compliance-Prüfungen, Quality Gates, Pre-Flight-Checks.

```markdown
# [Titel] — Checklist

> Jeder Output des [skill-name] Skills MUSS gegen diese Checklist validiert werden.

## [Kategorie 1]

| Prüfpunkt | Anforderung |
|:---|:---|
| [Punkt 1] | [Anforderung] |
| [Punkt 2] | [Anforderung] |

## Schnell-Check (Copy & Paste)

‍```
Compliance-Check:
☐ [Punkt 1]?
☐ [Punkt 2]?
☐ [Punkt 3]?
‍```
```

---

## Template 4: Workflow/Script

Für mehrstufige Prozesse, die der Agent Schritt für Schritt durchlaufen soll.

```markdown
# [Titel] — [Frequenz]-Workflow

> Dieser Workflow wird [wöchentlich/bei Trigger X] durchgeführt.
> Ziel: [Kurzbeschreibung des Ergebnisses]

## Wann durchführen?

- **Frequenz:** [Wöchentlich / Bei Event X / Auf Anfrage]
- **Mindest-Datenbasis:** [Bedingung, ab wann der Workflow sinnvoll ist]

## Schritt-für-Schritt

### Schritt 1: [Aktion]
[Beschreibung]

### Schritt 2: [Klassifizierung/Entscheidung]

| Kategorie | Aktion | Beispiel |
|:---|:---|:---|
| 🟢 [Positiv] | [Aktion] | [Beispiel] |
| 🟡 [Neutral] | [Aktion] | [Beispiel] |
| 🔴 [Negativ] | [Aktion] | [Beispiel] |

### Schritt 3: [Dokumentation]
[Wie werden Ergebnisse festgehalten?]

## Warnsignale

| Signal | Diagnose | Maßnahme |
|:---|:---|:---|
| [Signal] | [Ursache] | [Gegenmaßnahme] |
```

---

## Template 5: Statische Referenz (Kompakt)

Für Frameworks, Design-Regeln, API-Spezifikationen, die sich selten ändern.

```markdown
# [Titel]

> [1-Satz-Beschreibung des Zwecks]

## [Hauptsektion]

| Parameter | Wert | Hinweis |
|:---|:---|:---|
| [Key] | [Value] | [Kommentar] |

## Regeln

1. [Regel 1]
2. [Regel 2]
```

---

## Allgemeine Regeln für Reference-Dateien

1. **Max. 200 Zeilen** pro Datei. Wenn länger: Aufteilen in mehrere Dateien.
2. **Eigenständig nutzbar:** Jede Datei muss ohne Kontext der Haupt-SKILL.md verständlich sein.
3. **Relative Links:** Zwischen Reference-Dateien immer relative Markdown-Links nutzen (z.B. `[Negativkeywords](negative-keywords.md)`).
4. **Mermaid für Entscheidungsbäume** mit ≥3 Verzweigungen. ASCII nur für triviale lineare Abläufe (≤2 Schritte).
5. **Dynamische Dateien** immer mit Aktualisierungsdatum und Pflegeregeln versehen.
