# Plan de Etiquetado de Versiones - WhisperTranslator

**Fecha:** 23 de noviembre de 2025  
**Repositorio:** WhisperTranslator  
**Etiquetas existentes:** v0.1.0, v1.0.0

## 📋 Estado Actual

Actualmente el proyecto tiene 2 etiquetas:
- `v0.1.0` → Commit `439cbdd`
- `v1.0.0` → Commit `807d6f2`

Hay **14 commits** en total, de los cuales **12 no tienen etiqueta asignada**.

---

## 🏷️ Propuesta de Etiquetado

### Criterios de Versionado (Semantic Versioning)

- **MAJOR (X.0.0)**: Cambios que rompen compatibilidad o refactorizaciones mayores
- **MINOR (0.X.0)**: Nueva funcionalidad compatible con versiones anteriores
- **PATCH (0.0.X)**: Correcciones de bugs y mejoras menores

---

## 📊 Tabla de Commits y Versiones Propuestas

| Versión Propuesta | Hash Corto | Tipo | Descripción Breve | Notas |
|-------------------|------------|------|-------------------|-------|
| v0.0.1 | `cc1200d` | chore | Clonación inicial del repositorio | Primer commit, setup inicial |
| v0.0.2 | `a3bd40e` | feat | Commit inicial con estructura base | Estructura inicial del proyecto |
| v0.0.3 | `911077a` | docs | Cambios en README | Mejoras en documentación |
| v0.1.0 | `1266969` | refactor | Refactorización de estructura | **YA ETIQUETADO** - Cambio arquitectónico |
| v0.1.1 | `b896aba` | docs | Actualización de README | Mejoras documentales post-refactor |
| v0.1.2 | `12f42be` | chore | Ajustes de configuración | Cambios de construcción/config |
| v0.1.3 | `ab6df2a` | docs | Agregada licencia MIT | Documentación legal añadida |
| v1.0.0 | `95d6624` | feat | Conversión a módulo PowerShell | **YA ETIQUETADO** - Cambio mayor en arquitectura |
| v1.0.1 | `88c31a5` | docs | Reescritura completa del README | Nueva estructura y contenido |
| v1.1.0 | `14af2d7` | feat | Agregada documentación de desinstalación | Nueva funcionalidad: script uninstall |
| v1.1.1 | `5bdb894` | fix | Corrección de GUID inválido en manifiesto | Bug fix crítico del módulo |
| v1.1.2 | `c590387` | docs | Actualización guía de instalación | Mejoras en docs de instalación |
| v1.1.3 | `f8a4607` | docs | Actualización guía de uso con nuevo alias | Docs reflejando cambios de alias |
| v1.1.4 | `5ea9cd9` | docs | Actualización README con nuevos ejemplos | Ejemplos de uso mejorados |

---

## 🎯 Versiones Destacadas y Justificación

### v0.0.1 - v0.0.3 (Pre-lanzamiento)
- Commits iniciales de setup y configuración
- No representan funcionalidad estable
- Se pueden agrupar o saltar si se prefiere empezar desde v0.1.0

### v0.1.0 → Primera versión funcional
- **Commit:** `1266969` - "refactor: :building_construction:"
- Refactorización importante que marca la primera versión usable
- **Acción:** Ya está etiquetada correctamente

### v1.0.0 → Lanzamiento mayor
- **Commit:** `95d6624` - "feat(module): refactor WhisperTranslator to PowerShell module"
- Cambio arquitectónico a módulo de PowerShell
- Rompe compatibilidad con versión de script standalone
- **Acción:** Ya está etiquetada correctamente

### v1.1.0 → Nueva funcionalidad
- **Commit:** `14af2d7` - "feat(docs): add uninstallation documentation and script"
- Agrega script de desinstalación
- Nueva característica sin romper compatibilidad

