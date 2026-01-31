# Script para etiquetar commits sin etiquetas de forma interactiva
# Autor: amillanaol
# Fecha: 2025-01-31

<#
.SYNOPSIS
    Etiqueta interactivamente los commits sin versión en el repositorio.

.DESCRIPTION
    Este script detecta automáticamente commits posteriores a la última etiqueta
    y permite al usuario gestionarlos mediante un menú interactivo.

    Características:
    - Detección automática de commits sin etiquetar
    - Menú interactivo para procesar cada commit
    - Asignación de tipos de versión (major/minor/patch)
    - Vista previa de las etiquetas que se crearán
    - Aplicación de etiquetas con opción de dry-run

.PARAMETER DryRun
    Modo de prueba. Muestra los comandos sin ejecutarlos.

.PARAMETER Push
    Sube las etiquetas al repositorio remoto después de crearlas.

.EXAMPLE
    .\Apply-VersionTags.ps1
    Inicia el script en modo interactivo

.EXAMPLE
    .\Apply-VersionTags.ps1 -DryRun
    Muestra qué etiquetas se crearían sin ejecutar los comandos

.EXAMPLE
    .\Apply-VersionTags.ps1 -Push
    Aplica las etiquetas y las sube al remoto
#>

param(
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
$ColorMenu = "White"

# Verificar que estamos en un repositorio Git
if (-not (Test-Path ".git")) {
    Write-Host "Error: No es un repositorio Git válido" -ForegroundColor $ColorError
    exit 1
}

# ===========================
# FUNCIONES PRINCIPALES
# ===========================

function Get-LastTag {
    <#
    .SYNOPSIS
        Obtiene la última etiqueta del repositorio
    #>
    $tag = git describe --tags --abbrev=0 2>$null
    return $tag
}

function Get-UntaggedCommits {
    <#
    .SYNOPSIS
        Obtiene los commits posteriores a la última etiqueta
    #>
    $lastTag = Get-LastTag

    $commits = @()
    if ($lastTag) {
        # Commits posteriores a la última etiqueta
        $logOutput = git log "$lastTag..HEAD" --oneline --format="%H|%s|%an|%ad" --date=short 2>$null
    } else {
        # Si no hay tags, obtener todos los commits
        $logOutput = git log --oneline --format="%H|%s|%an|%ad" --date=short 2>$null
    }

    if ($logOutput) {
        if ($logOutput -is [array]) {
            $logOutput | ForEach-Object {
                $parts = $_ -split '\|'
                $commits += @{
                    Hash           = $parts[0]
                    Message        = $parts[1]
                    Author         = $parts[2]
                    Date           = $parts[3]
                    VersionType    = $null
                    CustomMessage  = $null
                    Processed      = $false
                }
            }
        } else {
            $parts = $logOutput -split '\|'
            $commits += @{
                Hash           = $parts[0]
                Message        = $parts[1]
                Author         = $parts[2]
                Date           = $parts[3]
                VersionType    = $null
                CustomMessage  = $null
                Processed      = $false
            }
        }
    }

    return $commits
}

function Get-LastVersionNumber {
    <#
    .SYNOPSIS
        Obtiene la versión más reciente como array [major, minor, patch]
    #>
    $lastTag = Get-LastTag

    if (-not $lastTag) {
        return @(0, 0, 0)
    }

    # Extraer versión del tag (ej: v1.2.3 -> 1.2.3)
    $version = $lastTag -replace '^v', ''
    $parts = $version -split '\.'

    if ($parts.Count -ge 3) {
        return @([int]$parts[0], [int]$parts[1], [int]$parts[2])
    }

    return @(0, 0, 0)
}

function Get-NextVersion {
    <#
    .SYNOPSIS
        Calcula la siguiente versión basada en el tipo de cambio
    #>
    param(
        [ValidateSet("major", "minor", "patch")]
        [string]$VersionType
    )

    $current = Get-LastVersionNumber
    $major = $current[0]
    $minor = $current[1]
    $patch = $current[2]

    switch ($VersionType) {
        "major" {
            $major++
            $minor = 0
            $patch = 0
        }
        "minor" {
            $minor++
            $patch = 0
        }
        "patch" {
            $patch++
        }
    }

    return "v$major.$minor.$patch"
}

function Show-CommitDetails {
    <#
    .SYNOPSIS
        Muestra información detallada de un commit
    #>
    param(
        [hashtable]$Commit
    )

    Write-Host ""
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host "DETALLES DEL COMMIT" -ForegroundColor $ColorInfo
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo

    Write-Host "Hash:      " -NoNewline -ForegroundColor $ColorMenu
    Write-Host $Commit.Hash -ForegroundColor $ColorInfo

    Write-Host "Mensaje:   " -NoNewline -ForegroundColor $ColorMenu
    Write-Host $Commit.Message -ForegroundColor $ColorInfo

    Write-Host "Autor:     " -NoNewline -ForegroundColor $ColorMenu
    Write-Host $Commit.Author -ForegroundColor $ColorInfo

    Write-Host "Fecha:     " -NoNewline -ForegroundColor $ColorMenu
    Write-Host $Commit.Date -ForegroundColor $ColorInfo

    Write-Host "Tipo:      " -NoNewline -ForegroundColor $ColorMenu
    if ($Commit.VersionType) {
        Write-Host $Commit.VersionType -ForegroundColor $ColorSuccess
    } else {
        Write-Host "No asignado" -ForegroundColor $ColorWarning
    }

    Write-Host "Etiqueta:  " -NoNewline -ForegroundColor $ColorMenu
    if ($Commit.VersionType) {
        $nextVersion = Get-NextVersion $Commit.VersionType
        Write-Host $nextVersion -ForegroundColor $ColorSuccess
    } else {
        Write-Host "Pendiente" -ForegroundColor $ColorWarning
    }

    if ($Commit.CustomMessage) {
        Write-Host "Mensaje personalizado: " -NoNewline -ForegroundColor $ColorMenu
        Write-Host $Commit.CustomMessage -ForegroundColor $ColorInfo
    }

    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host ""
}

function Show-CommitSubMenu {
    <#
    .SYNOPSIS
        Menú para procesar un commit individual
    #>
    param(
        [hashtable]$Commit,
        [int]$CommitIndex,
        [array]$AllCommits
    )

    while ($true) {
        Write-Host ""
        Write-Host "─────────────────────────────────────────" -ForegroundColor $ColorMenu
        Write-Host "PROCESANDO COMMIT [$($CommitIndex + 1)/$($AllCommits.Count)]" -ForegroundColor $ColorMenu
        Write-Host "─────────────────────────────────────────" -ForegroundColor $ColorMenu

        Write-Host "Commit: " -NoNewline -ForegroundColor $ColorMenu
        Write-Host "$($Commit.Hash.Substring(0, 7)) - $($Commit.Message)" -ForegroundColor $ColorInfo

        Write-Host ""
        Write-Host "1. Ver detalles completos" -ForegroundColor $ColorMenu
        Write-Host "2. Asignar tipo: MAJOR (versión principal)" -ForegroundColor $ColorMenu
        Write-Host "3. Asignar tipo: MINOR (nueva funcionalidad)" -ForegroundColor $ColorMenu
        Write-Host "4. Asignar tipo: PATCH (corrección)" -ForegroundColor $ColorMenu
        Write-Host "5. Asignar mensaje personalizado" -ForegroundColor $ColorMenu
        Write-Host "6. Marcar como procesado" -ForegroundColor $ColorMenu
        Write-Host "7. Volver al menú principal" -ForegroundColor $ColorMenu
        Write-Host "8. Salir sin aplicar" -ForegroundColor $ColorMenu
        Write-Host ""

        $choice = Read-Host "Seleccione opción"

        switch ($choice) {
            "1" {
                Show-CommitDetails $Commit
            }
            "2" {
                $Commit.VersionType = "major"
                Write-Host "Tipo asignado: MAJOR - " -NoNewline -ForegroundColor $ColorSuccess
                Write-Host (Get-NextVersion "major") -ForegroundColor $ColorSuccess
            }
            "3" {
                $Commit.VersionType = "minor"
                Write-Host "Tipo asignado: MINOR - " -NoNewline -ForegroundColor $ColorSuccess
                Write-Host (Get-NextVersion "minor") -ForegroundColor $ColorSuccess
            }
            "4" {
                $Commit.VersionType = "patch"
                Write-Host "Tipo asignado: PATCH - " -NoNewline -ForegroundColor $ColorSuccess
                Write-Host (Get-NextVersion "patch") -ForegroundColor $ColorSuccess
            }
            "5" {
                Write-Host ""
                Write-Host "Mensaje actual: $($Commit.Message)" -ForegroundColor $ColorInfo
                $customMsg = Read-Host "Ingrese mensaje personalizado (o Enter para mantener)"
                if ($customMsg) {
                    $Commit.CustomMessage = $customMsg
                    Write-Host "Mensaje personalizado asignado" -ForegroundColor $ColorSuccess
                }
            }
            "6" {
                if ($Commit.VersionType) {
                    $Commit.Processed = $true
                    Write-Host "Commit marcado como procesado" -ForegroundColor $ColorSuccess
                    return
                } else {
                    Write-Host "Error: Debe asignar un tipo de versión primero" -ForegroundColor $ColorError
                }
            }
            "7" {
                return
            }
            "8" {
                Write-Host ""
                Write-Host "Confirmando salida..." -ForegroundColor $ColorWarning
                $confirm = Read-Host "¿Desea salir sin aplicar los cambios? (s/n)"
                if ($confirm -eq "s" -or $confirm -eq "S") {
                    Write-Host "Operación cancelada." -ForegroundColor $ColorWarning
                    exit 0
                }
            }
            default {
                Write-Host "Opción inválida" -ForegroundColor $ColorError
            }
        }
    }
}

function Show-CommitList {
    <#
    .SYNOPSIS
        Muestra la lista de commits sin etiquetar
    #>
    param(
        [array]$Commits
    )

    Write-Host ""
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host "COMMITS SIN ETIQUETAR ($($Commits.Count) encontrados)" -ForegroundColor $ColorInfo
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo

    $Commits | ForEach-Object -Begin { $i = 1 } -Process {
        $statusColor = if ($_.Processed) { $ColorSuccess } else { $ColorWarning }
        $status = if ($_.Processed) { "✓" } else { "○" }

        Write-Host "$status $i. " -NoNewline -ForegroundColor $statusColor
        Write-Host "$($_.Hash.Substring(0, 7)) - $($_.Message)" -ForegroundColor $ColorMenu

        if ($_.VersionType) {
            $nextVer = Get-NextVersion $_.VersionType
            Write-Host "   Tipo: $($_.VersionType) → $nextVer" -ForegroundColor $ColorSuccess
        }

        $i++
    }

    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host ""
}

function Show-TagPreview {
    <#
    .SYNOPSIS
        Muestra preview de los tags que se crearán
    #>
    param(
        [array]$Commits
    )

    $processedCommits = $Commits | Where-Object { $_.VersionType }

    if ($processedCommits.Count -eq 0) {
        Write-Host ""
        Write-Host "No hay commits procesados para crear etiquetas." -ForegroundColor $ColorWarning
        Write-Host ""
        return
    }

    Write-Host ""
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host "PREVIEW DE ETIQUETAS A CREAR" -ForegroundColor $ColorInfo
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo

    $processedCommits | ForEach-Object {
        $nextVer = Get-NextVersion $_.VersionType
        $message = if ($_.CustomMessage) { $_.CustomMessage } else { $_.Message }

        Write-Host ""
        Write-Host "Etiqueta: " -NoNewline -ForegroundColor $ColorMenu
        Write-Host $nextVer -ForegroundColor $ColorSuccess

        Write-Host "Commit:   " -NoNewline -ForegroundColor $ColorMenu
        Write-Host $_.Hash.Substring(0, 7) -ForegroundColor $ColorInfo

        Write-Host "Mensaje:  " -NoNewline -ForegroundColor $ColorMenu
        Write-Host $message -ForegroundColor $ColorInfo
    }

    Write-Host ""
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host "Total de etiquetas a crear: $($processedCommits.Count)" -ForegroundColor $ColorSuccess
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host ""
}

function Show-MainMenu {
    <#
    .SYNOPSIS
        Menú principal del script
    #>
    param(
        [array]$Commits,
        [int]$ProcessedCount
    )

    Write-Host ""
    Write-Host "═════════════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host "  GESTOR DE ETIQUETAS DE VERSIÓN" -ForegroundColor $ColorInfo
    Write-Host "═════════════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host ""
    Write-Host "Commits sin etiquetar: $($Commits.Count)" -ForegroundColor $ColorMenu
    Write-Host "Commits procesados: $ProcessedCount" -ForegroundColor $ColorMenu
    Write-Host ""
    Write-Host "1. Ver lista de commits" -ForegroundColor $ColorMenu
    Write-Host "2. Procesar commits individualmente" -ForegroundColor $ColorMenu
    Write-Host "3. Ver preview de tags pendientes" -ForegroundColor $ColorMenu
    Write-Host "4. Aplicar tags" -ForegroundColor $ColorMenu
    Write-Host "5. Salir sin aplicar" -ForegroundColor $ColorMenu
    Write-Host "═════════════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host ""

    $choice = Read-Host "Seleccione opción"
    return $choice
}

function Apply-Tags {
    <#
    .SYNOPSIS
        Aplica las etiquetas configuradas a los commits
    #>
    param(
        [array]$Commits,
        [bool]$DryRunMode,
        [bool]$PushMode
    )

    $processedCommits = $Commits | Where-Object { $_.VersionType }

    if ($processedCommits.Count -eq 0) {
        Write-Host ""
        Write-Host "No hay commits procesados para aplicar etiquetas." -ForegroundColor $ColorWarning
        Write-Host ""
        return $false
    }

    Write-Host ""
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host "APLICANDO ETIQUETAS" -ForegroundColor $ColorInfo
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo

    if ($DryRunMode) {
        Write-Host "[MODO PRUEBA - Los comandos NO serán ejecutados]" -ForegroundColor $ColorWarning
    }

    Write-Host ""

    $successCount = 0
    $errorCount = 0

    $processedCommits | ForEach-Object {
        $nextVer = Get-NextVersion $_.VersionType
        $message = if ($_.CustomMessage) { $_.CustomMessage } else { $_.Message }
        $tagCommand = "git tag -a $nextVer $($_.Hash) -m `"$message`""

        Write-Host "Etiqueta: " -NoNewline -ForegroundColor $ColorInfo
        Write-Host $nextVer -NoNewline -ForegroundColor $ColorSuccess
        Write-Host " | Commit: " -NoNewline -ForegroundColor $ColorMenu
        Write-Host $_.Hash.Substring(0, 7) -ForegroundColor $ColorInfo

        if ($DryRunMode) {
            Write-Host "  Comando: $tagCommand" -ForegroundColor $ColorWarning
        } else {
            try {
                # Verificar si la etiqueta ya existe
                $existingTag = git tag -l $nextVer
                if ($existingTag) {
                    Write-Host "  ⚠️  La etiqueta ya existe, se omite" -ForegroundColor $ColorWarning
                    continue
                }

                # Crear la etiqueta
                $result = git tag -a $nextVer $_.Hash -m $message 2>&1

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
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
    Write-Host "RESUMEN" -ForegroundColor $ColorInfo
    Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo

    if ($DryRunMode) {
        Write-Host "Se crearían $($processedCommits.Count) etiquetas" -ForegroundColor $ColorWarning
    } else {
        Write-Host "Etiquetas creadas exitosamente: $successCount" -ForegroundColor $ColorSuccess
        if ($errorCount -gt 0) {
            Write-Host "Errores: $errorCount" -ForegroundColor $ColorError
        }
    }

    Write-Host ""

    # Push al remoto
    if ($PushMode -and -not $DryRunMode -and $successCount -gt 0) {
        Write-Host "Subiendo etiquetas al repositorio remoto..." -ForegroundColor $ColorInfo
        try {
            git push origin --tags 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✓ Etiquetas subidas exitosamente al remoto" -ForegroundColor $ColorSuccess
            } else {
                Write-Host "✗ Error al subir etiquetas al remoto" -ForegroundColor $ColorError
            }
        } catch {
            Write-Host "✗ Excepción al subir etiquetas: $($_.Exception.Message)" -ForegroundColor $ColorError
        }
    } elseif ($PushMode -and $DryRunMode) {
        Write-Host "[MODO PRUEBA] Se ejecutaría: git push origin --tags" -ForegroundColor $ColorWarning
    }

    # Listar etiquetas actuales
    if (-not $DryRunMode -and $successCount -gt 0) {
        Write-Host ""
        Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
        Write-Host "ETIQUETAS ACTUALES" -ForegroundColor $ColorInfo
        Write-Host "════════════════════════════════════════" -ForegroundColor $ColorInfo
        git tag -l | Sort-Object {
            $v = $_ -replace '^v', ''
            $parts = $v -split '\.'
            [version]($parts -join '.')
        }
        Write-Host ""
    }

    return $true
}

# ===========================
# PROGRAMA PRINCIPAL
# ===========================

Write-Host ""
Write-Host "═════════════════════════════════════════════════" -ForegroundColor $ColorInfo
Write-Host "  GESTOR INTERACTIVO DE ETIQUETAS DE VERSIÓN" -ForegroundColor $ColorInfo
Write-Host "═════════════════════════════════════════════════" -ForegroundColor $ColorInfo
Write-Host ""

if ($DryRun) {
    Write-Host "[MODO PRUEBA ACTIVADO]" -ForegroundColor $ColorWarning
    Write-Host "Los comandos git se mostrarán pero NO se ejecutarán" -ForegroundColor $ColorWarning
    Write-Host ""
}

# Obtener commits sin etiquetar
$untaggedCommits = Get-UntaggedCommits

if ($untaggedCommits.Count -eq 0) {
    Write-Host "✓ No hay commits sin etiquetar" -ForegroundColor $ColorSuccess
    Write-Host ""
    exit 0
}

Write-Host "Se encontraron $($untaggedCommits.Count) commits sin etiquetar" -ForegroundColor $ColorInfo
Write-Host ""

$lastTag = Get-LastTag
if ($lastTag) {
    Write-Host "Última etiqueta: $lastTag" -ForegroundColor $ColorInfo
} else {
    Write-Host "No hay etiquetas previas en el repositorio" -ForegroundColor $ColorWarning
}

Write-Host ""

# Menú principal
while ($true) {
    $processedCount = ($untaggedCommits | Where-Object { $_.VersionType }).Count
    $choice = Show-MainMenu $untaggedCommits $processedCount

    switch ($choice) {
        "1" {
            Show-CommitList $untaggedCommits
            Read-Host "Presione Enter para continuar"
        }
        "2" {
            $untaggedCommits | ForEach-Object -Begin { $i = 0 } -Process {
                Show-CommitSubMenu $_ $i $untaggedCommits
                $i++
            }
        }
        "3" {
            Show-TagPreview $untaggedCommits
            Read-Host "Presione Enter para continuar"
        }
        "4" {
            Write-Host ""
            Write-Host "¿Desea aplicar las etiquetas?" -ForegroundColor $ColorWarning
            Write-Host "Esta acción no puede deshacerse fácilmente" -ForegroundColor $ColorWarning
            $confirm = Read-Host "¿Continuar? (s/n)"

            if ($confirm -eq "s" -or $confirm -eq "S") {
                $success = Apply-Tags $untaggedCommits $DryRun $Push
                if ($success) {
                    if (-not $DryRun) {
                        Write-Host ""
                        Write-Host "Etiquetas aplicadas correctamente" -ForegroundColor $ColorSuccess
                    }
                    $exitScript = Read-Host "¿Desea salir del script? (s/n)"
                    if ($exitScript -eq "s" -or $exitScript -eq "S") {
                        break
                    }
                }
            }
        }
        "5" {
            Write-Host ""
            Write-Host "Saliendo sin aplicar cambios..." -ForegroundColor $ColorWarning
            exit 0
        }
        default {
            Write-Host "Opción inválida" -ForegroundColor $ColorError
        }
    }
}

Write-Host ""
Write-Host "Script completado." -ForegroundColor $ColorSuccess
Write-Host ""
