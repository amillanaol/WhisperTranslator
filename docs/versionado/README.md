# 🏷️ Documentación de Versionado - WhisperTranslator

Esta carpeta contiene la documentación y herramientas relacionadas con el versionado del proyecto WhisperTranslator.

## 📁 Contenido

| Archivo | Descripción |
|---------|-------------|
| `plan-etiquetado-versiones.md` | Plan detallado de etiquetado con análisis completo de commits |
| `resumen-visual-versiones.md` | Tabla visual resumida de versiones y estados |
| `Apply-VersionTags.ps1` | Script automatizado para aplicar etiquetas |

---

## 🚀 Guía Rápida

### Ejecutar el script interactivo

El script ahora detecta automáticamente commits sin etiquetar y ofrece un menú interactivo para procesarlos:

```powershell
# Opción 1: Modo interactivo (Recomendado)
.\docs\versionado\Apply-VersionTags.ps1
```

```powershell
# Opción 2: Modo prueba (ver qué se haría sin ejecutar)
.\docs\versionado\Apply-VersionTags.ps1 -DryRun
```

```powershell
# Opción 3: Aplicar etiquetas y subir al remoto
.\docs\versionado\Apply-VersionTags.ps1 -Push
```

```powershell
# Opción 4: Combinar modo prueba con push
.\docs\versionado\Apply-VersionTags.ps1 -DryRun -Push
```

### Flujo de Trabajo Interactivo

El script te guiará a través de estos pasos:

1. **Detección automática** - Identifica commits posteriores a la última etiqueta
2. **Menú principal** - Elige entre:
   - Ver lista completa de commits
   - Procesar commits individualmente
   - Ver preview de etiquetas pendientes
   - Aplicar etiquetas
   - Salir sin cambios

3. **Procesamiento por commit** - Para cada commit:
   - Ver detalles completos (hash, autor, fecha)
   - Asignar tipo de versión (major/minor/patch)
   - Opcionalmente, asignar mensaje personalizado
   - Marcar como procesado

4. **Preview y aplicación** - Antes de aplicar:
   - Revisa todas las etiquetas que se crearán
   - Confirma la acción
   - Las etiquetas se aplican automáticamente

### Ver el plan original

```powershell
# Plan detallado de análisis
notepad .\docs\versionado\plan-etiquetado-versiones.md

# Resumen visual de versiones
notepad .\docs\versionado\resumen-visual-versiones.md
```

---

## 📊 Estado Actual del Versionado

### Etiquetas Existentes
- ✅ `v0.1.0` - Primera refactorización
- ✅ `v1.0.0` - Conversión a módulo PowerShell

### Etiquetas Faltantes

#### Alta Prioridad (Esenciales)
- 🔴 `v1.0.1` - Rewrite README
- 🔴 `v1.1.0` - Feature: Desinstalación
- 🔴 `v1.1.1` - Fix: GUID inválido
- 🔴 `v1.1.2` - Docs: Instalación
- 🔴 `v1.1.3` - Docs: Guía de uso
- 🔴 `v1.1.4` - Docs: Ejemplos README

#### Media Prioridad (Pre-módulo)
- 🔶 `v0.1.1` - v0.1.3 (Docs y config)

#### Baja Prioridad (Pre-release)
- 🔶 `v0.0.1` - v0.0.3 (Setup inicial)

---

## 🎯 Tipos de Versión (Semantic Versioning)

El script permite asignar uno de tres tipos a cada commit:

### MAJOR - Cambio principal
- **Ejemplo:** v1.0.0 → v2.0.0
- **Cuándo usar:** Cambios que rompen compatibilidad, refactorizaciones mayores
- **En el proyecto:** Conversión de script a módulo PowerShell (v1.0.0)

### MINOR - Nueva funcionalidad
- **Ejemplo:** v1.1.0 → v1.2.0
- **Cuándo usar:** Nueva funcionalidad compatible con versiones anteriores
- **En el proyecto:** Agregado de script de desinstalación (v1.1.0)

### PATCH - Corrección
- **Ejemplo:** v1.1.1 → v1.1.2
- **Cuándo usar:** Bug fixes y mejoras menores
- **En el proyecto:** Corrección de GUID inválido (v1.1.1)

---

## 📝 Semantic Versioning

El proyecto sigue [Semantic Versioning 2.0.0](https://semver.org/):

```
MAJOR.MINOR.PATCH

v1.2.3
│ │ └─── PATCH: Bug fixes, correcciones menores
│ └───── MINOR: Nueva funcionalidad (backward compatible)
└─────── MAJOR: Cambios que rompen compatibilidad
```

### Ejemplos del proyecto

| Versión | Tipo | Razón |
|---------|------|-------|
| v0.1.0 → v1.0.0 | MAJOR | Cambio de script a módulo PowerShell |
| v1.0.0 → v1.1.0 | MINOR | Agregado script de desinstalación |
| v1.1.0 → v1.1.1 | PATCH | Fix de GUID inválido |
| v1.1.1 → v1.1.2 | PATCH | Update de documentación |

---

## 🔍 Verificación Post-Etiquetado

Después de aplicar las etiquetas, verifica:

### 1. Listar todas las etiquetas
```powershell
git tag -l | Sort-Object
```

### 2. Ver log con decoraciones
```powershell
git log --oneline --decorate --all --graph
```

### 3. Verificar etiqueta específica
```powershell
git show v1.1.0
```

### 4. Comprobar etiquetas en remoto
```powershell
git ls-remote --tags origin
```

---

## 🔄 Siguiente Versión

Después de corregir el problema del alias `wtranslator`:

```powershell
# Hacer commit de los cambios
git add .
git commit -m "feat(module): export wtranslator alias correctly"

# Crear etiqueta para la nueva versión
git tag -a v1.2.0 -m "feat: export wtranslator alias correctly"

# Subir cambios y etiqueta
git push origin main
git push origin v1.2.0
```

---

## 📚 Referencias

- [Plan Detallado](./plan-etiquetado-versiones.md) - Análisis completo
- [Resumen Visual](./resumen-visual-versiones.md) - Tabla rápida de referencia
- [Script de Aplicación](./Apply-VersionTags.ps1) - Herramienta de automatización
- [Semantic Versioning](https://semver.org/) - Especificación oficial
- [Git Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging) - Documentación Git
- [Conventional Commits](https://www.conventionalcommits.org/) - Estándar de mensajes

---

## 💡 Tips y Mejores Prácticas

1. **Comienza con `-DryRun`** para familiarizarte con el script sin hacer cambios
2. **Revisa la lista completa** de commits antes de asignar versiones
3. **Usa el preview** (opción 3 del menú) para validar todas las etiquetas
4. **Procesa en sesión única** para evitar inconsistencias
5. **Usa `-Push` solo cuando estés seguro** de los cambios
6. **Documenta las release notes** en GitHub para versiones importantes
7. **Ten en cuenta el contexto** del commit (no solo el tipo de cambio)

---

## 🐛 Solución de Problemas

### Error: "tag already exists"
La etiqueta ya existe. Usa:
```powershell
git tag -d nombre-etiqueta  # Eliminar local
git push origin :refs/tags/nombre-etiqueta  # Eliminar remoto
```

### Error: "fatal: Failed to resolve 'HEAD' as a valid ref"
No hay commits. Verifica:
```powershell
git log --oneline
```

### Las etiquetas no aparecen en GitHub
Subir etiquetas manualmente:
```powershell
git push origin --tags
```

---

**Última actualización:** 31 de enero de 2026
**Mantenido por:** amillanaol
