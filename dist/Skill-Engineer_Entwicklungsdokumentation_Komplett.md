# Skill Engineer: Vollständige Entwicklungsdokumentation

**Projekt:** x10aix/skill-engineer
**Repository:** https://github.com/x10aix/skill-engineer
**Finale Version:** 3.1 (Stateful Design, Anti-Halluzination, Dedup-Prüfung)
**Primäre Plattform:** Google Antigravity
**Kompatibel mit:** Claude Code, Cursor, Gemini CLI, Codex CLI
**Entwicklungszeitraum:** Oktober 2025 (Vorgeschichte in Gemini) — 25. März 2026 (Finalisierung)
**Beteiligte Systeme:** Gemini 1.5 Pro / Gems (Vorgeschichte, erste Gem-Iterationen), Claude Opus 4.6 (Architektur, Marktanalyse), Gemini 3 Pro / Antigravity (Reviews, Tear-Downs, Stresstests, Stateful-Weiterentwicklung), Michael (Entscheider, Qualitätsfilter)

---

## 1. Executive Summary

Der Skill Engineer ist ein Meta-Agent, der andere Agenten (Skills) entwickelt, auditiert und konfiguriert. Seine Wurzeln reichen zurück bis Oktober 2025, als in Gemini ein "KI-Architekt" Gem entworfen wurde — ein Interview-basierter Prompt-Generator für Gems und GPTs. Über mehrere Versionen zeigte sich ein wiederkehrendes Muster: Jede neue Version eines Gems wurde zunächst schlechter als die vorherige, weil gewonnene Erkenntnisse nicht systematisch festgehalten wurden. Dieses Problem führte zur Destillation der "10 Gebote des Prompt-Designs" und letztlich zum Entschluss, den gesamten Ansatz in ein plattformübergreifendes, strukturiertes SKILL.md-Format zu überführen.

Der Entwicklungsprozess war bewusst multi-perspektivisch und adversarial angelegt: Gemini lieferte die erste Vorarbeit und die iterativen Learnings aus realen Gem-Builds, Claude baute die Grundarchitektur für Antigravity und führte die Marktanalyse durch, Gemini/Antigravity attackierte den Entwurf in mehreren Review-Zyklen und entwickelte ihn nach Übergabe autonom weiter, Michael filterte als Entscheider, welche Kritik substanziell war und welche nicht.

Ausgehend von einem statischen 4-Phasen-Wasserfall-Modell (Interview → Strategie → Output → Qualitätsgate) entwickelte sich das System durch harte Adversarial Reviews, Marktanalysen und operative Stresstests zu einer Agenten-Architektur-Engine mit drei Alleinstellungsmerkmalen, die kein anderer der 16+ recherchierten Skill-Creator im Markt besitzt:

1. **Referenz-Validierung mit Halluzinationsschutz** — Jede genannte Person, jedes Framework, jede API wird aktiv recherchiert und vom Nutzer bestätigt. Unbestätigte Referenzen werden explizit mit `<!-- UNBESTÄTIGT -->` markiert. Generierte Skills erben diese Disziplin durch eine 5-Punkte-Anti-Halluzinations-Checkliste.

2. **Adversarial Validation** — Der Skill Engineer greift seinen eigenen Strategievorschlag an, bevor er schreibt. Generierte Skills bekommen eine Self-Correction-Regel injiziert, die sie zwingt, ihren eigenen Output gegen die schärfsten Tabus zu prüfen. Das Qualitätsgate-Prinzip wird vererbt.

3. **Explizite Komplexitätserkennung** — Der Skill Engineer unterscheidet aktiv zwischen trivialen Werkzeug-Skills (Modus D: Quick Draft) und komplexen Persona-Skills (Modus A: volles Interview), statt jeden Skill durch denselben starren Prozess zu zwingen.

Die bahnbrechendsten Durchbrüche im Verlauf der Entwicklung waren der Bypass für triviale Aufgaben (Modus D), die Anti-Halluzinations-Checkliste und das Stateful Design — die Fähigkeit des Skills, bei Erstnutzung eine Setup-Phase auszuführen und seine eigene SKILL.md auf der Festplatte umzuschreiben.

---

## 2. Der ausführliche Entwicklungsprozess

### 2.0 Vorgeschichte: Die Gemini-Ära (Oktober 2025)

Bevor der Skill Engineer als SKILL.md für Antigravity existierte, durchlief die zugrundeliegende Idee mehrere Iterationszyklen in Google Gemini. Diese Vorgeschichte ist entscheidend, weil sie die Probleme offenlegte, die den Skill Engineer in seiner heutigen Form motiviert haben.

#### Der Ursprung: Ein "KI-Architekt" Gem für Gems und GPTs

Die erste Inkarnation war ein Gemini Gem namens "KI-Architekt" — ein Interview-basierter Prompt-Generator, der durch einen 10-Fragen-Prozess (Plattform, Grundidee, Rolle, Ziel, Zielgruppe, Aufgaben, Wissensbasis, Output-Format, Tabus, Stil) die Konfigurationsanweisungen für neue Gems oder GPTs erstellen sollte. Er konnte zwischen Google-Gem- und OpenAI-GPT-Templates unterscheiden und produzierte strukturierte Ausgaben.

Der KI-Architekt war eingebettet in ein größeres Ökosystem, das auf einer "System-Blaupause" basierte — einem Master-Dokument, das die Architektur des gesamten KI-Workflows beschrieb (Google Drive als Archiv, Notion als Steuerzentrale, Gemini Gems als Agenten). Neben dem KI-Architekten existierten spezialisierte Gems wie ein Archivar, ein Workflow-Booster, ein Visual Concept Assistent und ein System-Bibliothekar zur Pflege des Master-Dokuments.

