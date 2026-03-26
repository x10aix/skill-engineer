# Skill Engineer: Evaluation Schema (Benchmarks)

Um die operative Reife des `skill-engineer` messbar zu machen, dient dieses 10-Punkte Bewertungsschema. Jeder durch den Engineer generierte oder auditierte Ziel-Skill muss gegen dieses Raster getestet werden (Regression Test).

## Scoring-Matrix (Maximal 10 Punkte)

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

---

## Regression-Test Protokoll
Wann immer das `SKILL.md` Template im Repository geupdatet wird, müssen drei Benchmark-Skills neu generiert und bewertet werden:
1. Ein trivialer Converter (CSV zu JSON) -> Muss Modus D triggern (Erwarteter Score: 8/10, da Stateful = N/A).
2. Ein komplexer Fach-Agent (z.B. Brand-Voice) -> Muss Modus A triggern (Erwarteter Score: 10/10).
3. Ein Audit eines fehlerhaften Alt-Skills -> Muss Modus C triggern und fehlende Anti-Halluzination erkennen.
