# Registro como Comando Global

Para poder ejecutar `whisper-translator .` desde cualquier ubicación del sistema, necesitas registrar el comando.

## Opción 1: Agregar el directorio al PATH (Recomendado)

### En Windows 10/11

1. **Obtén la ruta completa del directorio del proyecto:**

   Abre PowerShell en la carpeta del proyecto y ejecuta:
   ```powershell
   Get-Location
   ```
   Copia la ruta que aparece (ej: `C:\Users\alexi\src\WhisperTranslator`)

2. **Abre el administrador de variables de entorno:**
   - Presiona `Win + X`
   - Selecciona "Sistema"
   - Haz clic en "Configuración avanzada del sistema"
   - Haz clic en "Variables de entorno"

3. **Agrega la ruta al PATH:**
   - En la sección "Variables de usuario", haz clic en "Nueva..."
   - Si existe una variable llamada `Path`, haz clic en "Editar..."
   - Agrégale la ruta de tu proyecto (ej: `C:\Users\alexi\src\WhisperTranslator`)
   - Haz clic en "Aceptar"

4. **Cierra todas las ventanas de PowerShell**

5. **Abre una nueva ventana de PowerShell** y prueba:
   ```powershell
   whisper-translator .
   ```

## Opción 2: Crear archivo .cmd (Alternativa)

Si la opción anterior no funciona, crea un archivo ejecutable:

1. **Abre el Bloc de Notas o tu editor favorito**

2. **Copia el siguiente contenido:**
   ```cmd
   @echo off
   pwsh -File "%~dp0WispherTranslator.ps1" %*
   ```

3. **Guarda el archivo como `whisper-translator.cmd`** en el mismo directorio del proyecto

4. **Asegúrate de agregar este directorio al PATH** (ver Opción 1, paso 2-3)

5. **Abre una nueva terminal y prueba:**
   ```powershell
   whisper-translator .
   ```

## Opción 3: Crear un Alias en PowerShell (Temporal)

Esta opción funciona solo en la sesión actual:

1. Abre PowerShell

2. Crea el alias:
   ```powershell
   Set-Alias -Name whisper-translator -Value "C:\ruta\completa\WispherTranslator.ps1"
   ```

3. Prueba:
   ```powershell
   whisper-translator .
   ```

### Hacer el Alias Permanente

Para que el alias persista en futuras sesiones:

1. Copia el comando `Set-Alias` anterior

2. Abre tu perfil de PowerShell:
   ```powershell
   # Verifica si existe
   Test-Path $PROFILE
   
   # Si no existe, créalo
   if (!(Test-Path $PROFILE)) { New-Item -Path $PROFILE -Type File -Force }
   
   # Abre el archivo en tu editor favorito
   notepad $PROFILE
   ```

3. Pega el comando `Set-Alias` al final del archivo

4. Guarda y cierra

5. Reinicia PowerShell para que se aplique

## Verificación

Para verificar que el comando está registrado correctamente:

```powershell
# Verifica que se encuentra en el PATH
Get-Command whisper-translator

# Prueba con un parámetro
whisper-translator -Help
```

## Troubleshooting

**Problema: "whisper-translator no se reconoce como comando"**

Solución:
- Verifica que el directorio está en `$env:PSModulePath`
- Cierra completamente PowerShell (todas las ventanas)
- Abre una nueva ventana de PowerShell
- Si el archivo `.cmd` está presente, asegúrate de que está en el mismo directorio que `WispherTranslator.ps1`

**Problema: "El sistema no puede encontrar la ruta especificada"**

Solución:
- Verifica que la ruta agregada al PATH es correcta
- Usa la ruta completa sin caracteres especiales
- No uses comillas en la variable PATH

**Problema: "Acceso denegado"**

Solución:
- Ejecuta PowerShell como administrador
- Verifica que tienes permisos de lectura en el directorio del proyecto

## Verificación Final

Desde cualquier ubicación del sistema, prueba:

```powershell
cd C:\
whisper-translator .
```

Si funciona, está correctamente registrado como comando global.
