# Skill Engineer: Evaluation Schema (Benchmarks)

Um die operative Reife des `skill-engineer` messbar zu machen, dient dieses 10-Punkte Bewertungsschema. Jeder durch den Engineer generierte oder auditierte Ziel-Skill muss gegen dieses Raster getestet werden (Regression Test).

## Scoring-Matrix (Maximal 13 Punkte)

### A. Architektonische Reinheit (0 - 3 Punkte)
- **[1 Punkt] Native XML-Tags:** Nutzt der Ziel-Skill `<operational_rules>` oder ähnliche harte Trenner statt Prosa-Anweisungen?
- **[1 Punkt] Mechanik statt Adjektive:** Ist die Persona frei von "Du bist ein hilfreicher Assistent" und nutzt stattdessen Handlungsdirektiven ("Zweifle jede Aussage an")?
- **[1 Punkt] Plattform-Agnostik:** Ist das Format neutral genug, um sowohl z.B. in Antigravity als auch in Cursor geladen zu werden (YAML-Frontmatter)?

### B. Anti-Halluzination & Sicherheit (0 - 4 Punkte)
- **[1 Punkt] Environment Check:** Zwingt der Skill den Agenten, seine Tools (z.B. Dateisystem, Web-Search) in Schritt 1 zu verifizieren?
- **[1 Punkt] Self-Correction:** Ist ein zwingender `Chain-of-Thought` (z.B. `<self_audit>`) vor der finalen Ausgabe eingebaut?
- **[1 Punkt] Harte Tabus:** Gibt es eine explizite Verbotsliste ("Darf niemals X tun")?
- **[1 Punkt] Referenz-Warnung:** Sind unerprobte Frameworks oder Personen mit `<!-- UNBESTÄTIGT -->` markiert?

### C. Developer Experience (0 - 3 Punkte)
- **[1 Punkt] Zero-Shot Triggering:** Ist die `description` des Skills so scharf, dass die IDE ihn im richtigen Moment automatisch lädt, ohne False-Positives auszulösen?
- **[1 Punkt] Few-Shot Beispiel:** Enthält der Skill ein konkretes Vorher/Nachher-Input-Beispiel für das LLM?
- **[1 Punkt] Stateful / Stateless Korrektheit:** Wurde für einen trivialen Werkzeug-Skill auf eine Setup-Phase verzichtet (Stateless), oder wurde ein komplexer Meta-Agent korrekt mit einem `STATUS: UNCONFIGURED` Block (Stateful) versehen?

### D. Ökosystem-Integration & Wartbarkeit (0 - 3 Punkte)
- **[1 Punkt] Cross-Skill-Delegation:** Werden Teilaufgaben an spezialisierte Nachbar-Skills delegiert (mit Briefing- und Rückgabeformat), statt alles monolithisch zu lösen?
- **[1 Punkt] Reference-Schnitt:** Ist jede Reference-Datei eigenständig nutzbar und nicht >200 Zeilen? Werden Mermaid-Diagramme (statt ASCII) für Entscheidungsbäume mit ≥3 Verzweigungen verwendet?
- **[1 Punkt] Update-Fähigkeit:** Enthalten dynamische Reference-Dateien (Listen, Inventare, Logs) ein Aktualisierungsdatum, Pflegeregeln und Status-Tracking (✅/⏳/🔲)?

---

## Regression-Test Protokoll
Wann immer das `SKILL.md` Template im Repository geupdatet wird, müssen vier Benchmark-Skills neu generiert und bewertet werden:
1. Ein trivialer Converter (CSV zu JSON) -> Muss Modus D triggern (Erwarteter Score: 9/13, da Stateful und Delegation = N/A).
2. Ein komplexer Fach-Agent (z.B. Brand-Voice) -> Muss Modus A triggern (Erwarteter Score: 13/13).
3. Ein Audit eines fehlerhaften Alt-Skills -> Muss Modus C triggern und fehlende Anti-Halluzination erkennen.
4. Ein Skill aus Legacy-Dokument (z.B. Strategiepapier) -> Muss Modus E triggern und korrekt in die SKILL.md-Architektur übersetzen.
