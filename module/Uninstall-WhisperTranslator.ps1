# Uninstall-WhisperTranslator.ps1

# Script de desinstalación de WhisperTranslator
# Elimina de manera limpia el módulo del sistema

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        WhisperTranslator - Script de Desinstalación            ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Función para eliminar el módulo de las rutas estándar
function Remove-ModuleFromStandardPaths {
    $standardPaths = @(
        "$env:USERPROFILE\Documents\PowerShell\Modules\WhisperTranslator",
        "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\WhisperTranslator",
        "C:\Program Files\PowerShell\Modules\WhisperTranslator",
        "$env:ProgramFiles\PowerShell\Modules\WhisperTranslator"
    )

    $removed = $false

    foreach ($path in $standardPaths) {
        if (Test-Path -Path $path) {
            try {
                Write-Host "Eliminando módulo de: $path" -ForegroundColor Yellow
                Remove-Item -Path $path -Recurse -Force -ErrorAction Stop
                Write-Host "✓ Módulo eliminado correctamente de $path" -ForegroundColor Green
                $removed = $true
            }
            catch {
                Write-Host "✗ Error al eliminar de $path : $_" -ForegroundColor Red
            }
        }
    }

    return $removed
}

# Función para descargar el módulo de la sesión actual
function Unload-Module {
    try {
        Remove-Module -Name "WhisperTranslator" -Force -ErrorAction SilentlyContinue
        Write-Host "✓ Módulo descargado de la sesión actual" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Error al descargar el módulo: $_" -ForegroundColor Red
    }
}

# Función para limpiar alias
function Remove-Alias {
    try {
        if (Get-Alias -Name "whisper-translator" -ErrorAction SilentlyContinue) {
            Remove-Item -Path "Alias:\whisper-translator" -Force
            Write-Host "✓ Alias 'whisper-translator' eliminado" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "Nota: No se encontró alias para eliminar" -ForegroundColor Yellow
    }
}

# Función para limpiar el perfil de PowerShell
function Clean-PowerShellProfile {
    if (Test-Path -Path $PROFILE) {
        try {
            $profileContent = Get-Content -Path $PROFILE -Raw

            # Busca líneas que contengan "whisper-translator" o "WhisperTranslator"
            if ($profileContent -match "whisper-translator|WhisperTranslator") {
                Write-Host ""
                Write-Host "Se encontraron referencias en el perfil de PowerShell: $PROFILE" -ForegroundColor Yellow
                Write-Host "¿Deseas eliminar automáticamente estas referencias?" -ForegroundColor Yellow
                
                $response = Read-Host "Responde 'si' o 'no'"
                
                if ($response -eq "si" -or $response -eq "s") {
                    # Elimina líneas que contengan WhisperTranslator o whisper-translator
                    $newContent = $profileContent -replace ".*whisper-translator.*`n|.*WhisperTranslator.*`n", ""
                    Set-Content -Path $PROFILE -Value $newContent -Force
                    Write-Host "✓ Perfil limpiado correctamente" -ForegroundColor Green
                }
            }
        }
        catch {
            Write-Host "✗ Error al limpiar el perfil: $_" -ForegroundColor Red
        }
    }
}

# Función para limpiar variables de entorno (PATH)
function Clean-EnvironmentVariables {
    try {
        $pathVar = [Environment]::GetEnvironmentVariable("Path", "User")
        
        if ($pathVar -match "WhisperTranslator") {
            Write-Host ""
            Write-Host "Se encontraron referencias en la variable PATH" -ForegroundColor Yellow
            Write-Host "¿Deseas eliminar automáticamente estas referencias?" -ForegroundColor Yellow
            
            $response = Read-Host "Responde 'si' o 'no'"
            
            if ($response -eq "si" -or $response -eq "s") {
                # Elimina la ruta de WhisperTranslator del PATH
                $newPath = ($pathVar -split ";") | Where-Object { $_ -notmatch "WhisperTranslator" } | Join-String -Separator ";"
                [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
                Write-Host "✓ Variable PATH limpiada correctamente" -ForegroundColor Green
                Write-Host "Nota: Cierra y reabre PowerShell para que los cambios tengan efecto" -ForegroundColor Cyan
            }
        }
    }
    catch {
        Write-Host "✗ Error al limpiar variables de entorno: $_" -ForegroundColor Red
    }
}

# Función para encontrar archivos .cmd registrados
function Find-CmdFiles {
    $systemPath = $env:PATH -split ";"
    
    foreach ($path in $systemPath) {
        if (Test-Path -Path $path) {
            $cmdFile = Join-Path -Path $path -ChildPath "whisper-translator.cmd"
            if (Test-Path -Path $cmdFile) {
                Write-Host ""
                Write-Host "Se encontró: $cmdFile" -ForegroundColor Yellow
                Write-Host "¿Deseas eliminarlo?" -ForegroundColor Yellow
                
                $response = Read-Host "Responde 'si' o 'no'"
                
                if ($response -eq "si" -or $response -eq "s") {
                    try {
                        Remove-Item -Path $cmdFile -Force
                        Write-Host "✓ Archivo eliminado: $cmdFile" -ForegroundColor Green
                    }
                    catch {
                        Write-Host "✗ Error al eliminar $cmdFile : $_" -ForegroundColor Red
                    }
                }
            }
        }
    }
}

# Función principal de desinstalación
function Uninstall-WhisperTranslator {
    Write-Host ""
    Write-Host "Este script desinstalará WhisperTranslator de tu sistema." -ForegroundColor Yellow
    Write-Host "Se realizarán los siguientes pasos:" -ForegroundColor Cyan
    Write-Host "  1. Descargar el módulo de la sesión actual"
    Write-Host "  2. Eliminar el módulo de directorios estándar"
    Write-Host "  3. Limpiar aliases"
    Write-Host "  4. Limpiar referencias en el perfil de PowerShell"
    Write-Host "  5. Limpiar variables de entorno (PATH)"
    Write-Host "  6. Buscar y eliminar archivos .cmd asociados"
    Write-Host ""
    
    $confirm = Read-Host "¿Estás seguro de que deseas continuar? (si/no)"
    
    if ($confirm -ne "si" -and $confirm -ne "s") {
        Write-Host "Desinstalación cancelada." -ForegroundColor Yellow
        return
    }

    Write-Host ""
    Write-Host "Iniciando desinstalación..." -ForegroundColor Cyan
    Write-Host ""

    # Ejecutar pasos de desinstalación
    Unload-Module
    Remove-ModuleFromStandardPaths
    Remove-Alias
    Clean-PowerShellProfile
    Clean-EnvironmentVariables
    Find-CmdFiles

    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                    Desinstalación Completada                   ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Recomendaciones finales:" -ForegroundColor Yellow
    Write-Host "  • Cierra completamente PowerShell y reabre una nueva ventana"
    Write-Host "  • Verifica que el módulo no se carga: Get-Module WhisperTranslator"
    Write-Host "  • Si necesitas reinstalar, ejecuta Install-WhisperTranslator.ps1"
    Write-Host ""
}

# Ejecutar desinstalación
Uninstall-WhisperTranslator
