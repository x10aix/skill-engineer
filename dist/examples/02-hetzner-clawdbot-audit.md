# Example 02: Infrastruktur-Agent ([Cloud-Server Workflow])

Dieses Beispiel zeigt, wie der Skill-Engineer einen unstrukturierten technischen Leitfaden (Wikipedia-Stil) in einen strikten, ausführbaren Agenten-Workflow übersetzt.

## Die Ausgangslage
Der Nutzer legte den Skill `cloud-server-access` vor. Dieser sollte Anweisungen für den asynchronen SSH-Zugriff und eine Task-Queue-Interaktion mit einem Server-Bot ("[Server-Bot]") steuern.
**Das Problem:** Der Skill las sich wie eine technische Dokumentation. Er enthielt zwar exzellente Ansätze (wie SSH `BatchMode` zur Vermeidung von Prompt-Hängern), aber keine klare algorithmische Struktur für das LLM, das ihn später ausführen sollte.

## Das Audit-Ergebnis (Modus C)
Der Skill-Engineer prüfte die Datei gegen das 9-Punkte Qualitätsgate und fand folgende Schwachstellen:

1. **Kein ausführbarer Workflow (Kriterium 4):** Der Ablauf war als reiner Fließtext formuliert. Dem LLM fehlte ein klar nummerierter Schritt-für-Schritt-Plan.
2. **Vage Triggering-Logik (Kriterium 6):** Der Nutzer wollte, dass der Ziel-Agent automatisch auf den Chat-Befehl `/sync-bot` reagiert. Diese Anweisung war jedoch tief im Text vergraben.
3. **Fehlende Plattform-Konformität (Kriterium 7):** Kompletter Verzicht auf etablierte XML-Tags (`<operational_rules>`, `<process_workflow>`).
4. **Anti-Halluzination (Kriterium 9):** Der Agent wurde nicht gezwungen, vor Beginn zu prüfen, ob er überhaupt Kommandozeilen-Zugriff (`ssh`, `scp`) in seiner lokalen IDE-Umgebung hat. Er hätte blind versucht, Befehle auszuführen.

## Die Lösung (Rewrite im Antigravity-Standard)
Der Skill-Engineer überführte den Text in die harte XML-Architektur:

- **XML-Strukturierung:** Die SSH-Parameter wanderten strikt in `<operational_rules>`, die strategische Motivation (Warum asynchron?) in `<strategic_backbone>`.
- **Harte Trigger:** Es wurden zwei separate, blind ausführbare Teil-Workflows definiert:
  - *Workflow A:* "Neue Aufgabe an [Server-Bot] senden" (Triggert situativ bei Bedarf).
  - *Workflow B:* "Sync [Server-Bot]" (Triggert exakt bei Eingabe von `/sync-bot` -> Lade Queue, arbeite Jobs ab, formatiere Markdown, push Queue).
- **Environment Check:** Ein zwingender Prüfschritt (Verifizierung der lokalen CLI-Fähigkeiten) wurde als *Schritt 1* in den Workflow injiziert, um Tool-Halluzinationen auszuschließen.

## Das Learning
Ein Agent braucht Algorithmen, keine Romane. Der Skill-Engineer rettet das wertvolle Expertenwissen des Nutzers (z.B. SSH-Flags), zwingt es aber kompromisslos in ein XML-Gerüst, das ein Ziel-LLM später fehlerfrei und ohne Token-Verschwendung abarbeiten kann.
