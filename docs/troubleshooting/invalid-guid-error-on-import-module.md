# Error de GUID Inválido en WhisperTranslator

## Problema

Al intentar importar o instalar el módulo WhisperTranslator, obtienes un error relacionado con el GUID:

```powershell
The 'guid' member is not valid in the module manifest file 
'C:\...\WhisperTranslator.psd1': Cannot convert value 
"1234567-1234-1234-1234-123456789012" to type "System.Guid". 
Error: "Guid should contain 32 digits with 4 dashes 
(xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)."
```

## ¿Qué es un GUID?

Un GUID (Identificador Único Global) es un número único de 128 bits usado por Windows y PowerShell para identificar módulos, aplicaciones y otros recursos.

### Formato Válido del GUID

Un GUID válido tiene el siguiente formato:

```
xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Donde:
- `x` es un dígito hexadecimal (0-9, A-F)
- Total: 32 caracteres hexadecimales + 4 guiones = 36 caracteres

### Ejemplos

| Válido ✅ | Inválido ❌ |
|----------|-----------|
| `a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6` | `1234567-1234-1234-1234-123456789012` |
| `12345678-1234-1234-1234-123456789012` | `1234567-1234-1234-1234-12345678901` |
| `550e8400-e29b-41d4-a716-446655440000` | `{1234567-1234-1234-1234-123456789012}` |

## Causa

El archivo `WhisperTranslator.psd1` contiene un GUID con formato inválido. Esto puede ocurrir por:

1. **Placeholder/Ejemplo**: El GUID fue copiado de un ejemplo sin cambiar
2. **Formato incorrecto**: No tiene los 32 dígitos hexadecimales necesarios
3. **Caracteres inválidos**: Contiene caracteres que no son hexadecimales

## Solución Automática (Recomendado)

### Opción 1: Usar el Script de Instalación

El script `Install-WhisperTranslator.ps1` detecta automáticamente y corrige GUIDs inválidos:

```powershell
# Desde el directorio del módulo
.\module\Install-WhisperTranslator.ps1
```

El script:
1. Intenta importar el módulo
2. Si detecta GUID inválido, lo corrige automáticamente
3. Genera un nuevo GUID válido
4. Reintenta la importación

### Opción 2: Corrección Manual

Si prefieres corregir manualmente:

1. **Abre el archivo `.psd1`:**
   ```powershell
   notepad .\module\WhisperTranslator.psd1
   ```

2. **Genera un nuevo GUID válido:**
   ```powershell
   [guid]::NewGuid().Guid
   ```
   Ejemplo de salida: `a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6`

3. **Encuentra la línea del GUID** en el archivo `.psd1`:
   ```powershell
   GUID = '1234567-1234-1234-1234-123456789012'  # ❌ Inválido
   ```

4. **Reemplázala** con el GUID generado:
   ```powershell
   GUID = 'a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6'  # ✅ Válido
   ```

5. **Guarda el archivo** (Ctrl+S)

6. **Cierra PowerShell completamente** y abre una nueva ventana

7. **Verifica que funciona:**
   ```powershell
   Import-Module WhisperTranslator
   Get-Module WhisperTranslator
   ```

## Validar un GUID

Para verificar que un GUID es válido:

```powershell
# Intenta convertirlo
try {
    $guid = [guid]::Parse("tu-guid-aqui")
    Write-Host "✓ GUID válido: $guid" -ForegroundColor Green
}
catch {
    Write-Host "✗ GUID inválido: $_" -ForegroundColor Red
}

# Ejemplos
[guid]::Parse("a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6")  # ✅ Funciona
[guid]::Parse("1234567-1234-1234-1234-123456789012")     # ❌ Falla
```

## Generar un GUID Válido

### En PowerShell

```powershell
# Generar un nuevo GUID
[guid]::NewGuid().Guid

# Ejemplo de salida
# a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6
```

### En Línea

Puedes usar generadores en línea (si no tienes PowerShell disponible):
- https://www.guidgenerator.com/
- https://guid.one/
- https://www.uuidgenerator.net/

## Localizar el Problema

### Encontrar el GUID Inválido

```powershell
# Abre el archivo y busca la línea GUID
Get-Content .\WhisperTranslator\WhisperTranslator.psd1 | Select-String -Pattern "GUID"

# Ejemplo de salida:
# GUID = '1234567-1234-1234-1234-123456789012'
```

### Verificar Todos los Archivos .psd1

```powershell
# Busca todos los archivos .psd1 en el proyecto
Get-ChildItem -Recurse -Filter "*.psd1"

# Para cada archivo, verifica el GUID
foreach ($file in (Get-ChildItem -Recurse -Filter "*.psd1")) {
    Write-Host "Archivo: $($file.FullName)"
    Get-Content $file | Select-String -Pattern "GUID"
}
```

## Troubleshooting Adicional

### "El GUID aún es inválido después de la corrección"

Verifica que:
1. ✓ El GUID tiene exactamente 36 caracteres (32 dígitos + 4 guiones)
2. ✓ Usa solo dígitos hexadecimales (0-9, A-F, a-f)
3. ✓ Tiene guiones en las posiciones correctas: 8-4-4-4-12
4. ✓ No tiene espacios al inicio o final

```powershell
# Verifica manualmente
$guid = "a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6"
Write-Host "Longitud: $($guid.Length)"  # Debe ser 36
Write-Host "Contenido: $guid"
```

### "Error: Cannot find path"

Verifica que estás en el directorio correcto:

```powershell
# Navega al directorio del módulo
cd C:\Users\alexi\src\WhisperTranslator\WhisperTranslator

# Verifica que el archivo existe
Test-Path .\WhisperTranslator.psd1
```

### "Acceso denegado al guardar"

Ejecuta PowerShell como administrador o verifica permisos:

```powershell
# Ejecuta PowerShell como administrador
# Luego intenta de nuevo

# O verifica permisos
Get-Acl .\WhisperTranslator.psd1
```

## Información Técnica

### Estructura de un GUID Válido

```
a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6
────────────────────────────────────────
|       | |  | |  | |         |
└─ 8    └─4 └─4 └─4 └─ 12 dígitos
  dígitos  dígitos  dígitos  dígitos
```

### Archivo .psd1 Correcto

```powershell
@{
    RootModule = 'WhisperTranslator.psm1'
    ModuleVersion = '0.1.0'
    GUID = 'a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6'  # ✅ Formato correcto
    Author = 'amillanaol'
    Description = 'Módulo para generar subtítulos SRT'
    # ... resto de configuración
}
```

## Cambios Realizados en WhisperTranslator

El archivo `WhisperTranslator.psd1` ha sido actualizado con un GUID válido:

```powershell
GUID = 'a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6'
```

El script `Install-WhisperTranslator.ps1` ahora:
- ✅ Detecta GUIDs inválidos automáticamente
- ✅ Genera un nuevo GUID válido
- ✅ Actualiza el archivo `.psd1`
- ✅ Reintenta la importación

## Verificación Final

```powershell
# Cierra PowerShell completamente
# Abre una NUEVA ventana de PowerShell

# Verifica que el módulo se importa sin errores
Import-Module WhisperTranslator -Verbose

# Verifica que el módulo está cargado
Get-Module WhisperTranslator

# Prueba la función principal
Invoke-WhisperTranslator -Help
```

## Recursos

- [Microsoft Docs - GUIDs](https://learn.microsoft.com/en-us/powershell/scripting/developer/module/modifying-the-psmodulepath-installation-path)
- [about_Module_Manifests](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_module_manifests)
- [Documentación de Instalación](../instalacion/instalacion-rapida.md)
