### **Documentación del Proyecto: WhisperTranslator**

---

### 1. Resumen del Proyecto

**WhisperTranslator** es una herramienta de línea de comandos desarrollada en PowerShell que automatiza la transcripción de archivos de video para generar subtítulos en formato `.srt`. Utiliza el modelo de inteligencia artificial [Whisper de OpenAI](https://github.com/openai/whisper) como motor de transcripción.

El proyecto está estructurado de dos maneras:

1.  Como un **módulo de PowerShell** instalable (`WhisperTranslator`), que permite usar el comando `Invoke-WhisperTranslator` desde cualquier parte del sistema.
2.  Como un **script independiente** (`WispherTranslator.ps1`), que puede ser ejecutado directamente para realizar la misma tarea sin necesidad de instalar el módulo.

El objetivo principal es procesar directorios completos de videos, identificar cuáles no tienen subtítulos y generar automáticamente los archivos `.srt` correspondientes en español.

---

### 2. Estructura de Directorios

El proyecto está organizado de la siguiente manera, separando la lógica del módulo, los scripts ejecutables y los archivos de entrada.

```
C:/Users/alexi/src/WhisperTranslator/
├── .markdownlint.json        # Archivo de configuración para el linter de Markdown.
├── LICENSE                   # Archivo de licencia del proyecto (MIT).
├── README.md                 # Documentación principal con instrucciones de instalación y uso.
├── WispherTranslator.ps1     # Script de PowerShell INDEPENDIENTE para ejecutar la transcripción.
├── inputs/                   # Directorio por defecto para colocar los videos a procesar.
└── WhisperTranslator/        # Carpeta que contiene el MÓDULO de PowerShell.
    ├── Descripcion.md        # Documentación técnica detallada de la arquitectura del módulo.
    ├── WhisperTranslator.psd1# Manifiesto del módulo: define metadatos y qué funciones exportar.
    └── WhisperTranslator.psm1# Lógica principal del módulo, donde se definen las funciones.
```

---

### 3. Descripción de Componentes Principales

#### **a) Módulo `WhisperTranslator`**

Este es el núcleo del proyecto, diseñado para ser un componente reutilizable y distribuible.

*   **`WhisperTranslator.psm1` (Archivo de Módulo de Script)**
    *   **Propósito**: Contiene toda la lógica de programación.
    *   **Función Principal**: `Invoke-WhisperTranslator`. Esta es la función pública que se ejecuta. Acepta parámetros como el directorio (`-Directory`), el modelo de Whisper (`-Model`) y la extensión de archivo (`-Extension`).
    *   **Funciones Auxiliares**: Contiene funciones internas como `Test-VideoFileExists`, `Test-SrtFileExists` y `Invoke-VideoFiles` que se encargan de buscar archivos, verificar si ya existen subtítulos y llamar al proceso de Whisper.
    *   **Lógica Clave**: La función `Invoke-VideoFiles` itera sobre los videos, y si un video no tiene su archivo `.srt` correspondiente, ejecuta el comando `whisper "$video.FullName" --language Spanish ...` para generar la transcripción.

*   **`WhisperTranslator.psd1` (Archivo de Manifiesto de Módulo)**
    *   **Propósito**: Define las propiedades del módulo.
    *   **Configuración**: Especifica la versión (`0.1.0`), el autor (`amillanaol`), y lo más importante, declara que la única función visible y exportada al usuario es `Invoke-WhisperTranslator`, manteniendo las demás como internas.

#### **b) Script Independiente `WispherTranslator.ps1`**

*   **Propósito**: Ofrecer una forma rápida de usar la funcionalidad sin instalar el módulo. Es un script "todo en uno".
*   **Funcionalidad**: Replica casi exactamente la lógica contenida en `WhisperTranslator.psm1`, pero está diseñado para ser ejecutado directamente (ej: `./WispherTranslator.ps1 -d "C:\mis_videos"`).
*   **Observación**: El nombre del archivo (`Wispher...`) contiene una errata en comparación con el nombre del proyecto (`Whisper...`).

#### **c) Directorio `inputs/`**

*   **Propósito**: Es la carpeta designada por defecto para que el usuario coloque los archivos de video (`.mp4`, `.mkv`, etc.) que desea transcribir. Tanto el módulo como el script independiente buscarán en esta carpeta si no se especifica otra ubicación.

#### **d) Archivos de Documentación**

*   **`README.md`**: Es la guía principal para el usuario final. Explica qué hace el proyecto, cómo instalarlo y cómo usarlo con ejemplos prácticos.
*   **`Descripcion.md`**: Es una documentación más técnica y profunda, orientada a desarrolladores. Detalla la arquitectura, el flujo de trabajo, las funciones y las dependencias del módulo.

---

En resumen, tu proyecto está muy bien estructurado, ofreciendo tanto la flexibilidad de un script rápido como la robustez de un módulo instalable. La documentación existente es clara y ayuda a entender rápidamente su propósito y funcionamiento.