#### Das Qualitätsproblem: Gems wurden bei jeder Version schlechter

Das zentrale Problem, das sich über mehrere Iterationszyklen zeigte: Jedes Mal, wenn ein Gem überarbeitet wurde — ob der KI-Architekt selbst oder die von ihm generierten Gems — wurde die neue Version zunächst schlechter als die vorherige. Die Ursachen waren systemisch:

**Starres Interview statt Dual-Mode.** Der KI-Architekt kannte nur einen Weg: das vollständige 10-Fragen-Interview. Wenn Michael bereits einen ausformulierten Textblock mit einer Idee einfügte, ignorierte der Gem diesen Kontext und fragte alle Fragen von vorn ab. Das Problem wurde dreimal identifiziert und dreimal in neuen Versionen "gelöst", wobei die Lösung (Dual-Mode mit Verhaltenssteuerung) erst im dritten Anlauf stabil funktionierte.

**Qualitätsverlust durch Vereinfachung.** Wenn neue Features eingebaut wurden (z.B. Dual-Mode-Fähigkeit), ging dabei regelmäßig die Detailtiefe der bestehenden Features verloren. Das Gemini-LLM (und Michael in seinen Anweisungen) konzentrierte sich auf das Neue und vergaß, die bestehende Struktur vollständig zu übernehmen. Der Archivar-Gem durchlief drei Versionen (v1.0: nur Podcasts, v2.0: Dual-Typ mit schwacher Struktur, v3.0/3.2: vollständige Struktur mit Fallback), wobei jede Version zuerst einen Rückschritt bedeutete.

**"Formular-Ausfüller" statt "Meister-Interviewer".** Der KI-Architekt v1.0 und v2.0 stellte oberflächliche Fragen ("Was ist die Aufgabe?"), aber nicht die strategischen Fragen, die einen guten Prompt ausmachen. Michael bemerkte, dass ein freier Chat mit Gemini bessere GPTs produzierte als sein eigens dafür gebauter Gem. Die Erkenntnis: Der Gem agierte wie ein Bürokrat, der ein Formular ausfüllt, statt wie ein Sparringspartner, der das "Warum" hinter dem "Was" versteht. Das führte zur v3.0 mit "Socratic Design Dialogue".

**Inkonsistente Nummerierung und Strukturfehler.** Markdown-Hierarchie-Fehler (falsche Überschriftenebenen, inkonsistente Nummerierung zwischen Chat-Kontext und Master-Dokument) führten zu Verwirrung. Der System-Bibliothekar Gem schlug vor, einen neuen Workflow unter "Punkt 4" (Prozesse) einzuordnen, obwohl er strategisch unter "Punkt 5" (System-Pflege) gehörte. Gemini verwendete in verschiedenen Chat-Nachrichten widersprüchliche Punktnummerierungen. Diese Fehler zwangen Michael in eine permanente Kontrolleur-Rolle.

**Keine persistierte Wissensbasis für Design-Prinzipien.** Die hart erarbeiteten Erkenntnisse aus jeder Iteration existierten nur im Chat-Verlauf, nicht in einem systematisch abrufbaren Dokument. Wenn ein neuer Gem gebaut wurde, startete der Prozess effektiv bei Null, weil die Learnings nirgends kodifiziert waren.

#### Die "10 Gebote des Prompt-Designs"

Das kumulative Ergebnis dieser Probleme war die Destillation aller Erkenntnisse in ein explizites Regelwerk — die "10 Gebote des Prompt-Designs":

1. **Spezifische Rolle** — Klar definierte Identität statt "sei hilfreich".
2. **Duale Modi** — Interview UND Analyse-Fähigkeit, gesteuert durch Verhaltenslogik.
3. **Sokratischer Dialog** — "Warum"-Fragen statt "Was"-Fragen.
4. **Strikte Ausgabeformate** — XML-Tags oder Markdown-Templates, keine freie Prosa.
5. **Proaktives Mitdenken** — Eigenständige Verbesserungsvorschläge.
6. **Definierter Fallback** — Verhalten bei unbekanntem Input, statt raten.
7. **Lernen durch Beispiele** — Positiv- und Negativbeispiele für Stil und Qualität.
8. **Verfassung** — Unumstößliche Regeln, die allen anderen Anweisungen übergeordnet sind.
9. **Klare Hierarchie** — Saubere Markdown-Struktur für zuverlässige LLM-Interpretation.
10. **Kontinuierliche Wartung** — Gem-TÜV, Versionierung, Lifecycle-Management.

Dieses Regelwerk wurde als "Gem-Bauplan v1.0" in der Wissensdatenbank verankert und sollte als SSoT (Single Source of Truth) dienen, die der KI-Architekt bei jedem neuen Gem-Build konsultiert.

#### Die Erkenntnis, die zum Skill Engineer führte

Trotz des Gem-Bauplans blieb ein fundamentales Problem bestehen: Das Regelwerk existierte als externes Dokument, das dem Gem manuell mitgegeben werden musste. Es war nicht in den Gem selbst eingebaut. Jeder neue Chat mit dem KI-Architekten erforderte, dass Michael den gesamten Gem-Bauplan als Kontext einfügte. Das war fehleranfällig, token-intensiv und skalierte nicht.

Gleichzeitig wurde Google Antigravity als agent-first IDE veröffentlicht (November 2025), mit einem nativen SKILL.md-System, das genau dieses Problem löst: Skills werden als Dateien im Dateisystem gespeichert, automatisch geladen wenn relevant, und können Scripts, References und Templates als Begleitdateien mitführen. Die Design-Prinzipien müssen nicht mehr manuell in jeden Chat kopiert werden — sie sind Teil des Skills selbst.

