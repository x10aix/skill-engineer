---
description: Bereitet den Skill-Engineer auf das Release vor (Secret Scan, Config Reset, Auto-Translation) und pusht
---

Dieser Workflow bereitet den Skill-Engineer für einen Release vor. Er scannt deterministisch nach harten Code-Leaks, setzt die Konfigurationen auf `UNCONFIGURED` zurück, übersetzt automatisch Changelogs und pusht das Ergebnis nach GitHub.

### 1. Pre-Flight Secret Scan (DLP)
// turbo-all
Führe den folgenden rigiden Sicherheits-Scan durch, um versehentlich geleakte API-Keys in lokalen `references/` oder `examples/` zu verhindern. Der Scan speichert die Ergebnisse in einem Log.
```powershell
    $reportDir = "reports"
    if (-not (Test-Path $reportDir)) { New-Item -ItemType Directory -Path $reportDir | Out-Null }
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $reportFile = "$reportDir\publish_scan_$timestamp.log"
    $secrets = @(
        @{ Name="OpenAI API Key"; Regex="(sk-[a-zA-Z0-9]{32,})" },
        @{ Name="Anthropic API Key"; Regex="(sk-ant-[a-zA-Z0-9-_]{30,})" },
        @{ Name="GitHub Token"; Regex="(ghp_[a-zA-Z0-9]{36})" },
        @{ Name="Generic Password/Token"; Regex='(?i)(pwd|password|secret|api_key|token)\s*[:=]\s*["''][^"'']{8,}["'']' }
    )
    $found = $false
    $logContent = @("=== PRE-FLIGHT SECRET SCAN REPORT ===", "Datum: $(Get-Date)", "-------------------------------------")
    Get-ChildItem -File -Recurse -Exclude "reports", ".git" | Where-Object { $_.Extension -match '\.(md|txt|json|yml|yaml|env)$' } | ForEach-Object {
        $file = $_
        $lines = Get-Content $file.FullName
        for ($i = 0; $i -lt $lines.Length; $i++) {
            foreach ($sec in $secrets) {
                if ($lines[$i] -match $sec.Regex) {
                    $msg = "WARNUNG: Potenzieller $($sec.Name) in $($file.Name) auf Zeile $($i+1)"
                    Write-Host "⚠️ $msg" -ForegroundColor Red
                    $logContent += $msg
                    $found = $true
                }
            }
        }
    }
    $logContent | Set-Content $reportFile -Encoding UTF8
    if ($found) {
        Write-Host "🚨 SECRETS GEFUNDEN! Publish-Workflow hart gestoppt. Bitte überprüfe $reportFile" -ForegroundColor Red
        exit 1
    } else {
        Write-Host "✅ Pre-Flight Secret Scan bestanden. Keine Key-Leaks absehbar." -ForegroundColor Green
    }
```

### 2. Auto-Sanitization (Config Reset)
// turbo-all
Führe folgenden Befehl aus, um beide SKILL-Dateien in den Auslieferungszustand zu versetzen:
```powershell
   (Get-Content SKILL.md) -replace 'STATUS: CONFIGURED', 'STATUS: UNCONFIGURED' -replace 'Target Platform:.*', 'Target Platform: N/A' -replace 'Target LLM:.*', 'Target LLM: N/A' -replace 'Target User:.*', 'Target User: N/A' -replace 'Language:.*', 'Language: N/A' | Set-Content SKILL.md
   
   (Get-Content SKILL.de.md) -replace 'STATUS: CONFIGURED', 'STATUS: UNCONFIGURED' -replace 'Zielplattform:.*', 'Zielplattform: N/A' -replace 'Ziel-LLM:.*', 'Ziel-LLM: N/A' -replace 'Ziel-Nutzer:.*', 'Ziel-Nutzer: N/A' -replace 'Sprache:.*', 'Sprache: N/A' | Set-Content SKILL.de.md
```

### 3. Changelog Synch & Translation
**Sehr wichtig:** Prüfe kurz, ob es neue Einträge in der Datei `CHANGELOG.de.md` gibt, die noch nicht in der englischen `CHANGELOG.md` stehen. Wenn ja, übersetze diese selbstständig im besten Entwickler-Englisch und trage sie in die `CHANGELOG.md` ein.

### 4. Git Commit & Push
Frage den Nutzer nach der gewünschten Commit-Nachricht (z.B. "Update skills to v3.2").
Formatiere den Commit und führe aus:
```powershell
   git add .
   git commit -m "[Hier die Nutzer-Nachricht einfügen]"
   git push
```

Gib eine Erfolgsmeldung aus, dass das Release erfolgreich und sicher auf GitHub gepusht wurde!
