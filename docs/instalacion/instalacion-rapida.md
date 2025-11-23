# Instalación Rápida y Sencilla

El método recomendado para instalar **WhisperTranslator** es utilizando nuestro script de instalación automatizado. Este se encarga de todo: valida, corrige, copia e instala el módulo en tu sistema de forma permanente.

## Pasos para la Instalación

Sigue estos sencillos pasos para tener el módulo funcionando en minutos.

### 1. Clona el Repositorio

Primero, clona el repositorio de GitHub en tu máquina local si aún no lo has hecho.

```powershell
git clone https://github.com/amillanaol/WhisperTraductor.git
cd WhisperTraductor
```

### 2. Ejecuta el Script de Instalación

Una vez dentro del directorio del proyecto, ejecuta el siguiente comando en tu terminal de PowerShell. Este script se encargará de todo el proceso de instalación.

```powershell
# Navega a la carpeta del módulo y ejecuta el instalador
.\module\Install-WhisperTranslator.ps1
```

El script realizará las siguientes acciones:
- **Creará una carpeta** `WhisperTranslator` en tu directorio de módulos de PowerShell (`~\Documents\PowerShell\Modules`).
- **Copiará** todos los archivos necesarios del módulo a esa nueva ubicación.
- **Validará el manifiesto** del módulo y generará un GUID único si es necesario.
- **Importará el módulo** para verificar que la instalación fue exitosa.

### 3. Abre una Nueva Terminal y Verifica

¡Eso es todo! Para empezar a usar el módulo, es **muy importante** que cierres tu ventana actual de PowerShell y abras una **nueva**. Esto permite que PowerShell detecte el módulo recién instalado.

En la nueva terminal, verifica que el módulo está disponible:

```powershell
# Debería mostrar el módulo WhisperTranslator en la lista
Get-Module -ListAvailable WhisperTranslator

# Prueba que el comando principal del módulo es reconocido
Invoke-WhisperTranslator -Help
```

Si no ves errores, ¡felicidades! Has instalado WhisperTranslator correctamente.

---

## Requisitos Previos

Antes de instalar, asegúrate de tener:

- **Windows PowerShell 5.1 o superior**
- **[Whisper AI](https://github.com/openai/whisper)** instalado y accesible desde la línea de comandos.
- **Python 3.8+** (requerido para Whisper AI).
- **ffmpeg** (requerido por Whisper para procesar archivos de audio/video).

### ¿Cómo Verificar los Requisitos?

```powershell
# 1. Verificar versión de PowerShell
$PSVersionTable.PSVersion

# 2. Verificar Whisper
whisper --version

# 3. Verificar Python
python --version

# 4. Verificar ffmpeg
ffmpeg -version
```

### ¿Cómo Instalar los Requisitos?

Si te falta alguno, aquí tienes cómo instalarlo:

```powershell
# Instalar Whisper (requiere Python)
pip install openai-whisper

# Para instalar ffmpeg, puedes usar un gestor de paquetes como Chocolatey:
# choco install ffmpeg
# O descargarlo manualmente desde https://ffmpeg.org/download.html
```

