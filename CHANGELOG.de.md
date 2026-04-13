# Changelog: Skill-Engineer

Dieses Dokument verfolgt den strukturierten Versionsverlauf des Skill-Engineers basierend auf den Commits, seitdem die Entwicklung über Agent-First IDEs (insbesondere Antigravity) skaliert wurde.

---

### [Latest] April 13, 2026
**Version 4.0 — „Ecosystem-Aware" Update**

Sieben praxisbasierte Verbesserungen, abgeleitet aus realen Beobachtungen während der Erstellung des `google-ads-manager` Skills. Der Skill-Engineer versteht jetzt Skill-Ökosysteme, nicht nur einzelne Skills.

* `5e5ffdc` - **feat**: **Modus E (Regeneration)** — Existierende Planungsdokumente, SOPs, Prozessdokumente oder Wissensbasen in produktionsreife SKILL.md-Pakete umwandeln. Unterschied zu Modus B: Modus E verarbeitet *unstrukturiertes Domänenwissen*, keine Skill-Entwürfe.
* `5e5ffdc` - **feat**: **Ökosystem-Mapping** in Phase 0 — Der Agent scannt nun ALLE existierenden Skills im Workspace, um Delegations-Partner, Trigger-Konflikte und neutrale Beziehungen zu identifizieren.
* `5e5ffdc` - **feat**: **Benchmark-Scan** (Phase 0.5, optional) — Für komplexe Skills kann der Agent externe Lösungen (SaaS-Tools, Open-Source-Skills, Prompt-Templates) recherchieren, um Must-Have-Features und USPs zu identifizieren.
* `5e5ffdc` - **feat**: **Cross-Skill-Delegations-Muster** in Phase 3 — Bei Delegation von Teilaufgaben injiziert der Engineer ein standardisiertes Briefing-/Rückgabeformat-Muster in die `<operational_rules>` des generierten Skills.
* `5e5ffdc` - **feat**: **Interview auf 10 Metriken erweitert** (von 8) — Metrik 8 aufgeteilt in Statische (8a) vs. Dynamische Referenzen (8b). Neue Metrik 9: Delegation. Neue Metrik 10: Benchmark-Lücken.
* `5e5ffdc` - **feat**: **Qualitätsgate erweitert** um 3 neue Checks: Ökosystem-Integration, Referenz-Qualität (max 200 Zeilen, Mermaid für Entscheidungsbäume ≥3 Verzweigungen), Diagramm-Qualität.
* `5e5ffdc` - **docs**: Neue Reference-Datei `references/reference-templates.md` mit 5 Scaffolding-Mustern (Entscheidungsbaum/Mermaid, Dynamisches Inventar, Checkliste, Workflow, Statische Referenz).
* `5e5ffdc` - **feat**: **Evaluation-Schema** auf 13 Punkte erweitert (von 10) mit neuer Kategorie D: Ökosystem-Integration & Wartbarkeit. 4. Regression-Test für Modus E hinzugefügt.

---

### März 27, 2026
**Commits: Claude's Feedback & Final Polish**
* `tbd` - **feat**: Feinjustierung des Qualitätsgates (Re-Integration von Triggering- und Referenzprüfungen), klarere Definition der C-Audit/C-Edit-Trennung sowie die Einführung einer externen `anti-hallucination-checklist.md` unter Einhaltung des Progressive-Disclosure-Prinzips.

**Commits: Internationalisierung & Workflow-Automatisierung**
* `212a6f3` - **feat**: Übersetzung von `README.md` und `SKILL.md` auf Englisch für die globale Open-Source Community. Die ursprünglichen deutschen Versionen sind weiter als `*.de.md` verfügbar und über Badges verlinkt.
* `212a6f3` - **feat**: Einführung des `.agents/workflows/publish.md` Antigravity-Workflows. Dieser automatisiert den Release-Prozess, indem er lokal geänderte `<configuration>`-Blöcke vor jedem Push sicher auf `UNCONFIGURED` (Werkseinstellungen) zurücksetzt.

---

### März 26, 2026
**Commits: The "Productization" Update**
* `dcab64d` - **docs**: Hinzufügung des *Hetzner OpenClaw* Audit-Beispiels. Zeigt in der Praxis, wie der Agent bei Legacy-Skills eine knallharte Gap-Analyse durchführt.
* `b992a06` - **docs**: Produktisierung des Repositories. Das Projekt wurde von einem reinen Skript in ein strukturiertes Produkt-Repository überführt – inklusive klarer Evaluierungsschemata und Best-Practice Beispielen für das Prompt-Design.

---

### März 25, 2026
**Commits: Open-Source Release & Plattform-Synthese**
* `66969d6` - **docs**: Nativer Einbau der README-Ausgabe direkt im `SKILL.md` System. Der Agent wird gezwungen, seine eigene Dokumentation zu verwalten.
* `49d8fd2` - **Initial commit**: Der offizielle Open-Source Release auf GitHub. Der Skill-Engineer ist ab sofort bereit für den Einsatz in Antigravity, Cursor und Claude Code.
* `2ff6b3c` - **docs**: Veröffentlichung der detaillierten Entwicklungs-Historie. Dokumentation der konzeptionellen Übergangsphase von isolierten Chat-Prompts hin zu einem vernetzten, zustandsbasierten Meta-Agenten.
