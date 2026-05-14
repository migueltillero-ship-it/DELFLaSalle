# ============================================================
#  DELF La Salle 2026 — Script de Deploy a GitHub Pages
#  Uso: Abrir PowerShell en la carpeta del proyecto y ejecutar:
#       .\deploy.ps1
# ============================================================

$ErrorActionPreference = "Stop"

# 1. Ruta del proyecto (ajusta si es necesario)
$RutaMaestra = "C:\Users\ALIANZA FRANCESA\DELFLaSalle"

# Verificar que la carpeta existe
if (-not (Test-Path $RutaMaestra)) {
    Write-Host "ERROR: No se encontro la carpeta $RutaMaestra" -ForegroundColor Red
    exit 1
}

Set-Location $RutaMaestra
Write-Host "Trabajando en: $RutaMaestra" -ForegroundColor Cyan

# 2. Verificar que git esta instalado
try {
    git --version | Out-Null
} catch {
    Write-Host "ERROR: Git no esta instalado o no esta en el PATH." -ForegroundColor Red
    exit 1
}

# 3. Agregar TODOS los archivos (index.html + PDFs + videos + imagenes)
Write-Host "`nAgregando archivos al repositorio..." -ForegroundColor Yellow
git add .

# 4. Verificar si hay cambios para commitear
$status = git status --porcelain
if (-not $status) {
    Write-Host "No hay cambios nuevos. El repositorio ya esta al dia." -ForegroundColor Green
    exit 0
}

# 5. Crear commit con fecha y hora automatica
$fecha = Get-Date -Format "yyyy-MM-dd HH:mm"
$mensaje = "Deploy $fecha - BD actualizada: 29 candidatos, PDF con guiones bajos"

Write-Host "Creando commit: $mensaje" -ForegroundColor Yellow
git commit -m $mensaje

# 6. Push a GitHub
Write-Host "`nSubiendo a GitHub Pages..." -ForegroundColor Yellow
git push origin main

Write-Host "`n✅ DEPLOY EXITOSO" -ForegroundColor Green
Write-Host "URL del portal: https://migueltillero-ship-it.github.io/DELFLaSalle/" -ForegroundColor Cyan
Write-Host "Espera 1-2 minutos y presiona Ctrl+Shift+R para actualizar sin cache." -ForegroundColor White
