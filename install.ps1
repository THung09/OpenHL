param([switch]$Register)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$entry = Join-Path $root "bin\openhl.js"

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "Node.js 20+ is required. Install: winget install OpenJS.NodeJS.LTS" -ForegroundColor Red
  exit 1
}

Write-Host "OpenHL is ready at $root" -ForegroundColor Cyan
Write-Host ""

if ($Register) {
  # 1) PowerShell function (works regardless of execution policy)
  $profileDir = Split-Path -Parent $PROFILE
  if (-not (Test-Path $profileDir)) { New-Item -ItemType Directory -Force -Path $profileDir | Out-Null }
  $marker = "# openhl"
  $existing = if (Test-Path $PROFILE) { Get-Content $PROFILE -Raw } else { "" }
  if ($existing -notmatch [regex]::Escape($marker)) {
    $snippet = @"

$marker
function openhl { & node "$entry" @args }
"@
    Add-Content -Path $PROFILE -Value $snippet -Encoding UTF8
    Write-Host "Registered 'openhl' in $PROFILE" -ForegroundColor Green
  } else {
    Write-Host "PowerShell function already registered" -ForegroundColor Yellow
  }

  # 2) cmd.exe shim in a folder that is already on PATH
  $shimDir = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps"
  if (Test-Path $shimDir) {
    $shim = Join-Path $shimDir "openhl.cmd"
    "@echo off`r`nnode `"$entry`" %*`r`n" | Set-Content -Path $shim -Encoding ASCII
    Write-Host "Installed command shim: $shim" -ForegroundColor Green
  }

  Write-Host ""
  Write-Host "Open a new terminal (or run: . `$PROFILE), then type: openhl" -ForegroundColor Cyan
} else {
  Write-Host "Run '.\install.ps1 -Register' to make the 'openhl' command available everywhere." -ForegroundColor DarkGray
}
