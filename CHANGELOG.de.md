# Changelog: Skill-Engineer

Dieses Dokument verfolgt den strukturierten Versionsverlauf des Skill-Engineers basierend auf den Commits, seitdem die Entwicklung über Agent-First IDEs (insbesondere Antigravity) skaliert wurde.

---

### [Latest] 21. Juni 2026
**Version 1.3.0 — „Skill-Benchmarker & Quality Gate 2.0" Release**

* `tbd` - **feat**: **Neuer Skill: `skill-benchmarker`** — Eigenständiger Bewertungsagent mit 17-Punkte-Scoring-Schema zur objektiven Evaluierung beliebiger SKILL.md-Dateien. Erzeugt strukturierte `BENCHMARK.md`-Reports mit Kriterien-Scores, qualitativen Anmerkungen und abschließendem Gesamturteil.
* `tbd` - **feat**: **`skill-engineer` v5.0** — Quality Gate auf 12 Pflicht-Kriterien erweitert, inklusive zwei neuer Dimensionen: Discoverability (Trigger-Präzision, klare Abgrenzung) und Security (Secret-Handling, Privilege-Escalation-Prävention).
* `tbd` - **feat**: **`skill-mapper` v2.0** — Domain-Awareness eingeführt. Der Mapper liest jetzt eine `skill-mapper-config.json` für Domain-Gruppierungsregeln und erzeugt neben der zentralen `ECOSYSTEM.md` separate domänenspezifische Maps.
* `tbd` - **feat**: **Scoring-Schema v2.0** — 17-Punkte-Evaluierungsschema (erweitert von 13). Enthält einen Retrofit-Hinweis-Abschnitt für die schrittweise Modernisierung von Legacy-Skills sowie eine präzise Neudefinition von Kriterium B.4 (Statelessness vs. Statefulness).
* `tbd` - **docs**: **README.md v5.0** — Vollständig aktualisiert, um das neue Skill-Trio (skill-engineer, skill-mapper, skill-benchmarker) und das v2.0-Scoring-Framework abzubilden.

---

### [Latest] June 3, 2026
**Version 4.5 — "Dependency-Aware Quality Gate" Update**

