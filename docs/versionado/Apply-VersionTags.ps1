# Script para etiquetar versiones faltantes en WhisperTranslator
# Autor: amillanaol
# Fecha: 2025-11-23

<#
.SYNOPSIS
    Etiqueta automáticamente los commits sin versión en el repositorio WhisperTranslator.

.DESCRIPTION
    Este script aplica etiquetas semánticas (semantic versioning) a commits que no tienen
    etiqueta asignada. Ofrece diferentes estrategias de etiquetado:
    - Esencial: Solo versiones importantes (v1.x)
    - Completo: Todas las versiones incluyendo pre-releases (v0.x)
    - Custom: Selección manual de versiones

.PARAMETER Strategy
    Estrategia de etiquetado a utilizar.
    Valores válidos: "Essential", "Full", "Custom"
    Por defecto: "Essential"

.PARAMETER DryRun
    Modo de prueba. Muestra los comandos sin ejecutarlos.

.PARAMETER Push
    Sube las etiquetas al repositorio remoto después de crearlas.

.EXAMPLE
    .\Apply-VersionTags.ps1 -Strategy Essential
    Aplica solo las etiquetas esenciales (v1.x)

.EXAMPLE
    .\Apply-VersionTags.ps1 -Strategy Full -Push
    Aplica todas las etiquetas y las sube al remoto

.EXAMPLE
    .\Apply-VersionTags.ps1 -DryRun
    Muestra qué etiquetas se crearían sin ejecutar los comandos
#>

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("Essential", "Full", "Custom")]
    [string]$Strategy = "Essential",

    [Parameter(Mandatory=$false)]
    [switch]$DryRun,

    [Parameter(Mandatory=$false)]
    [switch]$Push
)

# Colores para output
$ColorInfo = "Cyan"
$ColorSuccess = "Green"
$ColorWarning = "Yellow"
$ColorError = "Red"

# Verificar que estamos en el directorio correcto
$repoPath = "C:\Users\alexi\src\WhisperTranslator"
if (-not (Test-Path $repoPath)) {
    Write-Host "Error: No se encontró el repositorio en $repoPath" -ForegroundColor $ColorError
    exit 1
}

Set-Location $repoPath

# Verificar que es un repositorio Git
if (-not (Test-Path ".git")) {
    Write-Host "Error: No es un repositorio Git válido" -ForegroundColor $ColorError
    exit 1
}

Write-Host "==================================" -ForegroundColor $ColorInfo
Write-Host "  Etiquetado de Versiones - WhisperTranslator" -ForegroundColor $ColorInfo
Write-Host "==================================" -ForegroundColor $ColorInfo
Write-Host ""

# Definición de etiquetas
$preReleaseVersions = @(
    @{Version="v0.0.1"; Hash="cc1200d"; Message="chore: initial repository clone"},
    @{Version="v0.0.2"; Hash="a3bd40e"; Message="feat: initial project structure"},
    @{Version="v0.0.3"; Hash="911077a"; Message="docs: README improvements"}
)

$postRefactorVersions = @(
    @{Version="v0.1.1"; Hash="b896aba"; Message="docs: README update post-refactor"},
    @{Version="v0.1.2"; Hash="12f42be"; Message="chore: configuration adjustments"},
    @{Version="v0.1.3"; Hash="ab6df2a"; Message="docs: add MIT license"}
)

$essentialVersions = @(
    @{Version="v1.0.1"; Hash="88c31a5"; Message="docs: rewrite README with new structure and content"},
    @{Version="v1.1.0"; Hash="14af2d7"; Message="feat: add uninstallation documentation and script"},
    @{Version="v1.1.1"; Hash="5bdb894"; Message="fix: correct invalid GUID in module manifest"},
    @{Version="v1.1.2"; Hash="c590387"; Message="docs: update installation documentation and script"},
    @{Version="v1.1.3"; Hash="f8a4607"; Message="docs: update usage guide to reflect new alias"},
    @{Version="v1.1.4"; Hash="5ea9cd9"; Message="docs: update README with new version and usage examples"}
)

