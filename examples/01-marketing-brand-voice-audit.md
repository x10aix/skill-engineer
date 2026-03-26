# Example 01: Modus C (Audit & Edit) an einem realen Skill

Dieses Beispiel demonstriert, wie der `skill-engineer` im **Modus C (Bestehende Skills überarbeiten)** auf einen hochgradig ausgereiften, professionellen Ziel-Skill angewendet wird, um Architektur-Schwächen und Halluzinations-Risiken aufzudecken.

## Die Ausgangslage (Der Ziel-Skill)
Der Nutzer legte den Skill `marketing-brand-voice` vor. Dieser Agent ist dafür zuständig, Marketingtexte, LinkedIn-Posts und Proposals auf Einhaltung der strengen "x10aix.tech" Corporate Identity zu prüfen.
Das ursprüngliche Skill-File besaß bereits:
- Eine präzise Persona (Beratend, Executive-direkt, Pragmatisch)
- Eine Verbots-Tabelle für Floskeln (z.B. "AI-Transformation" -> "AI-Enablement")
- Einen 6-Schritte-Review-Workflow.

## Die Anwendung des Skill-Engineers (C-Audit)
Der Skill-Engineer durchlief das **9-Punkte-Qualitätsgate**. Anstatt den Code willkürlich zu verändern, gab er folgenden Stresstest-Bericht ("Tear-Down") aus:

> **Audit-Urteil:** Der Skill ist inhaltlich auf Senior-Texter-Niveau. Ein Rewrite ist *nicht nötig*, wir empfehlen nur strategischen Feinschliff.
> 
> **Identifizierte Schwachstellen:**
> 1. **Fehlende Self-Correction (Kriterium 9 - Anti-Halluzination):** Bevor der Agent "Brand-konform ✅" ausgibt, sollte er sich selbst noch einmal validieren. Agenten neigen dazu, nach dem ersten Review-Schritt aufzuhören.
> 2. **Fehlender Constraint auf Anglizismen (Kriterium 3):** Unter den globalen Attributen steht "Keine unnötigen Anglizismen". Im 6-Punkte-Review-Workflow wird das aber nicht explizit abgeprüft. Wenn es im Output-Schema nicht steht, prüft das LLM es meistens nicht systematisch ab.

## Das Ergebnis (C-Edit)
Auf Kommando des Nutzers patchte der Skill-Engineer die fehlenden Mechaniken nativ in den Code des Ziel-Skills:

**1. Erweiterung des Workflows (Fehlerquelle eliminiert):**
Der 6-Punkte-Workflow wurde auf 7 Punkte erweitert, um das Tabu testbar zu machen.
```markdown
7. **SIND UNNÖTIGE ANGLIZISMEN ENTHALTEN?** (Achtung: Business-Standards wie "ROI" und "Co-Pilot" sind ausdrücklich erlaubt, alles andere muss geprüft werden).
```

**2. Vererbte Self-Correction (Anti-Halluzination):**
Vor die finale Ausgabe der Bewertung wurde ein net-catcher eingebaut:
```markdown
### Schritt 4: Self-Correction (Prüfung vor Ausgabe)
**Kritischer Netz-Catcher:** Bevor du das finale Ergebnis ausgibst, hinterfrage deine Analyse und den Rewrite zwingend selbst:
- Habe ich (als LLM) unabsichtlich selbst Floskeln, Hype-Wörter oder Buzzwords in den Rewrite gemischt?
- Ist der Text jetzt anwendbar für einen Entscheider im DACH-Mittelstand?
- Habe ich verbotene Anglizismen übersehen?
Korrigiere deine Analyse oder deinen Rewrite im Hintergrund, falls nötig.
```

## Das Learning ("Mechanik schlägt Anweisung")
Dieses Audit beweist den Kernwert des Skill-Engineers: Er verhindert, dass sich Entwickler auf vage Systemanweisungen ("Achte auf Anglizismen") verlassen, und zwingt sie stattdessen in **harte, operative Prüfschleifen**. Er vererbt seine eigene Fehler-Intoleranz an die von ihm generierten Agenten.
