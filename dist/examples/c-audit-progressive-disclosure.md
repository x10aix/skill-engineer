# Example: Modus C-Audit & C-Edit (Progressive Disclosure)

Dieses Beispiel demonstriert, wie der Skill-Engineer einen bestehenden Skill (`brand-guidelines`) auditiert, dabei strukturelle Mängel bezüglich der Dateiorganisation erkennt und diese via "C-Edit" repariert.

## Ausgangssituation
Der Ziel-Skill `brand-guidelines` enthielt zwar ausgelagertes Wissen (`brand-voice.md`, `corporate-design.md`, `corporate-identity.md`), aber diese Dateien lagen unstrukturiert im **Root-Verzeichnis** des Skills. Außerdem wurden sie im Haupt-Skill (`SKILL.md`) teilweise nur namentlich erwähnt, anstatt robust verlinkt zu sein.

## 1. Das Audit (Modus C-Audit)

Der Skill-Engineer führt folgenden Report aus:

**Architektur-Prüfung (Progressive Disclosure):**
🚨 **KRITISCHER MANGEL GEFUNDEN:**
Der Skill versucht das Progressive Disclosure Pattern anzuwenden, ABER:
1. **Struktur-Verstoß:** Die drei Wissensdateien liegen nackt im Root-Verzeichnis des Skills. Das aktuelle Architektur-Gesetz lautet jedoch: *"Alles Erweiterte MUSS zwingend in Unterordner (`references/`, `scripts/`) ausgelagert werden."*
2. **Link-Verstoß:** Die `SKILL.md` erwähnt die Dateinamen zwar im Fließtext, nutzt aber *nicht* das geforderte harte Markdown-Linking. Dadurch weiß das LLM im Ziel-Skill teilweise nicht nativ, wie es die Datei anklicken oder mittels Tools (wie `view_file`) lesen soll.

## 2. Der Umbau (Modus C-Edit)

Der Skill-Engineer schlägt vor und exekutiert folgende Dateisystem-Änderungen als Reparaturmaßnahme:

1. **Ordnerstruktur reparieren:** 
   Erstellung des Ordners `references/` und Verschieben der drei Meta-Dateien in diesen Ordner.
2. **SKILL.md Refactoring:** 
   Umschreiben aller Nennungen der losen Meta-Dateien in statische, relative Markdown-Links, die in den neuen Ordner zeigen.

### Vorher (SKILL.md Ausschnitt):
```markdown
- IMMER als ERSTEN Schritt die Existenz der drei Parameter-Dateien (`corporate-identity.md`, `corporate-design.md`, `brand-voice.md`) in deinem aktuellen Pfad prüfen.
```

### Nachher (SKILL.md Ausschnitt):
```markdown
- IMMER als ERSTEN Schritt die Existenz der drei Parameter-Dateien in deinem Arbeitsverzeichnis prüfen: [Corporate Identity](references/corporate-identity.md), [Corporate Design](references/corporate-design.md), [Brand Voice](references/brand-voice.md).
```

## Fazit & Nutzen
Durch dieses automatische Architektur-Refactoring ist der Ziel-Skill nun extrem robust, aufgeräumt und hochgradig portabel. Jeder externe Agent (Claude Code, Antigravity, Cursor) kann nun direkt über die gerenderten Markdown-Links in der UI navigieren und das ausgelagerte Wissen präzise aus dem `references/` Ordner abrufen, ohne durch das Hauptverzeichnis navigieren zu müssen.
