---
description: Bereinigt die SKILL.md Konfigurationen und pusht das Release auf GitHub
---

Dieser Workflow bereitet den Skill-Engineer für einen Release vor, indem er die lokalen Einstellungen (`CONFIGURED`) zurücksetzt, sodass GitHub-Nutzer eine saubere `UNCONFIGURED` Version erhalten.

// turbo-all
1. Führe folgenden Befehl aus, um die englische `SKILL.md` in den Auslieferungszustand zu versetzen:
   ```powershell
   (Get-Content SKILL.md) -replace 'STATUS: CONFIGURED', 'STATUS: UNCONFIGURED' -replace 'Target Platform:.*', 'Target Platform: N/A' -replace 'Target LLM:.*', 'Target LLM: N/A' -replace 'Target User:.*', 'Target User: N/A' -replace 'Language:.*', 'Language: N/A' | Set-Content SKILL.md
   ```
2. Führe folgenden Befehl aus, um die deutsche `SKILL.de.md` in den Auslieferungszustand zu versetzen:
   ```powershell
   (Get-Content SKILL.de.md) -replace 'STATUS: CONFIGURED', 'STATUS: UNCONFIGURED' -replace 'Zielplattform:.*', 'Zielplattform: N/A' -replace 'Ziel-LLM:.*', 'Ziel-LLM: N/A' -replace 'Ziel-Nutzer:.*', 'Ziel-Nutzer: N/A' -replace 'Sprache:.*', 'Sprache: N/A' | Set-Content SKILL.de.md
   ```

3. **Sehr wichtig:** Prüfe vor dem Commit, ob es neue Einträge in der Datei `CHANGELOG.de.md` gibt, die noch nicht in der englischen `CHANGELOG.md` stehen. Wenn ja, übersetze diese selbstständig im besten Entwickler-Englisch und trage sie in die `CHANGELOG.md` ein.
4. **Sicherheits-Check (Data Leak Prevention):** Durchsuche eigenständig alle Dateien, die für den Commit markiert sind (insbesondere in `references/` oder `examples/`), auf **interne Daten**. Suche nach: echten API-Keys, echten Server-IPs, internen Hostnamen (z.B. `intern.x10aix.tech`), echten E-Mail-Adressen, Passwörtern oder Kundennamen. Wenn du interne oder sensible Daten findest, **BLOCKIERE** den Push sofort und warte auf Anweisungen!
5. Frage den Nutzer nach der gewünschten Commit-Nachricht (z.B. "Update skills to v3.2").
6. Formatiere den Commit und führe aus:
   ```powershell
   git add .
   git commit -m "[Hier die Nutzer-Nachricht einfügen]"
   git push
   ```
7. Gib eine Erfolgsmeldung aus, dass das Projekt inklusive synchronisierter Changelogs veröffentlicht wurde!
