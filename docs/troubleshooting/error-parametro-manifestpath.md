# Error: Parámetro 'ManifestPath' No Válido en Import-Module

## Problema

Al ejecutar el script de instalación `Install-WhisperTranslator.ps1`, obtienes el siguiente error:

```
Write-Error: Ocurrió un error inesperado al importar el módulo: A parameter cannot be found 
that matches parameter name 'ManifestPath'.
Exception: ...\Install-WhisperTranslator.ps1:11:19
Line |
  11 |      Import-Module -ManifestPath $ModuleManifest -ErrorAction Stop
     |                    ~~~~~~~~~~~~~
     | A parameter cannot be found that matches parameter name 'ManifestPath'.
```

## Causa

El parámetro `-ManifestPath` **no existe** en el comando `Import-Module` de PowerShell. Este fue un error en el script de instalación que usaba un nombre de parámetro incorrecto.

Los parámetros válidos de `Import-Module` son:
- `-Name` - Especifica el nombre del módulo
- `-FullyQualifiedName` - Para módulos con versiones específicas (PowerShell 5.1+)
- `-Path` - Ruta a un archivo de módulo (.psm1)
- `-Assembly` - Para módulos .NET

## Solución

### Opción 1: Usar la Versión Corregida (Recomendado)

La versión actual de `Install-WhisperTranslator.ps1` ya ha sido corregida. Simplemente ejecuta:

```powershell
# Desde el directorio del proyecto
.\module\Install-WhisperTranslator.ps1
```

### Opción 2: Importar Manualmente (Si aún tienes el error)

```powershell
# Navega al directorio del proyecto
cd C:\ruta\a\WhisperTranslator

# Importa el módulo usando -Path
Import-Module -Path ".\module\WhisperTranslator.psm1"

# O usa el directorio directamente
Import-Module -Name ".\module"
```

### Opción 3: Instalar el Módulo Globalmente

```powershell
# Copia el módulo a la carpeta de módulos
$userModulesPath = "$env:USERPROFILE\Documents\PowerShell\Modules"
Copy-Item -Path ".\WhisperTranslator" -Destination $userModulesPath -Recurse -Force

# Abre una NUEVA ventana de PowerShell
# Luego importa:
Import-Module WhisperTranslator
```

## Cambios Realizados en el Script

El script `Install-WhisperTranslator.ps1` ha sido actualizado para:

- ✅ Usar `-Name` en lugar de `-ManifestPath`
- ✅ Pasar la ruta correcta del módulo
- ✅ Incluir mejor manejo de errores
- ✅ Agregar mensajes informativos con colores
- ✅ Mostrar instrucciones después de la instalación

### Antes (Código Incorrecto)

```powershell
Import-Module -ManifestPath $ModuleManifest -ErrorAction Stop
```

### Después (Código Correcto)

```powershell
Import-Module -Name $ModulePath -ErrorAction Stop
```

## Verificación

Para verificar que tu módulo se importó correctamente:

```powershell
# Cierra PowerShell completamente
# Abre una NUEVA ventana de PowerShell

# Verifica que el módulo está cargado
Get-Module WhisperTranslator

# Si no aparece, intenta importarlo
Import-Module WhisperTranslator

# Verifica las funciones disponibles
Get-Command -Module WhisperTranslator

# Prueba la función principal
Invoke-WhisperTranslator -Help
```

## Información Técnica: Parámetros de Import-Module

### Parámetros Disponibles

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `-Name` | String | Nombre del módulo a importar |
| `-FullyQualifiedName` | ModuleSpecification | Nombre del módulo con versión específica |
| `-Path` | String | Ruta a un archivo de módulo (.psm1, .psd1) |
| `-Assembly` | Assembly | Especifica un ensamblado .NET |
| `-ErrorAction` | ActionPreference | Qué hacer si ocurre un error |
| `-Force` | Switch | Recarga el módulo aunque ya esté cargado |
| `-AsCustomObject` | Switch | Retorna un PSCustomObject en lugar de cargar el módulo |

### Ejemplos de Uso Correcto

```powershell
# Por nombre (si está en $PSModulePath)
Import-Module -Name "WhisperTranslator"

# Por ruta completa
Import-Module -Path "$env:USERPROFILE\Documents\PowerShell\Modules\WhisperTranslator\WhisperTranslator.psm1"

# Con versión específica (PowerShell 5.1+)
$ModuleSpec = @{ ModuleName = "WhisperTranslator"; ModuleVersion = "0.1.0" }
Import-Module -FullyQualifiedName $ModuleSpec

# Recargar un módulo
Import-Module -Name "WhisperTranslator" -Force
```

## Troubleshooting Adicional

### "El módulo no se encuentra"

```powershell
# Verifica dónde PowerShell busca módulos
$env:PSModulePath

# Agrega una nueva ruta si es necesario
$ModulePath = "$env:USERPROFILE\Documents\PowerShell\Modules"
$env:PSModulePath += ";$ModulePath"
```

### "Acceso denegado"

```powershell
# Ejecuta PowerShell como administrador
# O verifica permisos en la carpeta del módulo
Get-Acl -Path ".\WhisperTranslator"
```

### El módulo se carga pero genera errores

```powershell
# Verifica que el archivo .psd1 tiene un GUID válido
# Abre el archivo y busca la línea GUID
notepad ".\WhisperTranslator\WhisperTranslator.psd1"

# Si el GUID está vacío o es inválido, el script lo corrige automáticamente
# O genera uno nuevo:
[guid]::NewGuid().Guid
```

## Recursos

- [Documentación oficial de Import-Module](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/import-module)
- [Creación de Módulos de PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/developer/module/writing-a-windows-powershell-module)
- [Guía de Instalación de WhisperTranslator](../instalacion/instalacion-rapida.md)