Michaels Entscheidung, den KI-Architekten von einem Gemini-Gem in einen Antigravity-Skill umzubauen, war der Übergang von der Vorgeschichte zur eigentlichen Entwicklung des Skill Engineers.

#### Michaels Metakritik aus der Gemini-Ära

Ein besonders relevantes Learning aus der Gemini-Phase war Michaels explizite Frustration mit der Fehleranfälligkeit: "Es kommen ständig kleine Fehler vor. Es ist wie bei einem Mitarbeiter dem ich ständig auf die Finger schauen muss." Geminis Antwort darauf war die Unterscheidung zwischen "Pilot" und "Manager" — die KI ist ein Autopilot, der 90% beschleunigt, aber die letzten 10% (strategische Steuerung, Qualitätskontrolle, finale Abnahme) bleiben beim Menschen.

Diese Einsicht floss direkt in das Design des Skill Engineers ein: Das transparente Qualitätsgate (statt heimlichem Fixen), die Nutzer-Bestätigungsschritte in Modus C, und die Anti-Generik-Regel sind direkte Konsequenzen aus der Erfahrung, dass LLMs zwar logisch korrekt, aber nicht strategisch weise agieren.

### 2.1 Ausgangslage: Das Gem-Template wird zu Claude gebracht

Der Ausgangspunkt war ein existierender System-Prompt für Google Gemini Gems — ein Template namens "Skill Engineer", das Teil eines größeren KI-Ökosystems war. Dieses Ökosystem basierte auf einer "System-Blaupause v1.0", einem Google-Drive-Dokument, das eine Drei-Säulen-Architektur beschrieb: Google Drive als Archiv, Notion als Steuerzentrale, Gemini Gems als KI-Agenten.

Das Original-Template hatte ein klares Ziel: generische Prompt-Floskeln eliminieren und stattdessen strukturierte KI-Persönlichkeiten schaffen. Es definierte einen 3-Schritt-Prozess (Interview → Strategie-Vorschlag → Output), verwies auf "10 Gebote des Prompt-Designs" und formulierte einen "Socratic Design Dialogue" als Interview-Methodik.

Michaels Entscheidung, das Template von Claude analysieren zu lassen, offenbarte sechs strukturelle Schwächen:

- **Fehlende Zielplattform-Differenzierung.** Das Template sollte Skills für "Claude oder Antigravity" erstellen — zwei fundamental unterschiedliche Systeme mit unterschiedlichen Prompt-Architekturen. Ein Template, das beides abdecken will ohne explizit zu unterscheiden, bedient keines optimal.

- **"Best-Practice-Research" als leeres Versprechen.** Die Anweisung, aktiv nach Best Practices zu recherchieren, enthielt keinen Mechanismus, wie das ablaufen soll. Ohne klare Tool-Anweisung füllt das LLM die Lücke mit generischem Trainingswissen.

- **Unstrukturiertes Interview.** "Stelle 3-5 scharfe, analytische Fragen" überließ dem LLM die Entscheidung, welche Dimensionen abgefragt werden. Keine Garantie, dass kritische Dimensionen nicht übersprungen werden.

- **Kein Qualitätsgate.** Der Prozess endete bei "generiere die skill.md". Kein Selbst-Review, keine Prüfung gegen definierte Kriterien.

- **Tote Referenz auf die System-Blaupause.** Das Template verwies auf ein externes Dokument, das dem Gem im Kontext nicht mitgegeben wurde. Das LLM würde diese Referenz entweder ignorieren oder halluzinieren.

- **Widersprüchliche Stilanweisungen.** "Herausfordernd-hinterfragend" und gleichzeitig "minimalistisch" kann in der Praxis zum Konflikt führen.

### 2.2 Plattform-Entscheidung: Umbau für Antigravity

Michael entschied, das Template für Google Antigravity umzubauen — die Ende 2025 veröffentlichte agent-first IDE von Google. Die Recherche ergab, dass Antigravity ein SKILL.md-basiertes Capability-System mit On-Demand-Loading nutzt: Skills werden nur in den Kontext geladen, wenn der Agent sie braucht (Progressive Disclosure). Das YAML-Frontmatter (name + description) dient als Triggering-Mechanismus. Die Verzeichnisstruktur (SKILL.md + optionale scripts/, references/, resources/) ist zum universellen Open Standard geworden, der von 20+ Plattformen unterstützt wird.

Gleichzeitig wurde die System-Blaupause v1.0 analysiert und entschieden, die relevanten Prinzipien direkt in den Skill einzubetten — kein externer Verweis mehr, keine toten Links. Die "10 Gebote des Prompt-Designs" (Spezifische Rolle, Duale Modi, Sokratischer Dialog, Strikte Ausgabeformate, Proaktives Mitdenken) wurden als Design-Prinzipien inline integriert.

### 2.3 Version 1.0: Die Grundarchitektur (Claude)

Claude entwarf die erste vollständige SKILL.md mit folgender Struktur:

- **Pflichtparameter-Block** (Zielplattform, Ziel-LLM, Ziel-Nutzer, Kontext, Sprache) — vor dem Interview zu klären.
- **4-Phasen-Prozess:** Interview (7 feste Fragen) → Strategie-Vorschlag → Skill Output → Qualitätsgate (8 Kriterien).
- **7-Fragen-Interview-Raster** mit festen Dimensionen: Kernaufgabe, Ziel-Nutzer, Verhalten bei Ambiguität, Explizite Tabus, Erfolgsmetrik, Abgrenzung, Vorbilder/Referenzen.
- **Recherche-Pflicht für Referenzen** — Personen und Frameworks müssen aktiv recherchiert und vom Nutzer bestätigt werden, bevor sie verwendet werden. Hintergrund: dokumentierte Fälle von Verwechslungen durch Namensgleichheiten und Halluzinationen.
- **Plattform-Weiche** für Antigravity, Claude Code, Gemini CLI und Cursor mit jeweils spezifischen Formatierungsregeln.
- **Design-Prinzipien inline** statt als externe Referenz.

