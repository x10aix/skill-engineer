# Changelog: Skill-Engineer

Dieses Dokument verfolgt den strukturierten Versionsverlauf des Skill-Engineers basierend auf den Commits, seitdem die Entwicklung über Agent-First IDEs (insbesondere Antigravity) skaliert wurde.

---

### [Latest] März 27, 2026
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
