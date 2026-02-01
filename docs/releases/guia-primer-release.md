# Guía de Gestión de Releases en GitHub

**Proyecto:** WhisperTranslator  
**Versión Inicial Recomendada:** v1.0.0  
**Última Actualización:** 23 de noviembre de 2025

---

## Selección de la Primera Versión para Release

Se recomienda crear el release para **v1.0.0** por las siguientes razones:

- Primera versión estable del módulo PowerShell
- Marca un hito importante en el ciclo de desarrollo
- Versión designada para la distribución a usuarios finales
- Etiqueta git ya presente en el repositorio

## Versiones Disponibles para Release

### Versión 1.0.0 (Recomendada - Primera versión estable)
**Tag:** v1.0.0  
**Commit:** 95d6624  
**Nombre:** WhisperTranslator v1.0.0 - Módulo PowerShell  
**Descripción:** Primera versión estable como módulo PowerShell

### Versión 1.1.4 (Última versión con todas las mejoras)
**Tag:** v1.1.4  
**Commit:** 5ea9cd9  
**Nombre:** WhisperTranslator v1.1.4 - Mejoras de Documentación  
**Descripción:** Versión actual con todas las mejoras y documentación completa

### Versión 1.2.0 (Próxima - después de fix del alias)
**Tag:** v1.2.0  
**Commit:** Por crear  
**Nombre:** WhisperTranslator v1.2.0 - Fix Alias wtranslator  
**Descripción:** Fix del alias wtranslator + documentación completa

## Creación de Release mediante Interfaz Web de GitHub

### Paso 1: Navegar a la Sección de Releases
1. Abrir el repositorio: https://github.com/amillanaol/WhisperTranslator
2. Hacer clic en la pestaña "Releases" en la barra de navegación superior
3. Alternativamente, acceder directamente a: https://github.com/amillanaol/WhisperTranslator/releases

### Paso 2: Crear Nuevo Release
1. Seleccionar el botón "Draft a new release"
2. O "Create a new release" si es el primer release

### Paso 3: Configuración del Release

#### Selección de Tag
- En el campo "Choose a tag", seleccionar: v1.0.0
- Si el tag no existe en la rama remota, crear uno nuevo

#### Título del Release
```
WhisperTranslator v1.0.0 - Módulo PowerShell
```

#### Descripción del Release
Utilizar la siguiente estructura de plantilla:

```markdown
# WhisperTranslator v1.0.0

Primera versión estable de WhisperTranslator como módulo de PowerShell.

## Características Incluidas

- Módulo PowerShell instalable
- Generación automática de subtítulos SRT mediante Whisper
- Soporte para múltiples formatos de video (mp4, mkv, webm)
- Modelos de Whisper disponibles (tiny, base, small, medium, turbo)
- Procesamiento por lotes de archivos
- Scripts de instalación y desinstalación

## Instalación

### Instalación Automática
\`\`\`powershell
git clone https://github.com/amillanaol/WhisperTranslator.git
cd WhisperTranslator
.\module\Install-WhisperTranslator.ps1
\`\`\`

### Instalación Manual
1. Descargar el módulo desde esta release
2. Extraer en: C:\Users\[Usuario]\Documents\PowerShell\Modules\WhisperTranslator
3. Reiniciar PowerShell

## Uso

\`\`\`powershell
Import-Module WhisperTranslator
Invoke-WhisperTranslator -Directory ".\inputs" -Model tiny -Extension mp4
\`\`\`

## Requisitos del Sistema

- PowerShell 5.1 o superior
- Whisper instalado en el sistema
- Python 3.8 o superior
- FFmpeg instalado

## Comandos Disponibles

| Comando | Parámetro | Descripción |
|---------|-----------|-------------|
| Invoke-WhisperTranslator | -Directory / -d | Directorio con archivos de video |
| | -Model / -m | Modelo de Whisper a utilizar |
| | -Extension / -e | Extensión de archivos a procesar |
| | -Version / -v | Versión del módulo |
| | -Help | Mostrar ayuda del comando |

## Documentación

- [README](https://github.com/amillanaol/WhisperTranslator/blob/main/README.md)
- [Guía de Instalación](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/instalacion)
- [Guía de Uso](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/uso)

## Problemas Conocidos

Ninguno reportado en esta versión.

## Licencia

Proyecto bajo licencia MIT. Consultar [LICENSE](https://github.com/amillanaol/WhisperTranslator/blob/main/LICENSE).

Autor: amillanaol  
Fecha de lanzamiento: 24 de febrero de 2025  
Commit: 95d6624
\`\`\`

#### Configuración Adicional
- Pre-release: Desmarcar esta opción (versión estable)
- Create a discussion for this release: Opcional

### Paso 4: Publicación
1. Seleccionar el botón "Publish release"
2. El release se publicará inmediatamente

## Creación de Release mediante GitHub CLI

Para usuarios que cuenten con GitHub CLI instalado:

```powershell
# Instalación de GitHub CLI (si es necesario)
winget install GitHub.cli

# Autenticación
gh auth login

# Creación del release
gh release create v1.0.0 `
  --title "WhisperTranslator v1.0.0 - Módulo PowerShell" `
  --notes-file docs/releases/release-notes-v1.0.0.md
