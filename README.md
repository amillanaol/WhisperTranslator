# WhisperTranslator

Módulo de PowerShell que permite generar automáticamente subtítulos en formato SRT
para archivos de video utilizando Whisper AI. Este módulo está diseñado para ser
instalado globalmente y poder ser utilizado desde cualquier ubicación en tu sistema.

Versión actual: 0.1.0

## Requisitos Previos

- Windows PowerShell 5.1 o superior
- [Whisper AI](https://github.com/openai/whisper) instalado y configurado en el sistema
- Python (requerido para Whisper AI)

## Instalación

Hay dos formas de instalar el módulo:

### Opción 1: Instalación desde el repositorio

1. Clona este repositorio:

   ```powershell
   git clone https://github.com/amillanaol/WhisperTraductor.git
   cd WhisperTraductor
   ```

2. Copia la carpeta `WhisperTranslator` a tu directorio de módulos de PowerShell:

```powershell
Copy-Item -Path ".\WhisperTranslator" -Destination "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\"-Recurse
```

### Opción 2: Instalación manual

1. Descarga el último release desde la [página de releases](https://github.com/amillanaol/WhisperTraductor/releases)
2. Extrae el contenido y copia la carpeta `WhisperTranslator` a:

   ```console
   %USERPROFILE%\Documents\WindowsPowerShell\Modules\
   ```

### Verificación de la instalación

1. Abre una nueva ventana de PowerShell e importa el módulo:

   ```powershell
   Import-Module WhisperTranslator
   ```

2. Verifica que el módulo está instalado correctamente:

   ```powershell
   Get-Module WhisperTranslator
   # O comprueba la versión
   Invoke-WhisperTranslator -Version
   ```

## ¿Como utilizar esta herramienta?

El módulo proporciona el comando `Invoke-WhisperTranslator` que se puede ejecutar
desde cualquier ubicación:

```powershell
Invoke-WhisperTranslator [-Directory <ruta_directorio>] [-Model <modelo>] [-Extension<extensión>] [-Version]
```

### Parámetros

- `-Directory` o `-d`: Ruta al directorio que contiene los archivos de video
  - Valor por defecto: carpeta `inputs` en el directorio actual
- `-Model` o `-m`: Modelo de Whisper a utilizar
  - Valores permitidos: `base`, `tiny`, `small`, `medium`, `turbo`
  - Valor por defecto: `tiny`
- `-Extension` o `-e`: Extensión de los archivos a procesar
  - Valores permitidos: `mp4`, `mkv`, `webm`
  - Valor por defecto: `mp4`
- `-Version` o `-v`: Muestra la versión actual del módulo
- `-Help`: Muestra el mensaje de ayuda con instrucciones de uso

### Ejemplos de Uso

1. Ejecutar con valores por defecto (carpeta `inputs`, modelo tiny, archivos mp4):

```powershell
Invoke-WhisperTranslator
```

2. Procesar archivos MKV usando el modelo base:

```powershell
Invoke-WhisperTranslator -Directory "C:\Videos" -Model "base" -Extension "mkv"
```

3. Procesar archivos WEBM usando un modelo más preciso:

```powershell
Invoke-WhisperTranslator -d "C:\Videos" -m "medium" -e "webm"
```

4. Ver la versión del módulo:

```powershell
Invoke-WhisperTranslator -Version
```

5. Ver la ayuda:

```powershell
Invoke-WhisperTranslator -Help
```

## Funcionamiento

El módulo funciona de la siguiente manera:

1. Al ejecutar `Invoke-WhisperTranslator`, el módulo:
   - Busca recursivamente todos los archivos del formato especificado en el directorioindicado
   - Verifica la existencia de archivos SRT para cada video
   - Procesa solo los archivos que no tienen subtítulos existentes
   - Muestra información detallada del progreso

2. Proceso de transcripción:
   - Utiliza Whisper AI para generar las transcripciones
   - Optimizado para el idioma español
   - Genera archivos SRT con el mismo nombre que el video
   - Conserva la estructura de directorios original

3. Características de optimización:
   - Procesamiento recursivo de subdirectorios
   - Salto automático de archivos ya procesados
   - Soporte para múltiples formatos de video
   - Selección flexible del modelo de Whisper

## Notas y Mejores Prácticas

- Selección de modelo:
  - `tiny`: Rápido pero menos preciso (default)
  - `base`: Balance entre velocidad y precisión
  - `small`: Mayor precisión, más lento
  - `medium`: Alta precisión, proceso más lento
  - `turbo`: Optimizado para velocidad en GPU

- Recomendaciones:
  - Organiza los videos en carpetas por categorías
  - Usa el modelo según tus necesidades de precisión
  - Verifica el espacio disponible antes de procesar grandes cantidades de archivos
  - Para archivos largos, considera usar modelos más ligeros

## Desarrollo y Contribución

Si deseas contribuir al desarrollo de este módulo:

1. Fork el repositorio
2. Crea una rama para tu feature: `git checkout -b feature/nueva-caracteristica`
3. Haz tus cambios y commit: `git commit -am 'Añade nueva característica'`
4. Push a la rama: `git push origin feature/nueva-caracteristica`
5. Crea un Pull Request

### Estructura del Módulo

```txt
WhisperTranslator/
├── WhisperTranslator.psd1    # Manifiesto del módulo
├── WhisperTranslator.psm1    # Código principal del módulo
└── inputs/                   # Directorio por defecto para videos
```

## Licencias

- Este módulo está licenciado bajo la licencia MIT
- Utiliza [Whisper](https://github.com/openai/whisper) de OpenAI, también bajo licenciaMIT
- Versión actual: 0.1.0

## Actualizaciones y Soporte

Para reportar problemas o sugerir mejoras:

- Abre un issue en el [repositorio de GitHub](https://github.com/amillanaol/WhisperTraductor/issues)
- Consulta la [documentación de Whisper](https://github.com/openai/whisper) paradetalles sobre los modelos
