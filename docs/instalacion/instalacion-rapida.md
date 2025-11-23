# Instalación Rápida

## Opción 1: Instalación desde el repositorio (Recomendado)

1. Clona este repositorio:

   ```powershell
   git clone https://github.com/amillanaol/WhisperTraductor.git
   cd WhisperTraductor
   ```

2. **Importante:** Ejecuta el script de instalación que corrige automáticamente problemas comunes:

   ```powershell
   .\WhisperTranslator\Install-WhisperTranslator.ps1
   ```

   Este script:
   - Detecta y corrige automáticamente el GUID del manifiesto del módulo (si es inválido)
   - Importa el módulo correctamente
   - Prepara el módulo para ser utilizado

3. Abre una **nueva ventana de PowerShell** y verifica que el módulo funciona:

   ```powershell
   Get-Module WhisperTranslator
   Invoke-WhisperTranslator -Help
   ```

## Opción 2: Instalación manual en el sistema

Si prefieres instalar el módulo de forma permanente:

```powershell
# Copiar el módulo a la carpeta de módulos del usuario
$userModulesPath = "$env:USERPROFILE\Documents\PowerShell\Modules"
Copy-Item -Path ".\WhisperTranslator" -Destination $userModulesPath -Recurse -Force

# Luego abre una nueva ventana de PowerShell y ejecuta:
Import-Module WhisperTranslator
```

## Opción 3: Uso del script independiente (Sin instalación)

Si prefieres no instalar un módulo, puedes ejecutar directamente el script `WispherTranslator.ps1`:

```powershell
.\WispherTranslator.ps1 -Directory ".\inputs" -Model "tiny"
```

---

## Requisitos Previos

Antes de instalar, asegúrate de tener:

- **Windows PowerShell 5.1 o superior**
- **[Whisper AI](https://github.com/openai/whisper)** instalado y accesible desde la línea de comandos
- **Python 3.8+** (requerido para Whisper AI)
- **ffmpeg** (requerido por Whisper para procesar archivos de audio/video)

### Verificar Requisitos

```powershell
# Verificar versión de PowerShell
$PSVersionTable.PSVersion

# Verificar Whisper
whisper --version

# Verificar Python
python --version

# Verificar ffmpeg
ffmpeg -version
```

### Instalar Requisitos Faltantes

Si faltan requisitos, instálalos:

```powershell
# Instalar Whisper (requiere Python)
pip install openai-whisper

# Para instalar ffmpeg, descárgalo desde:
# https://ffmpeg.org/download.html
# O si tienes Chocolatey:
# choco install ffmpeg
```