### v1.1.1 → Bug fix crítico
- **Commit:** `5bdb894` - "fix(module): correct invalid GUID in module manifest"
- Corrección de error que impedía importar el módulo
- Fix importante que justifica version patch

---

## 📝 Notas Adicionales por Commit

### Commit Reciente Sin Etiquetar (HEAD)
Si hay commits más recientes que `5ea9cd9`, estos serían candidatos para:
- **v1.1.5** (si son docs/chore)
- **v1.2.0** (si agregan nueva funcionalidad)
- **v2.0.0** (si rompen compatibilidad)

### Commits Opcionales de Pre-lanzamiento
Los primeros 3 commits (v0.0.1 - v0.0.3) pueden:
1. **Opción A:** Etiquetarse para historial completo
2. **Opción B:** Omitirse y comenzar desde v0.1.0
3. **Opción C:** Agruparse en una sola v0.0.1

**Recomendación:** Opción B - comenzar desde v0.1.0

---

## 🚀 Plan de Acción

### Fase 1: Etiquetar commits faltantes (Recomendado)

```bash
# Navegar al repositorio
cd $env:USERPROFILE\src\WhisperTranslator

# Etiquetas de documentación post v1.0.0
git tag -a v1.0.1 88c31a5 -m "docs: rewrite README with new structure and content"
git tag -a v1.1.0 14af2d7 -m "feat: add uninstallation documentation and script"
git tag -a v1.1.1 5bdb894 -m "fix: correct invalid GUID in module manifest"
git tag -a v1.1.2 c590387 -m "docs: update installation documentation and script"
git tag -a v1.1.3 f8a4607 -m "docs: update usage guide to reflect new alias"
git tag -a v1.1.4 5ea9cd9 -m "docs: update README with new version and usage examples"

# Opcional: Etiquetas pre-v0.1.0
git tag -a v0.0.1 cc1200d -m "chore: initial repository clone"
git tag -a v0.0.2 a3bd40e -m "feat: initial project structure"
git tag -a v0.0.3 911077a -m "docs: README improvements"
git tag -a v0.1.1 b896aba -m "docs: README update post-refactor"
git tag -a v0.1.2 12f42be -m "chore: configuration adjustments"
git tag -a v0.1.3 ab6df2a -m "docs: add MIT license"

# Subir todas las etiquetas al repositorio remoto
git push origin --tags
```

### Fase 2: Verificar etiquetas

```bash
# Listar todas las etiquetas en orden
git tag -l | sort -V

# Ver detalles de una etiqueta específica
git show v1.1.0

# Ver log con etiquetas
git log --oneline --decorate --all
```

### Fase 3: Crear release notes (Opcional)

Para cada versión mayor/menor, crear notas de release en GitHub:
- Describir cambios principales
- Listar breaking changes (si aplica)
- Incluir instrucciones de migración

---

## 📦 Siguiente Versión Recomendada

Después de etiquetar el historial, la siguiente versión debería ser:

**v1.2.0** - Para incluir la corrección del alias `wtranslator`
- **Tipo:** MINOR (nueva funcionalidad: alias exportado correctamente)
- **Cambios:**
  - Fix: Alias `wtranslator` ahora se exporta correctamente
  - Docs: Documentación completa del problema en `docs/troubleshooting/`
  
```bash
# Después de hacer commit de los cambios del alias
git tag -a v1.2.0 -m "feat: export wtranslator alias correctly"
git push origin v1.2.0
```

---

## 🔍 Validación Final

Después de aplicar todas las etiquetas:

```bash
# Debe mostrar todas las versiones en orden
git tag -l | sort -V

# Verificar que cada etiqueta apunta al commit correcto
git tag -l | xargs -I {} sh -c 'echo "=== {} ===" && git show --quiet {}'
```

---

## 📚 Referencias

- [Semantic Versioning 2.0.0](https://semver.org/)
- [Git Tagging Documentation](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
- [Conventional Commits](https://www.conventionalcommits.org/)