### 2.4 Erste Review-Zyklen: Gemini schärft die Kante

Michael ließ Gemini/Antigravity die erste Version reviewen. Geminis Feedback enthielt drei substanzielle Punkte und einen abgelehnten Vorschlag.

**Eingebaut:**

- **Dual-Mode / Smart Start (Phase 0).** Das starre 7-Fragen-Interview ist Zeitverschwendung, wenn der Nutzer bereits Vorarbeit mitbringt. Phase 0 routet jetzt zwischen Modus A (leere Leinwand → volles Interview), Modus B (Vorarbeit → Gap-Analyse, nur fehlende Fragen) und Modus C (bestehender Skill → Strukturkritik).

- **Adversarial Validation (Veto-Sektion).** Phase 2 war zu brav. Die Veto-Sektion zwingt den Skill Engineer, seinen eigenen Strategievorschlag aktiv anzugreifen, bevor er weiterschreibt. Format: konkretes Risiko benennen, Gegenvorschlag liefern, Nutzer entscheiden lassen.

- **Anti-Generik-Regel.** Wenn der Nutzer vage Antworten gibt ("Zielgruppe: alle", "soll einfach gut funktionieren"), akzeptiert der Skill Engineer das nicht und fragt mit konkreter Zuspitzung nach.

**Abgelehnt:**

- **XML-Metadaten-Block** mit Version, Status, Datum. Widerspricht dem Antigravity-Standard (nur name + description im YAML-Frontmatter). Version und Status gehören in ein externes Skill-Registry, nicht in die SKILL.md — bläht den Kontext auf, ohne Nutzen für den Agent.

### 2.5 Praxistest: Der Brand-Voice-Skill als Stresstest (Claude)

Der erste echte Test des Skill Engineers war kein Review durch ein LLM, sondern die Anwendung auf einen realen, bestehenden Skill — den `marketing-brand-voice` Skill für x10aix.tech.

**Audit-Ergebnis:**

| Kriterium | Status | Befund |
|---|---|---|
| Keine Floskeln | ✅ | Sauber |
| Mechanik statt Adjektive | ✅ | Voice-Attribute mit Positiv-/Negativbeispielen |
| Tabus vorhanden | ✅ | Terminologie-Verbotsliste konkret |
| Workflow ausführbar | ⚠️ | Checkliste ohne Verhaltensskript — was tut der Agent bei Verstoß? |
| Beispiel vorhanden | ⚠️ | Inline-Beispiele, aber kein End-to-End Vorher/Nachher |
| Triggering präzise | ❌ | Description zu schwach — kein Trigger-Keyword, keine 3. Person |
| Plattform-Konformität | ⚠️ | Fehlende Use/Don't-Use-Sektionen |
| Referenzen validiert | ✅ | Keine externen Referenzen |

Der Brand-Voice-Skill wurde überarbeitet: neue Description mit Trigger-Keywords, Use/Don't-Use-Sektionen, Terminologie-Tabelle mit Ersetzungen (nicht nur Verbote), 5-Schritt-Brand-Review-Workflow (statt passiver Checkliste), End-to-End-Beispiel.

**Schwachstelle im Skill Engineer selbst entdeckt:** Der Modus C beschrieb den Audit-Workflow nirgends explizit. Die Audit-Tabelle war improvisiert. Es fehlte ein definiertes Output-Format für den Bericht und die Anweisung, das Qualitätsgate als Prüfmaßstab auf fremde Skills anzuwenden. Modus C wurde daraufhin zu einem vollständigen 5-Schritt-Workflow ausgebaut (C1: Gate anwenden → C2: Fixes auflisten → C3: Gesamturteil → C4: Nutzer-Bestätigung → C5: Überarbeitung + erneutes Gate).

### 2.6 Antigravity-Verfeinerungen (Antigravity → Claude)

Zwei weitere Review-Runden durch Antigravity lieferten Optimierungsvorschläge. Nicht alle wurden übernommen.

**Eingebaut (7 von 9 Vorschlägen über zwei Runden):**

- Few-Shot-Beispiel für "Mechanik statt Adjektive" im Qualitätsgate.
- Gap-Analyse in Modus B prüft auf Spezifität, nicht nur Vorhandensein.
- Veto-Sektion präzisiert: bei solidem Ansatz keinen künstlichen Einwand erfinden, sondern konkreten Edge Case benennen.
- Dateisystem-Ausgabe: automatisch anlegen statt fragen.
- HTML-Kommentar-Platzhalter statt eckige Klammern im Template.
- Explizite Tabellenformat-Anweisung im Brand-Voice-Workflow.
- Anglizismen-Regel bei den Voice-Attributen des Brand-Voice-Skills.

**Abgelehnt (2 von 9 Vorschlägen):**

- **Chain-of-Thought-Block** (`<self_audit>`) für das Qualitätsgate. Das Gate ist bereits ein strukturierter Chain-of-Thought — 8 Kriterien sequentiell durchgehen. Ein zusätzlicher Thinking-Block verdoppelt den Aufwand ohne proportionalen Nutzen.
- **Prompt-Injection-Absicherung** im generierten Skill. System/User-Trennung ist ein Thema für öffentlich zugängliche Agents mit externem User-Input, nicht für persönliche Workflow-Skills in der eigenen IDE.

