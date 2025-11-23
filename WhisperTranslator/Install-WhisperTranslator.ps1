# Install-WhisperTranslator.ps1

# Obtenemos la ruta del directorio donde se encuentra este script.
$ScriptPath = $PSScriptRoot

# Construimos la ruta al archivo de manifiesto del módulo.
$ModuleManifest = Join-Path -Path $ScriptPath -ChildPath 'WhisperTranslator.psd1'

try {
    # Intentamos importar el módulo.
    Import-Module -ManifestPath $ModuleManifest -ErrorAction Stop
    Write-Host "Módulo WhisperTranslator importado correctamente."
}
catch [System.Management.Automation.PSInvalidOperationException] {
    # Verificamos si el error es el que esperamos sobre el GUID.
    if ($_.Exception.Message -like "*The 'guid' member is not valid*") {
        Write-Host "Se detectó un GUID inválido en el manifiesto del módulo. Intentando corregir automáticamente..."

        # Leemos el contenido del manifiesto.
        $ManifestContent = Get-Content -Path $ModuleManifest -Raw

        # Generamos un nuevo GUID.
        $NewGuid = [guid]::NewGuid().Guid

        # Reemplazamos el GUID inválido. Usamos una expresión regular para ser más robustos.
        # Esta regex busca la línea del GUID y reemplaza el valor entre las comillas.
        $NewManifestContent = $ManifestContent -replace "(GUID\s*=\s*')([^']+)(')", "`$1$($NewGuid)`$3"

        # Escribimos el nuevo contenido de vuelta al archivo.
        Set-Content -Path $ModuleManifest -Value $NewManifestContent

        Write-Host "El archivo de manifiesto ha sido corregido con un nuevo GUID: $NewGuid"
        Write-Host "Intentando importar el módulo de nuevo..."

        # Volvemos a intentar la importación.
        Import-Module -ManifestPath $ModuleManifest
        Write-Host "Módulo WhisperTranslator importado exitosamente después de la corrección."
    }
    else {
        # Si es otro tipo de error, lo volvemos a lanzar.
        throw $_
    }
}
catch {
    # Para cualquier otro error inesperado.
    Write-Error "Ocurrió un error inesperado al importar el módulo: $($_.Exception.Message)"
    throw $_
}
