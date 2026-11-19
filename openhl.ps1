#!/usr/bin/env pwsh
# OpenHL launcher for PowerShell
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$entry = Join-Path $root "bin\openhl.js"

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "OpenHL requires Node.js 20 or newer." -ForegroundColor Red
  Write-Host "Install it with:  winget install OpenJS.NodeJS.LTS" -ForegroundColor Yellow
  exit 1
}

$piped = @($input)
if ($piped.Count -gt 0) {
  $piped | & node $entry @args
} else {
  & node $entry @args
}
exit $LASTEXITCODE
