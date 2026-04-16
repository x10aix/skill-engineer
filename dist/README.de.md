# Skill-Engineer: Architektur & Funktionsweise

**Version:** 4.0 (Ecosystem-Aware Design, Cross-Skill Delegation, Mermaid-Entscheidungsbäume)

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

## 2. Ökosystem-Mapping & Dedup-Prüfung *(Neu in v4.0)*
Bevor der Agent mit der Generierung beginnt, führt er eine zweistufige Analyse durch:
* **Dedup-Scan:** Prüft, ob ein thematisch ähnlicher Skill bereits existiert. Falls ja, pausiert er und fragt, ob editiert (Modus C), geklont oder neu gestartet werden soll.
* **Ökosystem-Mapping:** Scannt ALLE existierenden Skills im Workspace und identifiziert: (a) **Delegations-Partner** — Skills, an die der neue Skill Teilaufgaben abgeben soll, (b) **Konflikte** — Skills mit überlappenden Triggern, (c) **Neutral** — keine Interaktion. Dies verhindert sowohl Redundanz als auch monolithische Überfrachtung.
* **Benchmark-Scan (Optional):** Für komplexe Skills kann der Agent externe Lösungen recherchieren, um Must-Have-Features und USPs zu identifizieren.

---

## 3. Die 5 Betriebs-Modi (Input-Routing)
Gibt es kein Dedup-Problem (oder der Nutzer wünscht explizit einen Neubau), greift das intelligente Routing:

1. **Modus A (Leere Leinwand):** Der Nutzer hat nur eine grobe Idee. Der Agent startet das vollständige 10-Fragen-Interview.
2. **Modus B (Vorarbeit vorhanden):** Der Nutzer liefert einen Skill-Entwurf. Der Agent führt eine harte **Gap-Analyse** durch.
3. **Modus C (Audit / Edit):** Für bestehende Skills.
   * **C-Audit:** Der Agent prüft einen Alt-Skill gegen das 13-Punkte-Qualitätsgate und legt einen Report vor.
   * **C-Edit:** Der Agent führt eine definierte Detailänderung sofort aus und prüft nur den geänderten Bereich.
4. **Modus D (Quick Draft):** Triviale Werkzeug-Skills überspringen das Interview — sofortiges Light-Template.
5. **Modus E (Regeneration):** *(Neu in v4.0)* Ein ausführliches Planungsdokument, Strategiepapier, Prozessdokument, SOP oder eine Wissensbasis existiert, aber keine SKILL.md. Der Agent liest das Legacy-Dokument, extrahiert Kernfunktionen, Workflows, Regeln und Tabus und übersetzt sie in die SKILL.md-Architektur. Unterschied zu Modus B: Modus B hat einen *Skill-Entwurf*. Modus E hat *Domänenwissen in unstrukturierter Form*.

---

## 4. Adversarial Validation (Self-Doubt)
Der Skill-Engineer ist programmiert, sich nicht sofort zufrieden zu geben.
Bevor er in Phase 3 den finalen Skill generiert (Strategie-Vorschlag), muss er zwingend einen **Gegeneinwand (Veto)** gegen seinen eigenen Ansatz formulieren. 
Gibt es keine logische Schwachstelle, muss er stattdessen den gefährlichsten operativen **Edge Case** benennen.

---

## 4b. Cross-Skill Delegation *(Neu in v4.0)*
Wenn das Interview identifiziert, dass Teilaufgaben von bestehenden Skills besser gelöst werden können, injiziert der Engineer ein **Delegations-Muster** in den generierten Skill:
* Eine `NIEMALS ... delegiere an [skill-name]` Regel in `<operational_rules>` mit einem standardisierten Briefing-Template.
* Eine erwartete Rückgabe-Format-Spezifikation.
* Einen korrespondierenden Schritt im `<process_workflow>`, an dem die Delegation stattfindet.

Beispiel: Der `google-ads-manager` Skill delegiert Copywriting an `ad-expert` und Brand-Checks an `brand-guidelines`.

---

## 5. Das 13-Punkte-Qualitätsgate *(Erweitert in v4.0)*
Bevor der Skill-Engineer einen Ziel-Skill herausgibt, jagt er ihn durch diese Checkliste (maximal 13 Punkte in 4 Kategorien):

### A. Architektonische Reinheit (0–3 Punkte)
1. Native XML-Tags (keine Prosa-Anweisungen)
2. Mechanik statt Adjektive
3. Plattform-agnostisches Format (YAML-Frontmatter)

### B. Anti-Halluzination & Sicherheit (0–4 Punkte)
4. Environment-Check in Schritt 1
5. Self-Correction / Chain-of-Thought injiziert
6. Explizite Tabu-Liste
7. Unbestätigte Referenzen mit `<!-- UNBESTÄTIGT -->` markiert

### C. Developer Experience (0–3 Punkte)
8. Zero-Shot Triggering-Präzision
9. Few-Shot Beispiel enthalten
10. Stateful/Stateless Korrektheit

### D. Ökosystem-Integration & Wartbarkeit (0–3 Punkte) *(Neu in v4.0)*
11. **Cross-Skill-Delegation:** Teilaufgaben an spezialisierte Nachbar-Skills delegiert mit Briefing- + Rückgabeformat.
12. **Referenz-Qualität:** Jede Reference-Datei eigenständig nutzbar, unter 200 Zeilen, Mermaid für Entscheidungsbäume mit ≥3 Verzweigungen.
13. **Update-Fähigkeit:** Dynamische Reference-Dateien (Inventare, Listen) enthalten Datum, Pflegeregeln und Status-Tracking.

---

*(Dieses Dokument ist eine automatisch generierte Systembeschreibung des Agenten)*
