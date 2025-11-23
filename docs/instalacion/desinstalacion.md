# Desinstalación

## Desinstalación Automática (Recomendado)

La forma más sencilla y segura de desinstalar WhisperTranslator es usar el script de desinstalación automático:

```powershell
# Desde el directorio del proyecto
.\WhisperTranslator\Uninstall-WhisperTranslator.ps1
```

El script:
- ✅ Descarga el módulo de la sesión actual
- ✅ Elimina el módulo de directorios estándar
- ✅ Limpia aliases
- ✅ Elimina referencias en el perfil de PowerShell
- ✅ Limpia variables de entorno (PATH)
- ✅ Busca y elimina archivos `.cmd` asociados

Te pedirá confirmación antes de cada paso importante.

## Desinstalación Manual

Si prefieres desinstalar manualmente o el script automático no funciona:

### Paso 1: Descargar el módulo

```powershell
# Eliminar el módulo de la sesión actual
Remove-Module -Name "WhisperTranslator" -Force
```

### Paso 2: Eliminar carpeta del módulo

Busca y elimina la carpeta `WhisperTranslator` en las siguientes ubicaciones:

```
C:\Users\[TuUsuario]\Documents\PowerShell\Modules\WhisperTranslator
C:\Users\[TuUsuario]\Documents\WindowsPowerShell\Modules\WhisperTranslator
C:\Program Files\PowerShell\Modules\WhisperTranslator
```

### Paso 3: Eliminar alias

```powershell
# Si creaste un alias
Remove-Item -Path "Alias:\whisper-translator" -Force
```

### Paso 4: Limpiar el perfil de PowerShell

1. Abre el archivo de perfil:
   ```powershell
   notepad $PROFILE
   ```

2. Busca y elimina cualquier línea que contenga `whisper-translator` o `WhisperTranslator`

3. Guarda el archivo

### Paso 5: Limpiar variables de entorno

Si agregaste la ruta del proyecto al PATH:

1. Abre "Variables de entorno"
2. Busca la variable `Path`
3. Elimina la ruta de `WhisperTranslator`
4. Haz clic en "Aceptar"

### Paso 6: Eliminar archivo .cmd

Si creaste un archivo `whisper-translator.cmd`:

```powershell
# Encuentra y elimina el archivo
Remove-Item -Path "C:\ruta\completa\whisper-translator.cmd" -Force
```

## Verificación

Después de desinstalar, verifica que se limpió correctamente:

```powershell
# Cierra completamente PowerShell primero
# Luego reabre una nueva ventana y ejecuta:

# Verifica que el módulo no se carga
Get-Module WhisperTranslator

# Verifica que el comando no funciona
whisper-translator --help

# Limpiar la sesión de sesión
Remove-Item -Path "Alias:\whisper-translator" -Force -ErrorAction SilentlyContinue
```

## Reinstalación

Si después de desinstalar deseas reinstalar:

```powershell
.\WhisperTranslator\Install-WhisperTranslator.ps1
```

## Troubleshooting de Desinstalación

### El módulo aún se carga después de desinstalar

**Solución:**
1. Cierra **completamente** todas las ventanas de PowerShell
2. Abre una nueva ventana de PowerShell
3. Ejecuta: `Get-Module WhisperTranslator`

Si el módulo aún aparece, probablemente está en `$PROFILE`:
```powershell
# Abre el perfil y elimina la línea de carga
notepad $PROFILE
```

### No puedo eliminar la carpeta del módulo

**Solución:**
1. Verifica que PowerShell no está usando el módulo:
   ```powershell
   Remove-Module WhisperTranslator -Force
   ```

2. Si aún así falla, reinicia tu computadora
3. El archivo debería estar bloqueado por algo - intenta de nuevo

### Error de permisos al desinstalar

**Solución:**
1. Ejecuta PowerShell como administrador
2. Intenta de nuevo

## Limpiar Completamente (Nuclear Option)

Si nada funciona, puedes eliminar manualmente todas las carpetas:

```powershell
# Ejecuta como administrador

# Opción 1: Ubicación estándar del usuario
Remove-Item -Path "$env:USERPROFILE\Documents\PowerShell\Modules\WhisperTranslator" -Recurse -Force -ErrorAction SilentlyContinue

# Opción 2: Ubicación para PowerShell de escritorio
Remove-Item -Path "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\WhisperTranslator" -Recurse -Force -ErrorAction SilentlyContinue

# Opción 3: Ubicación del sistema (requiere permisos de admin)
Remove-Item -Path "C:\Program Files\PowerShell\Modules\WhisperTranslator" -Recurse -Force -ErrorAction SilentlyContinue

# Opción 4: Limpiar perfil
(Get-Content $PROFILE) -replace ".*whisper-translator.*`n|.*WhisperTranslator.*`n", "" | Set-Content $PROFILE -Force
```

Luego cierra y reabre PowerShell.
