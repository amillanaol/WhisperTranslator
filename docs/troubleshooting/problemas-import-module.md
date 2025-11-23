# Problemas Comunes de Import-Module en PowerShell

## Resumen de Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| Parámetro 'ManifestPath' no válido | Nombre incorrecto de parámetro | Usar `-Name` o `-Path` |
| Módulo no encontrado | Ruta no en PSModulePath | Instalar en ruta correcta o usar ruta completa |
| GUID no válido | Archivo .psd1 corrupto | Ver [Error de GUID](invalid-guid-error-on-import-module.md) |
| Acceso denegado | Permisos insuficientes | Ejecutar como administrador |
| El módulo no se actualiza | Módulo ya cargado en sesión | Usar `-Force` o abrir nueva sesión |

## Errores Específicos y Soluciones

### Error: "A parameter cannot be found that matches parameter name"

**Síntoma:**
```
A parameter cannot be found that matches parameter name 'ManifestPath'
A parameter cannot be found that matches parameter name 'SomeOtherName'
```

**Causa:** Estás usando un nombre de parámetro que no existe.

**Solución:**
```powershell
# ❌ Incorrecto
Import-Module -ManifestPath "C:\path\to\module.psd1"

# ✅ Correcto (opción 1)
Import-Module -Path "C:\path\to\module.psd1"

# ✅ Correcto (opción 2)
Import-Module -Name "ModuleName"

# ✅ Correcto (opción 3)
Import-Module "C:\path\to\module.psd1"
```

### Error: "No valid module file was found"

**Síntoma:**
```
The specified module 'WhisperTranslator' was not loaded because no valid module file was found in any module directory.
```

**Causa:** El módulo no está en las rutas de búsqueda de PowerShell.

**Solución:**
```powershell
# Opción 1: Importar con ruta completa
Import-Module -Path "$env:USERPROFILE\Documents\PowerShell\Modules\WhisperTranslator"

# Opción 2: Instalar en la ruta correcta
Copy-Item -Path ".\WhisperTranslator" -Destination "$env:USERPROFILE\Documents\PowerShell\Modules\" -Recurse -Force

# Opción 3: Agregar ruta a PSModulePath
$env:PSModulePath += ";C:\path\to\modules"
```

### Error: "Member 'guid' is not valid"

**Síntoma:**
```
The 'guid' member is not valid in the module manifest file
```

**Causa:** El GUID en el archivo `.psd1` es inválido.

**Solución:** Ver [Error de GUID Inválido](invalid-guid-error-on-import-module.md)

### Error: "Access to the path is denied"

**Síntoma:**
```
Access to the path 'C:\...\Module.psd1' is denied
```

**Causa:** Permisos insuficientes.

**Solución:**
```powershell
# Ejecuta PowerShell como administrador
# O verifica permisos:
Get-Acl -Path ".\WhisperTranslator"

# Cambiar permisos (si es necesario)
icacls "C:\ruta\al\modulo" /grant Users:F
```

### Error: "The module is loaded in the current session"

**Síntoma:**
```
The module 'WhisperTranslator' is already loaded. 
To load it again, remove the module first.
```

**Causa:** El módulo ya está cargado y no puede ser reemplazado.

**Solución:**
```powershell
# Opción 1: Usar -Force
Import-Module -Name "WhisperTranslator" -Force

# Opción 2: Descargar primero
Remove-Module -Name "WhisperTranslator"
Import-Module -Name "WhisperTranslator"

# Opción 3: Abrir una nueva sesión de PowerShell
exit
# Luego vuelve a abrir PowerShell
```

## Verificación de Import-Module

### Verificar parámetros disponibles

```powershell
# Ver todos los parámetros de Import-Module
Get-Help Import-Module -Parameter *

# Ver sintaxis
Get-Help Import-Module -Syntax
```

### Verificar módulos cargados

```powershell
# Listar todos los módulos cargados
Get-Module

# Listar módulos específicos
Get-Module -Name "WhisperTranslator"

# Listar módulos disponibles (en PSModulePath)
Get-Module -ListAvailable

# Listar módulos de un directorio específico
Get-Module -ListAvailable -Path ".\WhisperTranslator"
```

### Verificar rutas de búsqueda

```powershell
# Ver todas las rutas donde PowerShell busca módulos
$env:PSModulePath -split ";"

# O mostrar de forma más legible
($env:PSModulePath -split ";") | ForEach-Object { Write-Host $_ }
```

## Debugging

### Habilitar mensajes de depuración

```powershell
# Mostrar mensajes detallados
$VerbosePreference = "Continue"
Import-Module -Name "WhisperTranslator" -Verbose

# O con el parámetro -Verbose
Import-Module -Name "WhisperTranslator" -Verbose

# Ver detalles de depuración
$DebugPreference = "Continue"
```

### Probar importación con errores detallados

```powershell
# Importar y capturar errores
try {
    Import-Module -Name "WhisperTranslator" -ErrorAction Stop
    Write-Host "Módulo importado exitosamente" -ForegroundColor Green
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Línea: $($_.InvocationInfo.ScriptLineNumber)" -ForegroundColor Red
    Write-Host "Archivo: $($_.InvocationInfo.ScriptName)" -ForegroundColor Red
}
```

## Mejores Prácticas

### 1. Siempre Verificar en Nueva Sesión

```powershell
# Luego de instalar, cierra PowerShell completamente
# Abre una NUEVA ventana (no pestaña)
# Luego verifica
Get-Module WhisperTranslator
```

### 2. Usar Rutas Completas Cuando Sea Posible

```powershell
# ✅ Mejor (ruta completa)
Import-Module -Path "$env:USERPROFILE\Documents\PowerShell\Modules\WhisperTranslator"

# ⚠️ Puede no funcionar (ruta relativa)
Import-Module -Path ".\WhisperTranslator"
```

### 3. Capturar Errores

```powershell
$ErrorActionPreference = "Stop"

try {
    Import-Module -Name "WhisperTranslator"
}
catch {
    Write-Error "No se pudo importar el módulo: $_"
}
```

### 4. Verificar Dependencias

```powershell
# Ver información del módulo
Get-Module -Name "WhisperTranslator" | Format-List

# Ver funciones exportadas
Get-Module -Name "WhisperTranslator" | 
    Select-Object -ExpandProperty ExportedFunctions

# Ver comandos disponibles
Get-Command -Module "WhisperTranslator"
```

## Recursos

- [Documentación Oficial de Import-Module](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/import-module)
- [Guía de Instalación de WhisperTranslator](../instalacion/instalacion-rapida.md)
- [Error de GUID Inválido](invalid-guid-error-on-import-module.md)
- [Registro como Comando Global](../registro-comando/registro-como-comando-global.md)