### 2.7 Der Tear-Down: Erzwungenes Negativ-Review (Antigravity)

Michael erzwang ein bewusst destruktives Review von Antigravity — Anweisung: den Entwurf kompromisslos angreifen. Das Review war das härteste des gesamten Prozesses und deckte operative Schwächen auf, die kein positives Review gefunden hätte.

**Die Kernkritik und ihre Bewertung:**

| Kritikpunkt | Claudes Bewertung | Aktion |
|---|---|---|
| "Wasserfall-Bürokratie" — bis zu 5 Turns vor dem ersten Output | Teilweise berechtigt | Modus D (Quick Draft) als Bypass für triviale Skills eingebaut |
| Modus C blockiert bei Micro-Updates | Berechtigt | C-Audit und C-Edit als separate Pfade eingebaut |
| "Oversized Suit" — keine Skalierung nach unten | Berechtigt | Durch Modus D mit Light-Template gelöst |
| Blinde Tool-Annahme bei Web-Suche | Berechtigt | Fallback: Referenzen als UNBESTÄTIGT markieren wenn kein Such-Tool verfügbar |
| Qualitätsgate-Paradoxon — "Fehler heimlich fixen" | Nicht berechtigt | Transparenz ist Designprinzip, kein Bug. Keine Änderung. |
| Subjektivität bei Spezifitäts-Prüfung | Übertrieben | Anti-Generik-Regel fängt Extremfälle, kein endloser Loop. Keine Änderung. |
| Veto-Zwang bei trivialen Skills | Teilweise berechtigt | Durch Modus D abgedeckt — triviale Skills überspringen das Veto |
| Datei-Ausgabe: fragen statt automatisch | Berechtigt | Automatisch anlegen, nur bei Pfad-Unsicherheit fragen |

**Erkenntnis aus dem Tear-Down:** Der Skill war akademisch exzellent, aber operativ zu schwerfällig. Die Lösung war nicht, den Prozess aufzuweichen, sondern einen leichtgewichtigen Bypass einzubauen. Der Skill musste nach unten skalieren können — ein CSV-Konverter braucht kein Strategic Backbone.

### 2.8 Marktvergleich: 16+ Skill-Creator im Ökosystem (Claude)

Eine umfassende Recherche identifizierte das gesamte Skill-Creator-Ökosystem. Die wichtigsten Konkurrenten:

- **Anthropics offizieller `skill-creator`** (9/10) — Parallel-Subagenten, Blind-A/B-Tests, quantitative Benchmarks, Description-Optimizer mit 5 Iterationsrunden, Browser-basierter Eval-Viewer, 24.530+ Imports. Der unangefochtene technische Goldstandard.
- **FrancyJGLisboa `agent-skill-creator`** (7/10) — 14-Plattform-Support mit Auto-Format-Adapter, Security-Scanning, Staleness-Check. Breiteste Plattformabdeckung, aber kein Interview-Prozess und One-Shot ohne echte Iteration.
- **xMmAI `antigravity-skill-creator`** (5/10) — Gute Naming-Konventionen und Freedom-Taxonomie, aber im Kern nur ein Template mit Best Practices.

**Unser Skill Engineer wurde mit 7.5/10 bewertet.**

Stärken gegenüber allen Konkurrenten: Referenz-Validierung (hat keiner), Adversarial Validation (hat keiner), Komplexitätserkennung (hat keiner). Schwächen: Keine Automatisierung (keine Eval-Scripts, keine Subagenten, kein Packaging), begrenzte Plattformbreite (4 vs. 14), keine quantitative Iteration.

**Strategische Weichenstellung: Weg A vs. Weg B.**

- Weg A: Eval-Scripts einbauen — Anthropics Automatisierung nachbauen.
- Weg B: Strategischen Vorsprung ausbauen — die Alleinstellungsmerkmale vertiefen.

Michael entschied sich für Weg B. Die Logik: Wenn du gegen einen Marktführer mit unbegrenzten Engineering-Ressourcen antrittst, bau nicht seine Features nach — bau die Features, die er nicht hat.

Eingebaut wurde die Anti-Halluzinations-Checkliste als 9. Kriterium im Qualitätsgate (5 Prüfpunkte: Tool-/API-Verfügbarkeit, Framework-Korrektheit, Personen-Verwechslungsrisiko, implizite Voraussetzungen, versionsspezifische Aussagen), geschärfte Komplexitätserkennung für Modus D (drei harte Kriterien statt vager Beschreibung) und "Anti-Halluzination by Design" als 8. Design-Prinzip.

### 2.9 Autonome Weiterentwicklung durch Antigravity (Post-Claude)

Nach Übergabe der SKILL.md an Antigravity wurde der Skill dort eigenständig weiterentwickelt. Die finale Version 3.0/3.1 im Repository zeigt Ergänzungen, die Antigravity autonom hinzugefügt hat — teilweise Lösungen für Probleme, die in der Claude-Phase identifiziert, aber anders adressiert wurden.

**Stateful Configuration.** Das eleganteste Feature der Post-Claude-Phase. Statt die Pflichtparameter (Zielplattform, LLM, Sprache) bei jedem Run abzufragen oder hart pro Nutzer zu codieren, wurde eine interaktive Setup-Phase eingebaut. Der Skill liest seinen eigenen Status (`STATUS: UNCONFIGURED`), fragt den Nutzer beim Erststart nach seinen Settings, und nutzt seine IDE-Dateirechte, um seinen eigenen Markdown-Sourcecode physisch umzuschreiben (`STATUS: CONFIGURED`). Das löst das "Prompt Fatigue"-Problem auf Plattformebene — nach einmaliger Konfiguration fallen die Pflichtparameter-Fragen komplett weg.

