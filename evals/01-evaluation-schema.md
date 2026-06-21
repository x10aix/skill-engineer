# Skill Engineer: Evaluation Schema (Benchmarks)

> [!NOTE]
> Das kanonische Scoring-Schema (17 Punkte, Version 2.0) liegt in:
> `skills/core/internal/skill-benchmarker/references/scoring-schema.md`
>
> Dieses Dokument enthält das Regression-Test-Protokoll und verweist auf das Schema.
> Der `skill-benchmarker` liest das Schema direkt aus seiner `references/`-Datei.

Letztes Update: 2026-06-21 | Schema-Version: 2.0 (17 Punkte)

---

## Scoring-Übersicht (17 Punkte)

| Dim | Kategorie | Max | Neu in v2.0 |
|---|---|---|---|
| A | Architektonische Reinheit | 3 | — |
| B | Anti-Halluzination & Faktentreue | 4 | Umbenannt |
| C | Developer Experience | 3 | — |
| D | Ökosystem & Wartbarkeit | 3 | — |
| **E** | **Discoverability** | **2** | ✅ Neu |
| **F** | **Security** | **2** | ✅ Neu (mit -1 Straf-Punkt) |
| | **Gesamt** | **17** | |

Details zu jedem Kriterium → `skills/core/internal/skill-benchmarker/references/scoring-schema.md`

### Wichtige Regeln (Kurzfassung)
- **0-Punkte-Warnung:** Jede Dimension mit 0 Punkten → ⚠️ WARNING (automatisch)
- **Security = 0:** → 🚨 CRITICAL (Skill darf nicht published werden)
- **Security = -1:** Gefährliches Verhalten erkannt → 🚨 CRITICAL + Straf-Punkt
- **PASS-Schwelle:** ≥ 14/17, kein CRITICAL, kein Security = 0

---

## Regression-Test Protokoll

Wann immer das `SKILL.md`-Template des `skill-engineer` geupdatet wird, müssen diese vier Szenarien mit dem `skill-benchmarker` neu bewertet werden:

| # | Skill-Typ | Erwarteter Modus | Erwarteter Score |
|---|---|---|---|
| 1 | Trivialer Converter (CSV → JSON) | Modus D | ≥ 12/17 (D.1 + E.2 als N/A) |
| 2 | Komplexer Fach-Agent (z.B. Brand-Voice) | Modus A | ≥ 15/17 |
| 3 | Fehlerhafter Alt-Skill (fehlendes Anti-Halluzinations-System) | Modus C-Audit | B: 0–1 Pkt → ⚠️ WARNING |
| 4 | Skill mit hardcodierten absoluten Pfaden | Modus C-Audit | A: Verlust 1 Pkt, F prüfen |
