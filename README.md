# WhisperTranslator

**WhisperTranslator** es una herramienta de PowerShell que automatiza la generación de subtítulos en formato SRT para archivos de video usando [Whisper AI de OpenAI](https://github.com/openai/whisper).

Versión actual: 0.1.0

## Inicio Rápido

```powershell
# 1. Clonar el repositorio
git clone https://github.com/amillanaol/WhisperTraductor.git
cd WhisperTraductor

# 2. Ejecutar el instalador
.\WhisperTranslator\Install-WhisperTranslator.ps1

# 3. Usar el módulo (en una nueva ventana de PowerShell)
Invoke-WhisperTranslator -Directory "." -Model "tiny"
```

O simplemente ejecuta el script sin instalar:
```powershell
.\WispherTranslator.ps1 .
```

## Documentación

### 📦 Instalación
- [Instalación Rápida](docs/instalacion/instalacion-rapida.md) - Guía paso a paso de instalación
- [Desinstalación](docs/instalacion/desinstalacion.md) - Cómo remover limpiamente el módulo
- [Requisitos Previos](docs/instalacion/instalacion-rapida.md#requisitos-previos) - Verificar que tienes todo lo necesario

### 🚀 Uso
- [Guía Completa de Uso](docs/uso/guia-completa-de-uso.md) - Ejemplos, parámetros y mejores prácticas
- [Registro como Comando Global](docs/registro-comando/registro-como-comando-global.md) - Ejecuta `whisper-translator .` desde cualquier lugar

### 🔧 Solución de Problemas
- [Error de GUID Inválido](docs/troubleshooting/invalid-guid-error-on-import-module.md) - Soluciones automáticas y manuales
- [Módulo No Encontrado](docs/troubleshooting/import_module_error.md) - Múltiples soluciones según tu caso
- [Guía de Instalación](docs/guides/using-the-installation-script.md) - Script automático de instalación

### 📚 Documentación Técnica
- [Descripción del Módulo](WhisperTranslator/Descripcion.md) - Arquitectura y componentes técnicos
- [Documentación del Proyecto](docs/articulos/documentacion_proyecto.md) - Visión general y estructura

## Características

- ✅ Procesamiento recursivo de directorios
- ✅ Salto automático de archivos ya procesados
- ✅ Soporte para mp4, mkv, webm
- ✅ Múltiples modelos de Whisper (tiny, base, small, medium, turbo)
- ✅ Optimizado para español
- ✅ Información detallada del progreso

## Ejemplos Rápidos

```powershell
# Procesar directorio actual
Invoke-WhisperTranslator -Directory "."

# Procesar con modelo más preciso
Invoke-WhisperTranslator -d "C:\Videos" -m "medium"

# Procesar archivos MKV
Invoke-WhisperTranslator -d "C:\Videos" -e "mkv"

# Ver ayuda
Invoke-WhisperTranslator -Help
```

## Requisitos

- Windows PowerShell 5.1+
- [Whisper AI](https://github.com/openai/whisper)
- Python 3.8+
- ffmpeg

## Scripts de Mantenimiento

WhisperTranslator incluye scripts automáticos para facilitar la instalación y desinstalación:

| Script | Propósito | Ubicación |
|--------|-----------|-----------|
| **Install-WhisperTranslator.ps1** | Instala el módulo y corrige automáticamente errores comunes (GUID inválido) | `WhisperTranslator/` |
| **Uninstall-WhisperTranslator.ps1** | Desinstala limpiamente el módulo del sistema | `WhisperTranslator/` |

### Usar los Scripts

```powershell
# Instalación automática
.\WhisperTranslator\Install-WhisperTranslator.ps1

# Desinstalación automática y limpia
.\WhisperTranslator\Uninstall-WhisperTranslator.ps1
```

Ver [Desinstalación](docs/instalacion/desinstalacion.md) para más detalles.

## Estado

**Versión:** 0.1.0 (Desarrollo Activo)

Durante el desarrollo se han documentado soluciones para problemas comunes. Consulta la carpeta `docs/` para obtener ayuda detallada.

## Licencia

MIT License - Ver [LICENSE](LICENSE) para detalles.

---

**Para más información, consulta la documentación en la carpeta `docs/`**