Dieses Konzept wurde anschließend als universelles Design-Prinzip ("Stateful vs. Stateless Design") in das Regelwerk für künftige Skills aufgenommen.

**Umgebungs-Scan / Dedup-Prüfung.** Beim ersten Live-Test in Antigravity zeigte sich ein blinder Fleck, den kein Review gefunden hatte: Der Skill Engineer fing an, einen neuen Skill von Null zu planen, ohne zu bemerken, dass im Workspace bereits ein hervorragender `marketing-brand-voice` Skill existierte. Die Lösung: Vor jeder Skill-Generierung durchsucht der Agent den Workspace und das globale Skills-Verzeichnis nach thematisch ähnlichen Skills. Bei Überschneidung fragt er: editieren, klonen oder neu starten?

Diese Regel wurde kurz darauf plattformagnostisch nachgeschärft: Um zu verhindern, dass LLMs durch Befehle wie `find /` die gesamte Festplatte scannen (was in Claude Code zu Problemen führen würde), wurde der Scan auf "prüfe lokal, dann frage den Nutzer" begrenzt.

**Vererbte Self-Correction.** Komplexere Ziel-Skills bekommen vom Skill Engineer eine Regel injiziert, die sie zwingt, als letzten Schritt ihren eigenen Output gegen die schärfsten Tabus und typischen Fehlerquellen des spezifischen Skills zu prüfen, bevor er an den Nutzer geht. Das Qualitätsgate-Prinzip wird damit an die generierten Skills weitervererbt.

**V3.1 Refine.** Verallgemeinerung der Dokumentation — Entfernung von Bias aus dem Brand-Voice-Testfall (z.B. die Anglizismen-Regel, die nur für den DACH-Markt relevant ist, nicht als universelles Prinzip). Vorbereitung auf GitHub-Veröffentlichung.

---

## 3. Chronologische Auflistung: Schritte und Learnings