* `tbd` - **feat**: **Dependency System** — Skills können jetzt `requires:` im YAML-Frontmatter deklarieren. Der Skill-Engineer gibt eine WARNING aus, wenn eine Dependency fehlt — kein harter Abbruch, da Skills auch ohne Sub-Skills nutzbar sein können.
* `tbd` - **feat**: **Quality Gate Kriterium #10 (Dependency-Check)** — Neues Pflicht-Kriterium im Qualitätsgate: Prüft, ob externe Datei- oder Skill-Referenzen im `requires:`-Feld deklariert sind und ob `<process_workflow>` Schritt 1 einen Environment Check mit WARNING enthält.
* `tbd` - **feat**: **Pfad-Portabilität als Blocker (Anti-Hall #6)** — Neue Prüfregel in der Anti-Halluzinations-Checkliste: Absolute Pfade (`C:\...`) und workspace-spezifische Pfade (`.agents/...`) in Skill-Instruktionen sind ein Blocker und müssen durch relative Pfade ersetzt werden.
* `tbd` - **fix**: **Kriterium #2 bullet-proof** — Die "Mechanik statt Adjektive"-Regel definiert jetzt die Klasse der verbotenen Wörter ("jedes Wort, das man weglassen könnte, ohne das Verhalten zu ändern") statt nur Beispielwörter aufzulisten.
* `tbd` - **fix**: **Framework-Verifikation präzisiert** — Etablierte Modelle (AIDA, SWOT, OKR, MECE) gelten als verifiziert. Nur nischige oder personenbezogene Frameworks benötigen Recherche und Nutzer-Bestätigung.
* `tbd` - **fix**: **Filesystem-Conditional** — `write_to_file` in Schritt 0 hat jetzt einen expliziten Fallback für Plattformen ohne Filesystem-Zugriff: Konfiguration als Code-Block ausgeben.
* `tbd` - **fix**: **Stale Criterion Count** — Referenz auf "8 Kriterien" in Schritt C1 auf 10 korrigiert.
* `tbd` - **docs**: **Externes Beispiel** — `examples/example-skill-creation.md` hinzugefügt: vollständige Session (Modus B) von der Nutzer-Anfrage bis zur fertigen SKILL.md inkl. Qualitätsgate-Ergebnis. Weitere Beispiele können ergänzt werden.
* `tbd` - **fix**: **brand-enforcement** — Hardcodierter `.agents/brand/guidelines.md`-Pfad durch relative `../brand-guidelines/references/`-Pfade ersetzt. `requires: [brand-guidelines]` im Frontmatter deklariert.

---

### [Latest] May 13, 2026
**Version 4.4 — „Agent Economy 2026" Update**

* `tbd` - **feat**: **Stateful Ecosystem Pruning** — Der Skill-Engineer liest in Phase 0 nun nicht mehr stur alle Dateien, sondern prüft (stateful via `.skill-config.json`) die `ECOSYSTEM.md` Map. Das verhindert Token-Bloat und Context-Inflation (Pruning).
* `tbd` - **feat**: **Skill-Mapper Auslagerung** — Die rekursive Mapping-Logik (ehemals Modus M) wurde aus Performance-Gründen (Separation of Concerns) in einen separaten `skill-mapper` Agenten ausgelagert.
* `tbd` - **feat**: **Conflict-Router** — Erkennt der Engineer einen Überlappungs-Konflikt, schlägt er proaktiv die Generierung eines "Router-Skills" vor, anstatt nur zu warnen.
* `tbd` - **feat**: **Toxic Inputs & TSD** — In Phase 3 (TSD) wird nun explizit das Entwerfen von "Toxic Inputs" (z.B. überlange Strings, Race Conditions) für Edge-Case-Tests gefordert.
* `tbd` - **feat**: **Dialektische Validierung (Red Teaming)** — Phase 2.5 eingeführt: Der Agent muss seinen eigenen Skill-Entwurf im "Adversarial Build" Modus selbst angreifen (Logikfehler, Statelessness-Checks, IDE-Constraints).


### [Latest] April 29, 2026
**Version 4.3 — „Stateless Architecture" Update**

* `tbd` - **feat**: **Stateless Design** — Vollständiger Wechsel von Inline-Konfigurationen (`<!-- CONFIGURATION_START -->`) zu einer strikt lokalen `.skill-config.json`. Verhindert Git-Konflikte bei Updates und trennt Skill-Logik vom User-State.
* `tbd` - **feat**: **Monorepo Ready** — Bereinigung der Architektur zur nahtlosen Integration in zentrale Skill-Bibliotheken (x10aix-skills).

---

### [Latest] April 20, 2026
**Version 4.2 — „Model-Agnostic Prompting" Update**

* `tbd` - **feat**: **llm-conventions.md** — Zentrale Auslagerung von Prompting-Architekturen. Löst klassisches If/Else-Branching nach `Target LLM` durch generisches "Model-Agnostic Wording" ab.
* `tbd` - **feat**: **Constraint-Checks** — Der Skill-Engineer baut in generierte Skills keine rekursiven CoT-Denkschleifen mehr ein, sondern knallharte Validierungs-Gates am Ende jedes Workflows (Performance Boost für Opus 4.7 / o1).
* `tbd` - **feat**: **Depth-Signals** — Anstelle des `<scratchpad>`-Zwangs werden komplexe Denkprozesse für das Ziel-LLM nun über "Tiefensignale" angetriggert.
* `tbd` - **docs**: Neues Beispiel `04-model-agnostic-refactoring.md` zeigt am Fallbeispiel des `google-ads-manager`, wie Alt-Skills in Modus C umgeschrieben werden.

---

### April 16, 2026
**Version 4.1 — „Ecosystem-Mapper" Update**

* `tbd` - **feat**: **Modus M (Mapping)** — Einführung eines neuen Modus, der rekursiv alle Skills im Workspace scannt und deren Beziehungen, delegierte Prozesse sowie Konflikte formatiert als Mermaid.js-Diagramm mappt (`ECOSYSTEM.md`). Berücksichtigt nativ Ordner-Hierarchien über Subgraphen.
* `tbd` - **docs**: Beispiele anonymisiert für die öffentliche Open-Source Version.

---

### April 13, 2026
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
