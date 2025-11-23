# Guía para Crear tu Primer Release en GitHub

**Proyecto:** WhisperTranslator  
**Primera Release Recomendada:** v1.0.0  
**Fecha:** 23 de noviembre de 2025

---

## 🎯 ¿Qué Release crear primero?

Recomiendo crear el release para **v1.0.0** porque:
- ✅ Es la primera versión estable del módulo PowerShell
- ✅ Marca un hito importante en el proyecto
- ✅ Es la versión que los usuarios deberían usar
- ✅ Ya tiene la etiqueta creada

---

## 📋 Opciones de Release

### Opción 1: v1.0.0 (Recomendada - Primera versión estable)
**Tag:** v1.0.0  
**Commit:** `95d6624`  
**Nombre:** WhisperTranslator v1.0.0 - Módulo PowerShell  
**Descripción:** Primera versión estable como módulo PowerShell

### Opción 2: v1.1.4 (Última versión con todas las mejoras)
**Tag:** v1.1.4  
**Commit:** `5ea9cd9`  
**Nombre:** WhisperTranslator v1.1.4 - Mejoras de Documentación  
**Descripción:** Versión actual con todas las mejoras y documentación completa

### Opción 3: v1.2.0 (Próxima - después de fix del alias)
**Tag:** v1.2.0  
**Commit:** Por crear  
**Nombre:** WhisperTranslator v1.2.0 - Fix Alias wtranslator  
**Descripción:** Fix del alias wtranslator + documentación completa

---

## 🚀 Método 1: Crear Release desde GitHub (Recomendado)

### Paso 1: Ir a GitHub
1. Abre tu navegador
2. Ve a: `https://github.com/amillanaol/WhisperTranslator`
3. Inicia sesión si es necesario

### Paso 2: Navegar a Releases
1. Haz clic en la pestaña **"Releases"** (o "Versiones" en español)
   - Está en la barra superior junto a "Code", "Issues", "Pull requests"
2. O ve directamente a: `https://github.com/amillanaol/WhisperTranslator/releases`

### Paso 3: Crear nuevo Release
1. Haz clic en el botón **"Draft a new release"** (Crear nueva versión)
2. O haz clic en **"Create a new release"**

### Paso 4: Configurar el Release

#### A. Elegir Tag
- En "Choose a tag", selecciona: **v1.0.0**
- O escribe "v1.0.0" si no aparece en la lista

#### B. Título del Release
```
WhisperTranslator v1.0.0 - Módulo PowerShell
```

#### C. Descripción del Release
Copia y pega esto (lo personalizaremos después):

```markdown
# 🎉 WhisperTranslator v1.0.0

Primera versión estable de WhisperTranslator como **módulo de PowerShell**.

## ✨ Características Principales

- ✅ Módulo PowerShell instalable
- ✅ Generación automática de subtítulos SRT usando Whisper
- ✅ Soporte para múltiples formatos de video (mp4, mkv, webm)
- ✅ Múltiples modelos de Whisper (tiny, base, small, medium, turbo)
- ✅ Procesamiento por lotes de archivos
- ✅ Scripts de instalación y desinstalación

## 📦 Instalación

### Opción 1: Instalación Automática
```powershell
# Clonar el repositorio
git clone https://github.com/amillanaol/WhisperTranslator.git
cd WhisperTranslator

# Ejecutar script de instalación
.\module\Install-WhisperTranslator.ps1
```

### Opción 2: Instalación Manual
1. Descargar el módulo desde esta release
2. Extraer a: `C:\Users\TuUsuario\Documents\PowerShell\Modules\WhisperTranslator`
3. Reiniciar PowerShell

## 🎯 Uso Básico

```powershell
# Importar el módulo
Import-Module WhisperTranslator

# Usar el comando principal
Invoke-WhisperTranslator -Directory ".\inputs" -Model tiny -Extension mp4

# Ver ayuda
Invoke-WhisperTranslator -Help
```

## 📋 Requisitos Previos

- PowerShell 5.1 o superior
- Whisper instalado en el sistema
- Python 3.8 o superior
- FFmpeg instalado

## 🔧 Comandos Disponibles

| Comando | Descripción |
|---------|-------------|
| `Invoke-WhisperTranslator` | Comando principal para procesar videos |
| `-Directory` / `-d` | Directorio con archivos de video |
| `-Model` / `-m` | Modelo de Whisper a usar |
| `-Extension` / `-e` | Extensión de archivos a procesar |
| `-Version` / `-v` | Muestra versión del módulo |
| `-Help` | Muestra ayuda |

## 📚 Documentación

- [README](https://github.com/amillanaol/WhisperTranslator/blob/main/README.md)
- [Guía de Instalación](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/instalacion)
- [Guía de Uso](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/uso)

## 🐛 Problemas Conocidos

- Ninguno reportado en esta versión

## 🙏 Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue primero para discutir cambios mayores.

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver [LICENSE](https://github.com/amillanaol/WhisperTranslator/blob/main/LICENSE) para más detalles.

## 👨‍💻 Autor

**amillanaol** - [GitHub](https://github.com/amillanaol)

---

**Fecha de lanzamiento:** 24 de febrero de 2025  
**Commit:** 95d6624
```

#### D. ¿Es Pre-release?
- ❌ NO marcar como pre-release (es versión estable)

#### E. ¿Crear discusión?
- ⚪ Opcional - puedes habilitar si quieres feedback de la comunidad

### Paso 5: Publicar
1. Haz clic en **"Publish release"** (Publicar versión)
2. ¡Listo! Tu primer release está creado 🎉

---

