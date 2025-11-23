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

### Ver el plan completo
```powershell
# Abrir plan detallado
notepad .\docs\versionado\plan-etiquetado-versiones.md

# O ver resumen visual
notepad .\docs\versionado\resumen-visual-versiones.md
```

### Aplicar etiquetas automáticamente

#### Opción 1: Solo versiones esenciales (Recomendado)
```powershell
cd $env:USERPROFILE\src\WhisperTranslator
.\docs\versionado\Apply-VersionTags.ps1 -Strategy Essential
```

#### Opción 2: Todas las versiones (historial completo)
```powershell
.\docs\versionado\Apply-VersionTags.ps1 -Strategy Full
```

#### Opción 3: Modo prueba (ver qué se haría sin ejecutar)
```powershell
.\docs\versionado\Apply-VersionTags.ps1 -Strategy Essential -DryRun
```

#### Opción 4: Aplicar y subir al remoto
```powershell
.\docs\versionado\Apply-VersionTags.ps1 -Strategy Essential -Push
```

### Aplicar etiquetas manualmente

Si prefieres hacerlo manualmente, consulta los comandos en `resumen-visual-versiones.md`.

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

## 🎯 Estrategias de Etiquetado

### Estrategia "Essential" (Recomendada)
**Qué incluye:**
- Versiones v1.0.0 en adelante
- Solo cambios funcionales y fixes importantes

**Ventajas:**
- Historial limpio y enfocado
- Solo versiones productivas
- Fácil de mantener

**Cuándo usar:**
- Proyectos en producción
- Cuando el foco es en versiones estables

### Estrategia "Full"
**Qué incluye:**
- Todas las versiones desde v0.0.1
- Incluyendo pre-releases experimentales

**Ventajas:**
- Historial completo
- Trazabilidad total del proyecto

**Cuándo usar:**
- Proyectos que requieren auditoría completa
- Documentación exhaustiva de evolución

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

## 💡 Tips

1. **Siempre usa `-DryRun` primero** para verificar qué se va a hacer
2. **Revisa el resumen visual** antes de aplicar cambios
3. **Etiqueta progresivamente** si tienes dudas (primero esenciales, luego completas)
4. **Documenta los cambios** en cada versión mayor/menor
5. **Sube las etiquetas al remoto** después de verificar localmente

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

**Última actualización:** 23 de noviembre de 2025  
**Mantenido por:** amillanaol