```

Este método es equivalente a la creación mediante la interfaz web.

## Notas de Versión Pre-configuradas

### Versión 1.0.0 - Primera versión estable

Ver sección anterior de descripción de release.

### Versión 1.1.0 - Funcionalidad de desinstalación

```markdown
# WhisperTranslator v1.1.0

## Características Agregadas

- Script de desinstalación automática
- Documentación de desinstalación
- Mejoras en el proceso de instalación

## Mejoras Técnicas

- Mejor manejo de errores durante la instalación
- Documentación mejorada
- Nueva guía de desinstalación
```

### Versión 1.1.1 - Corrección crítica GUID

```markdown
# WhisperTranslator v1.1.1

## Correcciones Críticas

GUID inválido en el manifiesto del módulo ha sido corregido.

**Impacto:** El módulo ahora se importa correctamente sin errores de validación del manifiesto.

## Detalles Técnicos

- GUID del módulo actualizado a formato válido
- Validación del archivo .psd1 completada
- Se recomienda actualizar a esta versión
```

## Adjunción de Archivos al Release

### Crear Archivo Comprimido del Módulo

```powershell
Compress-Archive -Path .\module\* -DestinationPath WhisperTranslator-v1.0.0.zip
```

### Subir el Archivo a GitHub

1. Navegar a la página del release recién creado
2. En la sección "Attach binaries", arrastrar el archivo ZIP o seleccionar archivos
3. El archivo estará disponible para descarga directa desde la página de release

## Actualización de Documentación Post-Release

### Agregar Badge de Versión al README

Insertar en el archivo README.md:

```markdown
[![GitHub release](https://img.shields.io/github/v/release/amillanaol/WhisperTranslator)](https://github.com/amillanaol/WhisperTranslator/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://github.com/PowerShell/PowerShell)
```

## Lista de Verificación Pre-Release

Antes de publicar un release, validar los siguientes puntos:

- Tag existe en el repositorio local (`git tag -l`)
- Tag ha sido enviado a GitHub (`git push origin v1.0.0`)
- Título del release es descriptivo y sigue convenciones de nomenclatura
- Descripción incluye características principales
- Descripción incluye instrucciones de instalación
- Descripción incluye ejemplos de uso de los comandos
- La opción "Pre-release" está deshabilitada (a menos que sea una versión preliminar)
- Archivos adjuntos han sido incluidos y son accesibles
- Documentación referenciada está actualizada
- Cambios log está completo

## Tareas Post-Release

### 1. Verificación del Release
- Navegar a: https://github.com/amillanaol/WhisperTranslator/releases
- Validar que el release aparece correctamente
- Confirmar que los archivos adjuntos son accesibles

### 2. Actualización de Documentación
Actualizar el README.md con:
```markdown
## Instalación

**Última versión:** [v1.0.0](https://github.com/amillanaol/WhisperTranslator/releases/tag/v1.0.0)
```

### 3. Notificación a Usuarios (Opcional)
- Publicar anuncio del release en canales pertinentes
- Incluir enlace al release en el repositorio
- Documentar cambios en el changelog

## Roadmap de Releases Futuros

### Versión 1.2.0 - Corrección del alias wtranslator

Tras implementar la corrección del alias:

```markdown
# WhisperTranslator v1.2.0

## Correcciones de Defectos

El alias `wtranslator` no se exportaba correctamente aunque estaba declarado en el manifiesto del módulo.

**Solución:** Implementada creación y exportación del alias mediante `New-Alias` y actualización de `Export-ModuleMember`.

## Cambios Técnicos

- Modificación de `WhisperTranslator.psm1` para creación y exportación del alias
- Documentación técnica actualizada con mejores prácticas para aliases en módulos

## Documentación

Consultar la sección de troubleshooting para información adicional sobre la resolución de esta incidencia.
```

## Mejores Prácticas para Gestión de Releases

### Versionado Semántico
Utilizar el formato MAJOR.MINOR.PATCH (ej: 1.0.0):
- **MAJOR:** Cambios incompatibles con versiones anteriores
- **MINOR:** Nuevas funcionalidades compatibles con versiones anteriores
- **PATCH:** Correcciones de defectos

### Documentación de Release Notes
- Escribir notas claras y comprensibles para usuarios finales
- Incluir ejemplos de instalación y uso
- Listar cambios incompatibles de forma explícita
- Proporcionar enlaces a documentación relacionada

### Estructura de Contenido
1. Descripción breve del release
2. Lista de características nuevas o modificadas
3. Instrucciones de instalación y actualización
4. Requisitos del sistema
5. Documentación relacionada y enlaces
6. Información técnica adicional
7. Notas sobre problemas conocidos

### Gestión de Artefactos
- Adjuntar archivos comprimidos del módulo
- Incluir información de checksums para integridad
- Documentar dependencias y requisitos previos

### Control de Versiones Pre-Release
- Utilizar sufijo "beta", "rc" u similar para versiones preliminares
- Marcar explícitamente como "Pre-release" en GitHub
- Recopilar feedback de usuarios antes de release estable

---

## Referencias Técnicas

Para información adicional consultar:
- [GitHub Releases Documentation](https://docs.github.com/en/repositories/releasing-projects-on-github)
- [Semantic Versioning](https://semver.org/)
- [PowerShell Module Development Best Practices](https://learn.microsoft.com/en-us/powershell/scripting/developer/module/understanding-a-windows-powershell-module)
