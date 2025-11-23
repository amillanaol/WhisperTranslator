# Validación de Archivos .psd1

## ¿Qué es un archivo .psd1?

El archivo `.psd1` (PowerShell Data file) es el **manifiesto del módulo**. Define metadatos y configuración del módulo de PowerShell.

## Ubicación

En WhisperTranslator:
```
module/
├── WhisperTranslator.psd1   # ← Archivo de manifiesto
├── WhisperTranslator.psm1   # Módulo principal
└── ...
```

## Estructura Básica

```powershell
@{
    # Información del módulo
    RootModule = 'WhisperTranslator.psm1'
    ModuleVersion = '0.1.0'
    GUID = 'a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6'  # ⚠️ Debe ser válido
    Author = 'amillanaol'
    Description = 'Descripción del módulo'
    PowerShellVersion = '5.1'
    
    # Exportaciones
    FunctionsToExport = @('Invoke-WhisperTranslator')
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
    
    # Información adicional
    PrivateData = @{
        PSData = @{
            Tags = @('Whisper', 'Video', 'Transcription')
            ProjectUri = 'https://github.com/amillanaol/WhisperTraductor'
        }
    }
}
```

## Validar Sintaxis del .psd1

### Método 1: Probar Importación

```powershell
# Intenta importar el módulo
Import-Module -Name ".\WhisperTranslator" -Verbose

# Si no hay errores, la sintaxis es correcta
```

### Método 2: Usar Test-ModuleManifest

```powershell
# Valida el archivo .psd1 sin importarlo
Test-ModuleManifest -Path ".\WhisperTranslator\WhisperTranslator.psd1"

# Salida exitosa:
# ModuleType Version    PreRelease Name                             PSComputerName
# ---------- -------    ---------- ----                             --------------
# Manifest   0.1.0                 WhisperTranslator
```

### Método 3: Parsear Manualmente

```powershell
# Lee el archivo como un hashtable de PowerShell
$manifest = Import-LocalizedData -FileName "WhisperTranslator.psd1" -BaseDirectory ".\WhisperTranslator"

# Verifica propiedades clave
Write-Host "Versión: $($manifest.ModuleVersion)"
Write-Host "GUID: $($manifest.GUID)"
Write-Host "Funciones: $($manifest.FunctionsToExport -join ', ')"
```

## Campos Requeridos

| Campo | Requerido | Descripción | Ejemplo |
|-------|-----------|-------------|---------|
| `RootModule` | ✅ | Archivo .psm1 principal | `'WhisperTranslator.psm1'` |
| `ModuleVersion` | ✅ | Versión del módulo | `'0.1.0'` |
| `GUID` | ✅ | Identificador único | `'a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6'` |
| `Author` | ❌ | Autor del módulo | `'amillanaol'` |
| `Description` | ❌ | Descripción | `'Módulo para...'` |
| `PowerShellVersion` | ❌ | Versión mínima requerida | `'5.1'` |

## Validar Campos Específicos

### Validar GUID

```powershell
# Lee el manifiesto
$content = Get-Content -Path "WhisperTranslator\WhisperTranslator.psd1" -Raw

# Busca la línea GUID
$guid = $content | Select-String -Pattern "GUID\s*=\s*['\"]([^'\"]+)['\"]" -AllMatches

# Intenta parsearlo
try {
    $parsed = [guid]::Parse($guid.Matches.Groups[1].Value)
    Write-Host "✓ GUID válido: $parsed"
}
catch {
    Write-Host "✗ GUID inválido: $_"
}
```

### Validar Versión

```powershell
# Verifica que la versión tiene formato correcto (ej: 0.1.0)
$content = Get-Content -Path "WhisperTranslator\WhisperTranslator.psd1" -Raw

if ($content -match "ModuleVersion\s*=\s*['\"]([0-9]+\.[0-9]+\.[0-9]+)['\"]") {
    Write-Host "✓ Versión válida: $($matches[1])"
}
else {
    Write-Host "✗ Versión con formato incorrecto"
}
```

