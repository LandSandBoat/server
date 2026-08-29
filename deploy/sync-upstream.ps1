<#
.SYNOPSIS
  Recupere les corrections du depot LandSandBoat officiel et les fusionne
  dans la branche de travail du fork.

.EXAMPLE
  .\deploy\sync-upstream.ps1            # apercu seulement
  .\deploy\sync-upstream.ps1 -Merge     # fusionne reellement
#>
param(
    [string] $UpstreamBranch = 'base',
    [switch] $Merge
)

$ErrorActionPreference = 'Stop'

if ((git status --porcelain).Length -gt 0) {
    throw "Le depot n'est pas propre. Commite ou remise tes changements d'abord."
}

git fetch upstream --prune

$behind = [int](git rev-list --count "HEAD..upstream/$UpstreamBranch")
$ahead  = [int](git rev-list --count "upstream/$UpstreamBranch..HEAD")

Write-Host ""
Write-Host "Ton fork est en avance de $ahead commit(s) et en retard de $behind commit(s)." -ForegroundColor Cyan

if ($behind -eq 0) {
    Write-Host "Rien a recuperer." -ForegroundColor Green
    exit 0
}

Write-Host ""
Write-Host "Nouveautes upstream :" -ForegroundColor Cyan
git log --oneline --no-merges "HEAD..upstream/$UpstreamBranch" | Select-Object -First 40

Write-Host ""
Write-Host "Migrations SQL ajoutees :" -ForegroundColor Cyan
git diff --name-only --diff-filter=A "HEAD..upstream/$UpstreamBranch" -- sql/ | ForEach-Object { "  $_" }

if (-not $Merge) {
    Write-Host ""
    Write-Host "Apercu seulement. Relance avec -Merge pour fusionner." -ForegroundColor Yellow
    exit 0
}

git merge "upstream/$UpstreamBranch" --no-edit

Write-Host ""
Write-Host "Fusion faite. Etapes suivantes :" -ForegroundColor Green
Write-Host "  cd deploy"
Write-Host "  docker compose build"
Write-Host "  docker compose up -d      # database-update applique les migrations"
