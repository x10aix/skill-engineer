# Beispiel: Skill-Erstellung von der Idee zur SKILL.md

Dieses Beispiel zeigt eine vollständige Skill-Engineer-Session im Modus B
(Vorarbeit vorhanden). Eigene Beispiele können hier ergänzt werden.

---

## Input (Nutzer-Anfrage)

> "Ich brauche einen Skill, der Meeting-Protokolle aus rohen Notizen erstellt.
> Der Nutzer gibt unstrukturierten Text rein, der Skill soll ein sauberes
> Markdown-Protokoll mit Beschlüssen und Action Items rausgeben."

---

## Skill-Engineer Gap-Analyse (intern)

Mapping gegen Interview-Raster:

| Frage | Status | Befund |
|-------|--------|--------|
| Kernaufgabe | ✅ | Klar: Roh-Notizen → strukturiertes Markdown-Protokoll |
| Ziel-Nutzer | ❌ | Fehlt: Wer schreibt die Notizen? PM, Führungskraft, Entwickler? |
| Ambiguität | ❌ | Fehlt: Was tut der Skill bei unlesbaren/unvollständigen Notizen? |
| Tabus | ❌ | Fehlt: Darf der Skill eigene Inhalte hinzufügen? |
| Erfolgsmetrik | ⚠️ | "Sauber" ist zu vage — was ist das konkrete Format? |
| Abgrenzung | ✅ | Klar: Kein freies Schreiben, nur Strukturierung |
| Vorbilder | — | Nicht relevant |

**Rückfragen (2 offen geblieben):**

> 1. Wer schreibt die Notizen typischerweise — und in welcher Sprache?
> 2. Was tut der Skill, wenn eine Action Item keinen Owner hat?

**Nutzer antwortet:**
> "Führungskräfte auf Deutsch. Wenn kein Owner: `[OFFEN]` als Platzhalter."

---

## Output (fertige SKILL.md)

```markdown
---
name: meeting-notes-formatter
description: >
  Wandelt unstrukturierte Meeting-Notizen in ein standardisiertes
  Markdown-Protokoll mit Beschlüssen und Action Items um. Trigger:
  "Protokoll erstellen", "Notizen strukturieren", "Meeting zusammenfassen",
  rohe Stichpunkte oder Audio-Transkripte als Input.
---

# Meeting Notes Formatter

## Use this skill when
- Der Nutzer gibt rohe Stichpunkte, Fließtext oder ein Audio-Transkript
  eines Meetings ein und erwartet ein strukturiertes Protokoll.

## Do not use this skill when
- Der Nutzer ein Meeting aus dem Gedächtnis neu verfassen soll (kein Input-Material).
- Es sich um eine Zusammenfassung ohne Action Items handelt (→ anderer Skill).

## <role_definition>
Du bist ein Protokoll-Strukturierer, kein Redakteur. Du erzeugst
Markdown-Protokolle ausschließlich aus dem gegebenen Input — du erfindest
keine Beschlüsse, Namen oder Aufgaben, die nicht im Input stehen.
Fehlende Owner werden mit `[OFFEN]` markiert, nicht erraten.

## <operational_rules>
- NIEMALS eigene Inhalte hinzufügen, die nicht im Input stehen.
- IMMER fehlende Action-Item-Owner als `[OFFEN]` markieren.
- NIEMALS das Protokoll ausgeben, bevor alle Action Items extrahiert wurden.
- IMMER auf Deutsch ausgeben, unabhängig von der Sprache des Inputs.

## <process_workflow>
1. **Scan:** Lies den gesamten Input ohne Ausgabe.
2. **Extraktion:** Identifiziere: Teilnehmer, Datum/Uhrzeit (falls vorhanden),
   Beschlüsse, Action Items (Was / Wer / Bis wann).
3. **Strukturierung:** Erstelle das Protokoll im Output-Format.
4. **Vollständigkeits-Check:** Ist jeder Beschluss abgedeckt?
   Jedes Action Item mit Owner oder `[OFFEN]` versehen?

## <output_standards>
Siehe [`../examples/example-skill-creation.md`](../examples/example-skill-creation.md)
für ein Input→Output-Beispiel.

**Protokoll-Format:**

---
**Meeting-Protokoll**
📅 Datum: [Datum]
👥 Teilnehmer: [Namen]

### Beschlüsse
- [Beschluss 1]

### Action Items
| Aufgabe | Owner | Deadline |
|---------|-------|----------|
| [Aufgabe] | [Name / OFFEN] | [Datum / –] |
---
```

---

## Qualitätsgate-Ergebnis (automatisch nach Generierung)

| # | Kriterium | Status |
|---|---|---|
| 1 | Keine Floskeln | ✅ |
| 2 | Mechanik statt Adjektive | ✅ |
| 3 | Tabus vorhanden | ✅ (3 NIEMALS-Regeln) |
| 4 | Workflow ausführbar | ✅ |
| 5 | Beispiel vorhanden | ✅ (Verweis auf examples/) |
| 6 | Triggering präzise | ✅ |
| 7 | Plattform-Konformität | ✅ |
| 8 | Referenzen validiert | ✅ (keine) |
| 9 | Anti-Halluzinations-Check | ✅ |
| 10 | Dependency-Check | ✅ (keine requires:) |
