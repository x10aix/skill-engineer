param (
    [Parameter(Mandatory=$true)]
    [string]$CommitMessage
)

$ErrorActionPreference = "Stop"

$scriptPath = $PSScriptRoot
$skillEngineerPath = Split-Path -Parent $scriptPath
$internalSkillsPath = Split-Path -Parent $skillEngineerPath
$skillMapperPath = Join-Path $internalSkillsPath "skill-mapper"

$tempDir = Join-Path $env:TEMP "skill-engineer-release-$(Get-Random)"
$publicRepoUrl = "https://github.com/x10aix/skill-engineer.git"

Write-Host "Vorbereitung des Open-Source Releases..." -ForegroundColor Cyan

# 1. Temp Dir erstellen
if (Test-Path $tempDir) { Remove-Item -Path $tempDir -Recurse -Force }
New-Item -ItemType Directory -Path $tempDir | Out-Null

try {
    # 2. Öffentliches Repo klonen
    Write-Host "Klone oeffentliches Repository..."
    git clone $publicRepoUrl $tempDir
    if ($LASTEXITCODE -ne 0) { throw "Fehler beim Klonen des Repositories!" }

    # 3. Inhalt leeren (außer .git)
    Write-Host "Bereinige alte Dateien..."
    Get-ChildItem -Path $tempDir -Force | Where-Object { $_.Name -ne ".git" } | Remove-Item -Recurse -Force

    # 4. Neue Dateien kopieren (Skill-Engineer ins Root)
    Write-Host "Kopiere aktuelle Skill-Engineer Dateien..."
    Copy-Item -Path "$skillEngineerPath\*" -Destination $tempDir -Recurse -Force
    Get-ChildItem -Path $skillEngineerPath -Force | Where-Object { $_.Name -match '^\.' } | Copy-Item -Destination $tempDir -Recurse -Force

    # 5. Skill-Mapper als Addon kopieren
    Write-Host "Kopiere Skill-Mapper als Addon..."
    $addonDir = Join-Path $tempDir "addons\skill-mapper"
    New-Item -ItemType Directory -Path $addonDir -Force | Out-Null
    Copy-Item -Path "$skillMapperPath\*" -Destination $addonDir -Recurse -Force

    # 6. Commit & Push
    Write-Host "Push zu GitHub..."
    Set-Location -Path $tempDir
    git add .
    git commit -m $CommitMessage
    git push origin main
    if ($LASTEXITCODE -ne 0) { throw "Fehler beim Push zu origin main!" }

    Write-Host "Open-Source Version erfolgreich auf GitHub publiziert!" -ForegroundColor Green

} catch {
    Write-Host "Fehler aufgetreten: $_" -ForegroundColor Red
    exit 1
} finally {
    Set-Location -Path $scriptPath
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }
}
