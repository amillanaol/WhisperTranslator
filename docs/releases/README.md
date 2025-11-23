# 🚀 Documentación de Releases - WhisperTranslator

Esta carpeta contiene toda la documentación relacionada con la creación y gestión de releases del proyecto.

---

## 📁 Contenido

| Archivo | Descripción | Uso |
|---------|-------------|-----|
| `guia-primer-release.md` | Guía completa paso a paso | Primera vez creando release |
| `checklist-crear-release.md` | Lista de verificación rápida | Cada vez que crees un release |
| `release-notes-v1.0.0.md` | Notas del release v1.0.0 | Copiar/pegar en GitHub |
| `release-notes-v1.1.4.md` | Notas del release v1.1.4 | Copiar/pegar en GitHub |
| `release-notes-v1.1.5.md` | Notas del release v1.1.5 | Copiar/pegar en GitHub |

---

## 🎯 Inicio Rápido

### Para tu PRIMER release:

1. **Lee la guía completa:**
   ```powershell
   notepad docs\releases\guia-primer-release.md
   ```

2. **Sigue el checklist:**
   ```powershell
   notepad docs\releases\checklist-crear-release.md
   ```

3. **Usa las notas pre-escritas:**
   ```powershell
   notepad docs\releases\release-notes-v1.0.0.md
   ```

---

## 📋 Proceso Resumido

### 1. Preparación
```powershell
# Verificar etiquetas
git tag -l

# Subir etiquetas si no están en GitHub
git push origin --tags
```

### 2. Crear en GitHub
1. Ir a: https://github.com/milepmastering-labs/WhisperTranslator/releases
2. Click en "Draft a new release"
3. Seleccionar tag: **v1.0.0**
4. Título: `WhisperTranslator v1.0.0 - Módulo PowerShell`
5. Descripción: Copiar de `release-notes-v1.0.0.md`
6. Click en "Publish release"

### 3. Verificar
- Release visible en GitHub
- Assets descargables (si los agregaste)
- Links funcionan correctamente

---

## 🎯 Releases Recomendados

### Para comenzar (Elige UNO):

#### Opción A: v1.0.0 (Recomendada)
**Por qué:** Primera versión estable del módulo
- ✅ Hito importante del proyecto
- ✅ Base sólida para futuros releases
- ✅ Notas completas pre-escritas
- 📄 Usar: `release-notes-v1.0.0.md`

#### Opción B: v1.1.5 (Versión actual)
**Por qué:** Última versión con todas las mejoras
- ✅ Incluye todas las correcciones desde v1.0.0
- ✅ Documentación más completa y estandarizada
- ⚠️ Nota sobre alias wtranslator pendiente
- 📄 Usar: `release-notes-v1.1.5.md`

### Mi recomendación: 
**Crear AMBOS** - Empieza con v1.0.0, luego crea v1.1.4

---

## 📊 Comparación de Versiones

| Característica | v1.0.0 | v1.1.5 |
|----------------|--------|--------|
| Módulo PowerShell | ✅ | ✅ |
| Scripts instalación | ✅ | ✅ |
| Script desinstalación | ❌ | ✅ |
| GUID corregido | ❌ | ✅ |
| Docs completas | ⚪ Básicas | ✅ Completas y estandarizadas |
| Alias wtranslator | ❌ | ⚠️ Declarado pero no funciona |
| Estado | Primera versión estable | Versión actual mejorada |

---

## 🔄 Workflow de Releases

```
1. Desarrollo
   ↓
2. Commit de cambios
   ↓
3. Crear tag (git tag -a vX.X.X)
   ↓
4. Push tag (git push origin vX.X.X)
   ↓
5. Crear release notes
   ↓
6. Publicar en GitHub
   ↓
7. Verificar y compartir
```

---

## 📝 Plantilla para Futuros Releases

Cuando crees nuevos releases, usa esta estructura:

```markdown
# WhisperTranslator vX.X.X

Breve descripción del release.

## ✨ Nuevas Características

- ✅ Feature 1
- ✅ Feature 2

## 🐛 Correcciones

- ✅ Bug fix 1
- ✅ Bug fix 2

## 📚 Documentación

- Enlaces a docs relevantes

## 📦 Instalación

```powershell
# Comandos de instalación
```

## 🔜 Próximos Pasos

- Características futuras

---

**Versión:** X.X.X  
**Commit:** xxxxxxx  
**Fecha:** DD de MMM de YYYY
```

---

## 🎨 Mejores Prácticas

### ✅ HACER:
- Usar Semantic Versioning (MAJOR.MINOR.PATCH)
- Escribir notas claras y concisas
- Incluir ejemplos de instalación y uso
- Listar breaking changes claramente
- Agregar enlaces a documentación
- Usar emojis con moderación
- Mantener formato consistente
- Fechar el release

### ❌ NO HACER:
- Releases sin descripción
- Cambiar formato entre releases
- Omitir breaking changes
- Releases sin tag correspondiente
- Información incorrecta o desactualizada

---

## 🔜 Próximos Releases Planeados

### v1.2.0 - Fix Alias wtranslator
**Fecha estimada:** Después de aplicar el fix actual

**Cambios principales:**
- ✅ Alias `wtranslator` exportado correctamente
- ✅ Documentación completa del problema
- ✅ Guías en `docs/troubleshooting/`

**Notas:** Crear archivo `release-notes-v1.2.0.md` después del commit

---

## 📚 Recursos Adicionales

### Documentación Oficial
- [GitHub Releases Docs](https://docs.github.com/en/repositories/releasing-projects-on-github)
- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)

### Ejemplos de Buenos Releases
- [PowerShell Release](https://github.com/PowerShell/PowerShell/releases)
- [Pester Releases](https://github.com/pester/Pester/releases)
- [PSScriptAnalyzer Releases](https://github.com/PowerShell/PSScriptAnalyzer/releases)

### Herramientas
- [GitHub CLI](https://cli.github.com/) - Crear releases desde terminal
- [Conventional Commits](https://www.conventionalcommits.org/) - Formato de commits
- [Release Drafter](https://github.com/release-drafter/release-drafter) - Automatización

---

## ✅ Checklist de Calidad

Antes de publicar cualquier release, verifica:

- [ ] Tag existe y está pusheado
- [ ] Título descriptivo y consistente
- [ ] Descripción completa con:
  - [ ] Resumen de cambios
  - [ ] Instrucciones de instalación
  - [ ] Ejemplos de uso
  - [ ] Breaking changes (si aplica)
  - [ ] Enlaces a documentación
- [ ] Marcado correctamente (release vs pre-release)
- [ ] Assets útiles adjuntos (si aplica)
- [ ] Fecha incluida
- [ ] Commit hash referenciado
- [ ] Sin typos o errores

---

## 🆘 Soporte

Si necesitas ayuda con los releases:

1. **Consulta la documentación:**
   - `guia-primer-release.md` - Guía detallada
   - `checklist-crear-release.md` - Pasos rápidos

2. **Revisa ejemplos:**
   - `release-notes-v1.0.0.md`
   - `release-notes-v1.1.4.md`

3. **Recursos externos:**
   - GitHub Docs
   - Comunidad PowerShell

---

## 📊 Estadísticas

- **Releases creados:** 0 (pendiente)
- **Primer release:** v1.0.0 (recomendado)
- **Versión actual:** v1.1.5
- **Próximo release:** v1.2.0 (después del fix del alias)

---

**Última actualización:** 23 de noviembre de 2025  
**Estado:** Listo para crear primer release  
**Acción siguiente:** Seguir `checklist-crear-release.md`
