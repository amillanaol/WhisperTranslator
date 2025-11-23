# Install-WhisperTranslator.ps1
# Script de instalación automática de WhisperTranslator
# Detecta y corrige automáticamente errores comunes como GUID inválido

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║      WhisperTranslator - Script de Instalación Automática      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Obtenemos la ruta del directorio donde se encuentra este script.
$ScriptPath = $PSScriptRoot

# Construimos la ruta al archivo de manifiesto del módulo.
$ModuleManifest = Join-Path -Path $ScriptPath -ChildPath 'WhisperTranslator.psd1'
$ModulePath = $ScriptPath

Write-Host "Ruta del módulo: $ModulePath" -ForegroundColor Yellow

try {
    # Intentamos importar el módulo usando la ruta completa
    Write-Host "Importando módulo WhisperTranslator..." -ForegroundColor Cyan
    Import-Module -Name $ModulePath -ErrorAction Stop
    Write-Host "✓ Módulo WhisperTranslator importado correctamente." -ForegroundColor Green
}
catch {
    # Capturamos el error
    $ErrorMessage = $_.Exception.Message
    
    # Verificamos si el error es relacionado con GUID inválido
    if ($ErrorMessage -like "*The 'guid' member is not valid*" -or $ErrorMessage -like "*guid*") {
        Write-Host "✗ Se detectó un GUID inválido en el manifiesto del módulo." -ForegroundColor Red
        Write-Host "Intentando corregir automáticamente..." -ForegroundColor Yellow
        Write-Host ""

        # Leemos el contenido del manifiesto.
        $ManifestContent = Get-Content -Path $ModuleManifest -Raw

        # Generamos un nuevo GUID válido (8-4-4-4-12 formato)
        $NewGuid = [guid]::NewGuid().Guid
        Write-Host "Nuevo GUID generado: $NewGuid" -ForegroundColor Cyan

        # Reemplazamos el GUID inválido. Usamos una expresión regular más robusta
        # Esta regex busca GUID = 'algo' o GUID = "algo" y lo reemplaza
        $NewManifestContent = $ManifestContent -replace "GUID\s*=\s*['\`"]([^'`"]+)['\`"]", "GUID = '$NewGuid'"

        # Escribimos el nuevo contenido de vuelta al archivo
        Set-Content -Path $ModuleManifest -Value $NewManifestContent -Force
        Write-Host "✓ Archivo de manifiesto corregido." -ForegroundColor Green
        Write-Host ""
        Write-Host "Intentando importar el módulo de nuevo..." -ForegroundColor Cyan

        # Volvemos a intentar la importación
        try {
            Import-Module -Name $ModulePath -ErrorAction Stop
            Write-Host "✓ Módulo WhisperTranslator importado exitosamente después de la corrección." -ForegroundColor Green
        }
        catch {
            Write-Host "✗ Error al importar después de la corrección:" -ForegroundColor Red
            Write-Host "$($_.Exception.Message)" -ForegroundColor Red
            Write-Host ""
            Write-Host "Por favor, consulta la documentación en: docs/troubleshooting/" -ForegroundColor Yellow
            exit 1
        }
    }
    else {
        # Si es otro tipo de error, lo mostramos
        Write-Host "✗ Error inesperado al importar el módulo:" -ForegroundColor Red
        Write-Host "$ErrorMessage" -ForegroundColor Red
        Write-Host ""
        Write-Host "Por favor, consulta la documentación en: docs/troubleshooting/" -ForegroundColor Yellow
        exit 1
    }
}

# Verificación final
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║           Instalación Completada Correctamente                 ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos pasos:" -ForegroundColor Cyan
Write-Host "  1. Cierra esta ventana de PowerShell completamente"
Write-Host "  2. Abre una NUEVA ventana de PowerShell"
Write-Host "  3. Verifica que funciona con: Get-Module WhisperTranslator"
Write-Host "  4. Prueba el módulo: Invoke-WhisperTranslator -Help"
Write-Host ""