# Seleccionar versiones según estrategia
$versionsToTag = @()
switch ($Strategy) {
    "Essential" {
        Write-Host "Estrategia: ESENCIAL (solo versiones v1.x importantes)" -ForegroundColor $ColorInfo
        $versionsToTag = $essentialVersions
    }
    "Full" {
        Write-Host "Estrategia: COMPLETA (todas las versiones incluyendo v0.x)" -ForegroundColor $ColorInfo
        $versionsToTag = $preReleaseVersions + $postRefactorVersions + $essentialVersions
    }
    "Custom" {
        Write-Host "Estrategia: PERSONALIZADA" -ForegroundColor $ColorInfo
        Write-Host "Característica no implementada. Use Essential o Full." -ForegroundColor $ColorWarning
        exit 0
    }
}

Write-Host ""
Write-Host "Se crearán $($versionsToTag.Count) etiquetas" -ForegroundColor $ColorInfo
if ($DryRun) {
    Write-Host "[MODO PRUEBA - No se ejecutarán los comandos]" -ForegroundColor $ColorWarning
}
Write-Host ""

# Crear etiquetas
$successCount = 0
$errorCount = 0

foreach ($version in $versionsToTag) {
    $tagCommand = "git tag -a $($version.Version) $($version.Hash) -m `"$($version.Message)`""
    
    Write-Host "[$($version.Version)] $($version.Hash) - $($version.Message)" -ForegroundColor $ColorInfo
    
    if ($DryRun) {
        Write-Host "  Comando: $tagCommand" -ForegroundColor $ColorWarning
    } else {
        try {
            # Verificar si la etiqueta ya existe
            $existingTag = git tag -l $version.Version
            if ($existingTag) {
                Write-Host "  ⚠️  La etiqueta ya existe, se omite" -ForegroundColor $ColorWarning
                continue
            }

            # Crear la etiqueta
            $result = git tag -a $version.Version $version.Hash -m $version.Message 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✓ Etiqueta creada exitosamente" -ForegroundColor $ColorSuccess
                $successCount++
            } else {
                Write-Host "  ✗ Error al crear etiqueta: $result" -ForegroundColor $ColorError
                $errorCount++
            }
        } catch {
            Write-Host "  ✗ Excepción: $($_.Exception.Message)" -ForegroundColor $ColorError
            $errorCount++
        }
    }
    Write-Host ""
}

# Resumen
Write-Host "==================================" -ForegroundColor $ColorInfo
Write-Host "  RESUMEN" -ForegroundColor $ColorInfo
Write-Host "==================================" -ForegroundColor $ColorInfo

if ($DryRun) {
    Write-Host "Se crearían $($versionsToTag.Count) etiquetas" -ForegroundColor $ColorWarning
} else {
    Write-Host "Etiquetas creadas exitosamente: $successCount" -ForegroundColor $ColorSuccess
    if ($errorCount -gt 0) {
        Write-Host "Errores: $errorCount" -ForegroundColor $ColorError
    }
}
Write-Host ""

# Push al remoto
if ($Push -and -not $DryRun -and $successCount -gt 0) {
    Write-Host "Subiendo etiquetas al repositorio remoto..." -ForegroundColor $ColorInfo
    try {
        git push origin --tags
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Etiquetas subidas exitosamente al remoto" -ForegroundColor $ColorSuccess
        } else {
            Write-Host "✗ Error al subir etiquetas al remoto" -ForegroundColor $ColorError
        }
    } catch {
        Write-Host "✗ Excepción al subir etiquetas: $($_.Exception.Message)" -ForegroundColor $ColorError
    }
} elseif ($Push -and $DryRun) {
    Write-Host "[MODO PRUEBA] Se ejecutaría: git push origin --tags" -ForegroundColor $ColorWarning
}

# Listar etiquetas actuales
if (-not $DryRun -and $successCount -gt 0) {
    Write-Host ""
    Write-Host "==================================" -ForegroundColor $ColorInfo
    Write-Host "  ETIQUETAS ACTUALES" -ForegroundColor $ColorInfo
    Write-Host "==================================" -ForegroundColor $ColorInfo
    git tag -l | Sort-Object
}

Write-Host ""
Write-Host "Script completado." -ForegroundColor $ColorSuccess