## 🖥️ Método 2: Crear Release desde la Terminal (Alternativo)

Si tienes GitHub CLI instalado:

```powershell
# Instalar GitHub CLI (si no lo tienes)
winget install GitHub.cli

# Autenticarse
gh auth login

# Crear el release
gh release create v1.0.0 `
  --title "WhisperTranslator v1.0.0 - Módulo PowerShell" `
  --notes-file docs/releases/release-notes-v1.0.0.md
```

---

## 📝 Notas de Release Pre-escritas

He preparado notas para las versiones más importantes:

### 📄 v1.0.0 - Primera versión estable
Ver contenido completo arriba ↑

### 📄 v1.1.0 - Agregada desinstalación
```markdown
# WhisperTranslator v1.1.0

## ✨ Nuevas Características

- ✅ Script de desinstalación automática
- ✅ Documentación de desinstalación
- ✅ Mejoras en el proceso de instalación

## 🔧 Mejoras

- Mejor manejo de errores durante instalación
- Documentación más clara

## 📚 Documentación

- Agregada guía de desinstalación completa
- Ejemplos de uso actualizados
```

### 📄 v1.1.1 - Fix crítico GUID
```markdown
# WhisperTranslator v1.1.1

## 🐛 Correcciones

- 🔴 **CRÍTICO:** Corregido GUID inválido en el manifiesto del módulo
  - El módulo ahora se puede importar correctamente
  - Solucionado error: "Invalid module manifest"

## 📋 Detalles Técnicos

- GUID del módulo actualizado a formato válido
- Validación del archivo .psd1 completada

Este es un fix crítico que todos los usuarios deben actualizar.
```

---

## 🎨 Personalización del Release

### Agregar Assets (Archivos descargables)

Puedes adjuntar archivos ZIP del módulo:

1. **Crear ZIP del módulo:**
```powershell
# Comprimir la carpeta module
Compress-Archive -Path .\module\* -DestinationPath WhisperTranslator-v1.0.0.zip
```

2. **Subir a GitHub:**
   - En la página de creación del release
   - Arrastra el archivo ZIP a la sección "Attach binaries"
   - O haz clic en "Attach binaries by dropping them here or selecting them"

### Agregar Badges al README

Después de crear el release, puedes agregar badges:

```markdown
[![GitHub release](https://img.shields.io/github/v/release/amillanaol/WhisperTranslator)](https://github.com/amillanaol/WhisperTranslator/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://github.com/PowerShell/PowerShell)
```

---

## ✅ Checklist de Release

Antes de publicar, verifica:

- [ ] Tag existe en Git (`git tag -l`)
- [ ] Tag está en GitHub (`git push origin v1.0.0`)
- [ ] Título del release es descriptivo
- [ ] Descripción incluye características principales
- [ ] Descripción incluye instrucciones de instalación
- [ ] Descripción incluye ejemplos de uso
- [ ] No está marcado como pre-release (a menos que lo sea)
- [ ] Archivos adjuntos subidos (si aplica)
- [ ] Documentación referenciada está actualizada

---

## 🎯 Después de Crear el Release

### 1. Verificar el Release
- Ve a: `https://github.com/amillanaol/WhisperTranslator/releases`
- Verifica que aparece correctamente

### 2. Actualizar README
Agrega un badge de la última versión:
```markdown
## 📦 Instalación

**Última versión:** [v1.0.0](https://github.com/amillanaol/WhisperTranslator/releases/tag/v1.0.0)
```

### 3. Compartir el Release
- Twitter/X
- LinkedIn
- Reddit (r/PowerShell)
- Blog personal

### 4. Crear Issues de Feedback (Opcional)
Crea un issue pidiendo feedback sobre el release.

---

## 🚀 Releases Futuros

### v1.2.0 - Fix Alias wtranslator (Próximo)
Después de hacer el commit del fix del alias:

```markdown
# WhisperTranslator v1.2.0

## 🐛 Correcciones

- ✅ Alias `wtranslator` ahora se exporta correctamente
  - El alias no se reconocía aunque estaba declarado en el manifiesto
  - Agregado `New-Alias` y actualizado `Export-ModuleMember`

## 📚 Documentación

- Agregada documentación completa del problema del alias
- Nuevas guías en `docs/troubleshooting/alias-no-reconocido/`

## 🔧 Cambios Técnicos

- Modificado `WhisperTranslator.psm1` para crear y exportar el alias
- Documentación de mejores prácticas para aliases en módulos
```

---

## 💡 Mejores Prácticas para Releases

1. **Usa Semantic Versioning:** MAJOR.MINOR.PATCH
2. **Escribe notas claras:** Que cualquiera pueda entender
3. **Incluye ejemplos:** De instalación y uso
4. **Lista breaking changes:** Si los hay, hazlos evidentes
5. **Agrega enlaces:** A documentación y recursos
6. **Usa emojis:** Con moderación para hacer más legible
7. **Mantén consistencia:** Formato similar en todos los releases
8. **Pre-release para betas:** Marca versiones experimentales
9. **Assets útiles:** ZIP del módulo, instaladores, etc.
10. **Fecha de release:** Incluye cuando fue lanzado

---

## 📞 Ayuda Adicional

Si necesitas ayuda con algún paso:
1. Revisa la documentación de GitHub: https://docs.github.com/en/repositories/releasing-projects-on-github
2. Consulta ejemplos de otros proyectos PowerShell
3. Pregunta en la comunidad de PowerShell

---

**¡Listo para crear tu primer release!** 🎉

Sigue los pasos del Método 1 (desde GitHub) - es el más simple y visual.
