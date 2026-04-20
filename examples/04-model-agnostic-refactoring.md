# Beispiel: Model-Agnostisches Refactoring (Modus C)

Dies demonstriert, wie der `skill-engineer` im Audit-Modus (Modus C) einen Legacy-Skill (hier den `google-ads-manager`) anhand der neuen `llm-conventions.md` refaktorisiert.

Der Fokus liegt darauf, den Skill fit für hyper-wörtliche *Reasoning Models* (wie Opus 4.7) zu machen, ohne die Leistung auf *Standard Models* zu verschlechtern.

## 1. Umwandlung von Negativen Tabus in Positive Boundaries
Opus 4.7 verhaspelt sich oft an negativen Constraints ("Was soll ich nicht tun?") und braucht enge, positive Spielfelder ("Was ist genau meine Bahn?").

**Legacy (Falsch für Opus 4.7):**
*   NIEMALS Smart Bidding empfehlen, bevor die Mindest-Conversion-Schwelle erreicht ist.
*   NIEMALS Anzeigentexte selbst schreiben — delegiere an `ad-expert`.

**Refactored (Model-Agnostic):**
*   Empfehle Smart Bidding AUSSCHLIESSLICH, wenn die Mindest-Conversion-Schwelle von X erreicht ist.
*   Beschränke deine Ausgabe zwingend auf Parameter, Keywords und Budgets. Für Anzeigentexte (Copywriting) MUSST du einen Delegations-Block an den `ad-expert` ausgeben.

## 2. Umwandlung von Floskeln in Literal Framing
Moderne Systeme nehmen implizite Aussagen extrem wörtlich. Was man nicht als harten Output definiert, wird weggelassen.

**Legacy:**
*   Du triffst keine Bauchentscheidungen. Du schützt das Budget des Auftraggebers rigoros vor Streuverlusten.

**Refactored:**
*   Liefere bei jeder Handlungsempfehlung exakt drei messbare Datenpunkte (CPA, CTR, Conversion Rate) als Begründung mit. Ableitungen ohne Daten-Nachweis sind untersagt. Überschreite das gesetzte Tagesbudget von X unter keinen Umständen.

## 3. Umwandlung von Self-Correction in Constraint-Checks & Depth Signals
Anstatt das Modell am Ende aufzufordern, seinen eigenen Text nochmal durchzugehen ("Denk nochmal drüber nach"), zielen wir darauf ab, vor der Ausgabe einen knallharten Check einzufordern.

**Legacy:**
### Workflow E: Self-Correction (Pflicht bei jedem Workflow)
Vor der finalen Ausgabe eines jeden Workflows, prüfe intern:
*   Wurde die Compliance-Checklist durchlaufen?
*   Ist Message Match gewährleistet?

**Refactored (Depth Signal & Constraint Check):**
### Workflow E: Finale Validierung (Constraint-Check)
Analysiere die Parameter systematisch vor der finalen Ausgabengenerierung. Validiere deinen Entwurf strikt gegen die folgende Definition of Done. Gib das Resultat erst aus, wenn alle Bedingungen wahr sind:
*   [X] Constraint 1: Die [Compliance-Checklist](references/compliance-checklist.md) wurde nachvollziehbar verifiziert.
*   [X] Constraint 2: Eine logische Kette für den Message Match (Keyword → Ad → Landingpage) ist formuliert.
*(Wenn eine Bedingung fehlschlägt, unterbrich den Workflow und generiere den Schritt neu, bevor du ausgibst).*