### Validar Archivo RootModule

```powershell
# Verifica que el archivo referenciado existe
$manifest = Import-LocalizedData -FileName "WhisperTranslator.psd1" -BaseDirectory ".\WhisperTranslator"
$modulePath = Join-Path ".\WhisperTranslator" $manifest.RootModule

if (Test-Path $modulePath) {
    Write-Host "✓ Archivo RootModule existe: $modulePath"
}
else {
    Write-Host "✗ Archivo RootModule no encontrado: $modulePath"
}
```

## Errores Comunes

### "No valid module file was found"

**Causa:** Sintaxis inválida en el `.psd1`

**Verificar:**
```powershell
# Intenta validar con Test-ModuleManifest
Test-ModuleManifest -Path ".\WhisperTranslator\WhisperTranslator.psd1"

# Si hay error, muestra el detalle
```

### "Cannot find a provider with the name"

**Causa:** Camino o sintaxis de ruta incorrecta

**Verificar:**
```powershell
# Asegúrate de usar rutas válidas
$modulePath = "C:\Users\alexi\src\WhisperTranslator\WhisperTranslator"
Test-Path $modulePath
```

### "Invalid Hashtable"

**Causa:** Sintaxis de hashtable incorrecta en el `.psd1`

**Verificar:**
```powershell
# Valida la sintaxis de PowerShell
[System.Management.Automation.PSParser]::Tokenize(
    (Get-Content "WhisperTranslator\WhisperTranslator.psd1" -Raw),
    [ref]$null
) | Where-Object { $_.Type -eq 'NewLine' }
```

## Actualizar el .psd1

Para actualizar campos en el manifiesto:

```powershell
# Leer el archivo
$manifestPath = ".\WhisperTranslator\WhisperTranslator.psd1"
$content = Get-Content -Path $manifestPath -Raw

# Hacer reemplazos
$content = $content -replace "ModuleVersion = '[^']*'", "ModuleVersion = '0.2.0'"

# Guardar
Set-Content -Path $manifestPath -Value $content -Force
```

## Validación Completa

```powershell
# Script de validación completa
function Test-ModuleManifestComplete {
    param(
        [string]$ManifestPath
    )
    
    Write-Host "Validando: $ManifestPath" -ForegroundColor Cyan
    
    # 1. Existe el archivo
    if (-not (Test-Path $ManifestPath)) {
        Write-Host "✗ Archivo no encontrado" -ForegroundColor Red
        return $false
    }
    Write-Host "✓ Archivo existe"
    
    # 2. Puede ser parseado
    try {
        $manifest = Import-LocalizedData -FileName (Split-Path $ManifestPath -Leaf) -BaseDirectory (Split-Path $ManifestPath)
        Write-Host "✓ Sintaxis válida"
    }
    catch {
        Write-Host "✗ Error de sintaxis: $_" -ForegroundColor Red
        return $false
    }
    
    # 3. Campos requeridos
    foreach ($field in @('RootModule', 'ModuleVersion', 'GUID')) {
        if ($manifest.ContainsKey($field)) {
            Write-Host "✓ Campo '$field' presente"
        }
        else {
            Write-Host "✗ Campo '$field' faltante" -ForegroundColor Red
            return $false
        }
    }
    
    # 4. GUID válido
    try {
        [guid]::Parse($manifest.GUID)
        Write-Host "✓ GUID válido"
    }
    catch {
        Write-Host "✗ GUID inválido: $_" -ForegroundColor Red
        return $false
    }
    
    Write-Host "✓ Validación completada exitosamente" -ForegroundColor Green
    return $true
}

# Uso
Test-ModuleManifestComplete ".\WhisperTranslator\WhisperTranslator.psd1"
```

## Recursos

- [about_Module_Manifests](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_module_manifests)
- [Test-ModuleManifest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/test-modulemanifest)
- [Error de GUID Inválido](invalid-guid-error-on-import-module.md)