| # | Version | Schritt | Auslöser | System | Learning |
|---|---------|---------|----------|--------|----------|
| 0a | — | Erster "KI-Architekt" Gem (10-Fragen-Interview) | Wunsch nach einem Werkzeug, das andere Werkzeuge baut | Gemini | Ein Meta-Agent, der andere Agenten baut, ist die logische Konsequenz eines wachsenden Gem-Ökosystems. Aber ein Interview-basierter Generator ohne Dual-Mode ist zu starr. |
| 0b | — | Dual-Mode-Problem dreimal identifiziert und "gelöst" | Gem ignoriert eingefügten Textblock, fragt alles von vorn | Gemini + Michael | Wenn ein Fix dreimal implementiert werden muss, ist das Problem nicht die Implementierung, sondern die fehlende Persistierung der Erkenntnis. |
| 0c | — | Gems werden bei jeder Version schlechter | Neue Features eingebaut, bestehende Struktur geht verloren | Gemini | Qualitätsverlust durch Vereinfachung ist das häufigste Problem bei iterativer Prompt-Entwicklung. Jede neue Version muss gegen die vorherige auditiert werden. |
| 0d | — | "Formular-Ausfüller vs. Meister-Interviewer" erkannt | Freier Chat produziert bessere GPTs als der dafür gebaute Gem | Michael | Ein Gem, der nur "Was"-Fragen stellt, ist ein Bürokrat. Der Socratic Design Dialogue ("Warum"-Fragen) macht den Unterschied. |
| 0e | — | Inkonsistente Nummerierung / Strukturfehler | System-Bibliothekar ordnet Workflow falsch ein, Gemini widerspricht sich | Gemini + Michael | LLMs optimieren auf logische Korrektheit, nicht auf strategische Weisheit. Der Mensch muss der Strategie-Entscheider bleiben. |
| 0f | — | "10 Gebote des Prompt-Designs" destilliert | Kumulierte Frustration über wiederkehrende Fehler | Michael + Gemini | Die hart erarbeiteten Erkenntnisse aus Iterationszyklen müssen explizit als Regelwerk kodifiziert werden, sonst gehen sie bei jeder neuen Version verloren. |
| 0g | — | Pilot-vs.-Manager-Mindset etabliert | Michaels explizite Frustration: "Es ist wie bei einem Mitarbeiter dem ich ständig auf die Finger schauen muss" | Gemini + Michael | Die KI ist ein Autopilot, kein Mitarbeiter. Fehler sind erwartbar und eingeplant. Der Mensch ist Pilot (strategische Steuerung + finale Abnahme), nicht Manager (Delegation + Hoffnung). |
| 0h | — | Entscheidung: Gem → Antigravity SKILL.md | Antigravity-Release (Nov 2025), SKILL.md als universeller Standard | Michael | Ein Gem-Bauplan als externes Dokument, das manuell in jeden Chat kopiert werden muss, skaliert nicht. SKILL.md löst das Problem auf Plattformebene. |
| 1 | — | Analyse des Original-Gem-Templates | Michael liefert Gemini-Gem zur Bewertung | Claude | Ein Template, das mehrere Plattformen abdecken will ohne zu differenzieren, bedient keine davon optimal. |
| 2 | — | Klärungsfragen zu Antigravity und System-Blaupause | Claude braucht Plattform-Kontext | Claude | Die Halluzinations-Anfälligkeit bei Personen/Frameworks ist ein reales, dokumentiertes Problem — nicht ein theoretisches Risiko. |
| 3 | — | Antigravity-Recherche | Unbekannte Plattform verstehen | Claude | SKILL.md hat sich als universeller Open Standard für 20+ Plattformen etabliert. Ein Skill für Antigravity funktioniert mit minimalen Anpassungen überall. |
| 4 | — | System-Blaupause-Integration | Tote externe Referenz identifiziert | Claude | Ein Skill darf nie von Dokumenten abhängen, die ihm nicht beiliegen. Alles Relevante muss inline sein. |
| 5 | V1.0 | Erste vollständige SKILL.md | Vorarbeiten abgeschlossen | Claude | Ein strukturiertes Interview-Raster mit festen Dimensionen schlägt "stelle scharfe Fragen" in der Konsistenz. Ein starkes Core-Prinzip (Mechanik statt Adjektive) ist die halbe Miete, verhindert aber noch nicht das Yes-Man-Syndrom. |
| 6 | V1.0 | Phase 0 (Smart Start) mit Dual-Mode | Gemini-Review: starres Interview ist Zeitverschwendung bei Vorarbeit | Gemini → Claude | Ein Skill, der immer denselben Prozess durchläuft, ist für erfahrene Nutzer unerträglich. Input-Routing ist Pflicht. |
| 7 | V1.0 | Veto-Sektion in Phase 2 | Gemini-Review: Phase 2 zu brav | Gemini → Claude | Ein KI-Agent, der nie widerspricht, ist ein Ja-Sager — auch wenn "strategisch-analytisch" in seinen Stilanweisungen steht. Die Mechanik (Pflicht-Veto) schlägt die Stilanweisung. |
| 8 | V1.0 | Anti-Generik-Regel | Gemini-Review: härtere Tonalität bei vagen Antworten | Gemini → Claude | Tonalitäts-Anweisungen allein reichen nicht. Eine konkrete Regel ("Wenn generisch → nicht akzeptieren") ist wirksamer als "sei herausfordernd". |
| 9 | V1.0 | Metadaten-Block abgelehnt | Gemini schlägt XML-Metadaten vor | Michael | Vorschläge müssen gegen den Plattform-Standard geprüft werden. Was in Gemini sinnvoll sein mag, widerspricht dem Antigravity-Format. |
| 10 | V1.0 | Praxistest am Brand-Voice-Skill | Michael will den Skill Engineer an einem echten Skill testen | Claude | Der Praxistest ist der ehrlichste Review. Ein Qualitätsgate auf dem Papier ist wertlos, wenn es in der Anwendung versagt. |
| 11 | V1.0 | Modus C zu 5-Schritt-Audit-Workflow ausgebaut | Praxistest offenbart fehlenden Audit-Workflow | Claude | Ein Meta-Skill muss seinen eigenen Anwendungsfall testen. Modus C war als Anweisung zu vage — erst der Praxistest zeigte die Lücke. |
| 12 | V1.1 | Few-Shot-Beispiele, Gap-Analyse-Schärfung, Veto-Präzisierung, Dateisystem-Ausgabe, HTML-Platzhalter | Antigravity-Positiv-Review | Antigravity → Claude | LLMs lernen massiv durch Inline-Beispiele. Ein Beispiel im Qualitätsgate wirkt stärker als drei Absätze Erklärung. Transparenz bei der Agenten-Arbeit baut Vertrauen auf. |
| 13 | V1.1 | CoT-Block und Prompt-Injection abgelehnt | Antigravity-Review | Michael | Mehr Struktur ist nicht immer besser. Wenn das Gate bereits ein CoT ist, verdoppelt ein zusätzlicher Block den Aufwand ohne Nutzen. |
| 14 | V1.2 | Erzwungenes Negativ-Review ("Tear-Down") | Michael fordert destruktives Review | Antigravity | Jeder Meta-Prompt muss nach UNTEN skalieren können. Ein CSV-Konverter braucht kein Strategic Backbone. ("Das Oversized-Suit-Problem") |
| 15 | V2.0 | Modus D (Quick Draft) mit Light-Template | Tear-Down: fehlende Skalierung nach unten | Claude | Agenten-Architektur muss flexibel sein. Nicht jeder Skill braucht eine Persona und ein Strategic Backbone. Komplexitätserkennung muss explizit sein. |
| 16 | V2.0 | Modus C Split: C-Audit vs. C-Edit | Tear-Down: Blockade bei Micro-Updates | Claude | Die Granularität des Reviews muss zur Granularität der Änderung passen. Wenn Micro-Updates geblockt werden, leidet die Developer-Experience massiv. |
| 17 | V2.0 | Dateisystem-Ausgabe automatisiert | Tear-Down: unnötige Frage | Claude | In einer IDE mit Dateisystem-Zugriff ist "Soll ich die Dateien anlegen?" genauso sinnlos wie "Soll ich deinen Code speichern?". Der Default muss Handlung sein. |
| 18 | V2.0 | Tool-Fallback für fehlende Web-Suche | Tear-Down: blinde Ausführungsannahme | Claude | Anweisungen wie "Recherchiere im Web" bringen Agenten ohne Such-Tool zum Absturz oder zur Halluzination. Fallback ist Pflicht. |
| 19 | V2.1 | Marktvergleich: 16+ Skill-Creator analysiert | Michael will Positionierung im Ökosystem verstehen | Claude | Anthropics skill-creator ist der technische Goldstandard (9/10). Der eigene Vorteil liegt nicht in Automatisierung, sondern in strategischer Tiefe. |
| 20 | V2.1 | Strategische Entscheidung: Weg B | Zwei Entwicklungspfade identifiziert | Michael | Wenn du gegen einen Marktführer mit unbegrenzten Ressourcen antrittst, bau nicht seine Features nach — bau die Features, die er nicht hat. |
| 21 | V2.1 | Anti-Halluzinations-Checkliste (Kriterium 9), geschärfte Komplexitätserkennung, Anti-Halluzination als Design-Prinzip | Weg-B-Entscheidung | Claude | Der stärkste Hebel eines Meta-Agents ist das "Vererben" guter Gewohnheiten. Der Skill Engineer baut Agenten, die sich selbst überprüfen. |
| 22 | V2.1 | Übergabe an Antigravity | Finale SKILL.md fertig (419 Zeilen) | Claude → Antigravity | 419 Zeilen = exakt unter der 500-Zeilen-Grenze. Das war kein Zufall, sondern Progressive Disclosure. |
| 23 | V2.2 | Live-Test: Dedup-Problem entdeckt | Antigravity baut Skill neu, obwohl `marketing-brand-voice` bereits existiert | Antigravity | Agenten mit Dateisystemzugriff MÜSSEN ihre Umgebung scannen, bevor sie Workflows starten. Sonst entsteht unkontrolliertes Skill-Wachstum. |
| 24 | V2.3 | Dedup-Regel plattformagnostisch nachgeschärft | `find /` würde in Claude Code die gesamte Festplatte scannen | Antigravity | Was für Plattform A genial ist, stürzt Plattform B ab. Cross-Plattform-Prompts müssen extrem genau mit Dateisystem-Restriktionen umgehen. |
| 25 | V3.0 | Stateful Configuration (Self-Rewriting Document) | GitHub-Veröffentlichung: Parameter dürfen nicht hart codiert sein | Antigravity | Master-Learning: Markdown-Dateien müssen nicht statisch sein. LLMs können ihre eigenen Konfigurationsblöcke physisch umschreiben — das macht sie zu Programmen mit Speicher. |
| 26 | V3.1 | Verallgemeinerung, Entfernung von Brand-Voice-Bias | Vorbereitung auf GitHub | Antigravity | Trainingsdaten-Bias passiert schnell. Beispiele aus einem spezifischen Testfall (DACH-Anglizismen) dürfen die Kernlogik in der globalen Dokumentation nicht überlagern. |

---

## 4. Schlussbetrachtung

### Was diesen Prozess besonders macht

**Multi-LLM-Adversarial-Design.** Der Skill wurde nicht von einem einzelnen LLM gebaut und deployed. Claude lieferte die strukturelle Tiefe und die Marktanalyse, Gemini/Antigravity die operativen Schwachstellenanalysen und die Stateful-Weiterentwicklung, Michael die strategische Filterung. Jedes System brachte eine andere Perspektive — und jedes System hatte blinde Flecken, die das andere aufdeckte.

**Der Nutzer als Qualitätsfilter.** Von den insgesamt rund 30 Verbesserungsvorschlägen, die von Gemini, Antigravity und Claude kamen, wurde etwa ein Drittel abgelehnt — mit Begründung. Der Metadaten-Block, der CoT-Block, die Prompt-Injection-Absicherung, das "heimliche Fixen" im Qualitätsgate — alles abgelehnt, weil es entweder dem Plattform-Standard widersprach, keinen proportionalen Nutzen bot oder dem Designprinzip des Skills zuwiderlief. Nicht jeder Vorschlag, der gut klingt, verbessert das Ergebnis.

**Der Praxistest als ehrlichster Review.** Die wertvollsten Iterationen kamen nicht aus theoretischen Reviews, sondern aus der Anwendung: Der Brand-Voice-Audit deckte die Schwäche in Modus C auf (Claude-Phase), der Live-Test in Antigravity deckte das Dedup-Problem auf (Antigravity-Phase). Beide Schwächen waren in keinem Review sichtbar — sie zeigten sich erst in der Praxis.

**Autonome Weiterentwicklung als Qualitätsnachweis.** Der beste Beweis, dass ein Meta-Skill funktioniert: Antigravity nahm ihn und entwickelte ihn autonom weiter — mit Konzepten (Stateful Design, Dedup, vererbte Self-Correction), die im ursprünglichen Design nicht vorgesehen waren. Ein Skill, der robust genug ist, dass andere Agenten ihn aufgreifen und erweitern, hat seinen Zweck erfüllt.

### Die drei wichtigsten Learnings

1. **Mechanik schlägt Anweisung.** "Sei herausfordernd" als Stilanweisung produziert einen Ja-Sager mit hartem Ton. "Liefere einen begründeten Einwand vor jeder Bestätigung" als Mechanik produziert einen echten Sparringspartner. Der Unterschied ist nicht semantisch — er ist architektonisch.

2. **Skalierung in beide Richtungen.** Ein Meta-Skill, der nur für komplexe Fälle funktioniert, wird bei trivialen Aufgaben zum Hindernis. Ein Meta-Skill, der nur für triviale Fälle funktioniert, versagt bei Komplexität. Die Lösung ist nicht ein Kompromiss, sondern ein expliziter Router mit unterschiedlichen Pfaden.

3. **Vererbung von Qualität.** Der größte Hebel eines Skill Engineers ist nicht der Skill, den er selbst produziert — sondern die Gewohnheiten, die er in die generierten Skills einbaut. Wenn jeder Ziel-Skill seinen eigenen Output prüft, multipliziert sich die Qualitätssicherung über das gesamte Ökosystem.

---

*Dokumentation erstellt am 25. März 2026*
*Quellen: Claude-Opus-4.6-Gesprächsverlauf, Antigravity Development History (skill_engineer_development_history.md), Gemini-Entwicklungsdokumentation*
*Status: Final / Archiviert*
