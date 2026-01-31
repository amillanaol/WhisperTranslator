# Instrucciones de Ejecución - Apply-VersionTags.ps1 (Interactivo)
# Versión: 2.0 (Interactiva)
# Fecha: 2026-01-31

## 📋 Descripción General

El script `Apply-VersionTags.ps1` es un **gestor interactivo de etiquetas de versión** que:
- Detecta automáticamente commits sin etiquetar
- Presenta un menú interactivo para procesarlos
- Calcula versiones automáticamente usando semantic versioning
- Permite asignar tipos de versión (major/minor/patch) a cada commit
- Muestra un preview antes de aplicar etiquetas

---

## ⚙️ Requisitos Previos

1. **Git instalado** en el sistema
2. **PowerShell 5.0+** (Windows 7 o superior, o PowerShell Core)
3. **Permisos de ejecución** de scripts en PowerShell
4. **Estar en el directorio raíz del repositorio** o usar rutas absolutas

### Verificar PowerShell
```powershell
$PSVersionTable.PSVersion
# Debe mostrar versión 5.0 o superior
```

### Habilitar ejecución de scripts
Si obtienes un error de ejecución, ejecuta:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 🚀 Ejecución Básica

### Opción 1: Modo Interactivo (Recomendado)

Inicia el script sin parámetros para el menú interactivo completo:

```powershell
# Navegador al repositorio
cd $env:USERPROFILE\src\WhisperTranslator

# Ejecutar el script
.\docs\versionado\Apply-VersionTags.ps1
```

**Qué sucede:**
1. Script detecta commits sin etiquetar
2. Muestra menú principal con 5 opciones
3. Puedes procesar commits uno por uno
4. Visualiza preview antes de aplicar
5. Aplica etiquetas cuando estés listo

---

### Opción 2: Modo Prueba (DryRun)

Ver exactamente qué se haría **sin ejecutar cambios**:

```powershell
.\docs\versionado\Apply-VersionTags.ps1 -DryRun
```

**Útil para:**
- Familiarizarse con el script
- Verificar que los comandos son correctos
- Revisar antes de cambios reales

---

### Opción 3: Modo Push

Aplicar etiquetas y subirlas al remoto en una sola ejecución:

```powershell
.\docs\versionado\Apply-VersionTags.ps1 -Push
```

⚠️ **Nota:** Requiere credenciales configuradas en Git

---

### Opción 4: Combinación DryRun + Push

Ver qué se subiría al remoto:

```powershell
.\docs\versionado\Apply-VersionTags.ps1 -DryRun -Push
```

---

## 📋 Menú Principal - Opciones

Una vez ejecutado, verás:

```
═════════════════════════════════════════════════
  GESTOR DE ETIQUETAS DE VERSIÓN
═════════════════════════════════════════════════

Commits sin etiquetar: X
Commits procesados: Y

1. Ver lista de commits
2. Procesar commits individualmente
3. Ver preview de tags pendientes
4. Aplicar tags
5. Salir sin aplicar
═════════════════════════════════════════════════
```

### Opción 1: Ver lista de commits
- Muestra todos los commits sin etiquetar
- Indica si ya tienen tipo de versión asignado
- Muestra la versión siguiente calculada

### Opción 2: Procesar commits individualmente
- Abre submenu para cada commit
- Permite asignar tipo (major/minor/patch)
- Opción de mensaje personalizado
- Marca como procesado cuando termines

### Opción 3: Ver preview de tags
- Tabla con todas las etiquetas a crear
- Muestra versión final calculada
- Confirma hash y mensajes

### Opción 4: Aplicar tags
- Pide confirmación antes de aplicar
- En modo DryRun: muestra comandos
- En modo normal: crea etiquetas
- Opcionalmente sube al remoto con `-Push`

### Opción 5: Salir
- Cancela sin aplicar cambios
- Requiere confirmación

---

## 📝 Submenu de Procesar Commit

Para cada commit, tienes estas opciones:

```
─────────────────────────────────────────
PROCESANDO COMMIT [1/5]
─────────────────────────────────────────
Commit: abc1234 - mensaje del commit

1. Ver detalles completos
2. Asignar tipo: MAJOR (versión principal)
3. Asignar tipo: MINOR (nueva funcionalidad)
4. Asignar tipo: PATCH (corrección)
5. Asignar mensaje personalizado
6. Marcar como procesado
7. Volver al menú principal
8. Salir sin aplicar
```

### Asignar Tipo de Versión

**MAJOR** - v1.0.0 → v2.0.0
- Cambios que rompen compatibilidad
- Refactorizaciones mayores
- Uso raro en este proyecto

**MINOR** - v1.1.0 → v1.2.0
- Nueva funcionalidad
- Compatible con versiones anteriores
- Ejemplo: agregar nuevo script

**PATCH** - v1.1.1 → v1.1.2
- Bug fixes
- Mejoras documentales
- Cambios menores

### Mensaje Personalizado

Por defecto usa el mensaje del commit. Puedes reemplazarlo:

```
Mensaje actual: docs: update README
Ingrese mensaje personalizado (o Enter para mantener): Fix typo in README
```

---

## 🔄 Flujo de Trabajo Recomendado

### Paso 1: Inspección
```powershell
# Ver qué commits hay pendientes
.\docs\versionado\Apply-VersionTags.ps1
# Opción 1: Ver lista de commits
```

### Paso 2: Prueba Seca
```powershell
# Ejecutar con DryRun para verificar
.\docs\versionado\Apply-VersionTags.ps1 -DryRun
# Opción 4: Aplicar tags (simula sin cambios)
```

### Paso 3: Procesamiento
```powershell
# Ejecutar sin parámetros
.\docs\versionado\Apply-VersionTags.ps1
# Opción 2: Procesar commits individualmente
# Asigna tipo a cada commit

# Opción 3: Ver preview
# Verifica que todo es correcto

# Opción 4: Aplicar tags
# Confirma y crea etiquetas
```

### Paso 4: Subir al Remoto
```powershell
# Opción a: Automático con -Push
.\docs\versionado\Apply-VersionTags.ps1 -Push

# Opción b: Manual después de crear etiquetas
git push origin --tags
```

### Paso 5: Verificación
```powershell
# Listar todas las etiquetas locales
git tag -l | Sort-Object

# Ver log con decoraciones
git log --oneline --decorate --all --graph

# Verificar en remoto
git ls-remote --tags origin
```

---

## ✅ Validación Post-Ejecución

### 1. Verificar etiquetas locales
```powershell
git tag -l | Sort-Object
```
Debe mostrar la etiqueta nueva en orden.

### 2. Verificar etiqueta específica
```powershell
git show v1.1.0
```
Muestra detalles de la etiqueta.

### 3. Ver log con etiquetas
```powershell
git log --oneline --decorate --graph --all
```
Visualiza el historial con etiquetas.

### 4. Verificar en GitHub (si fue con -Push)
- Ir a https://github.com/amillanaol/WhisperTranslator/releases
- Las etiquetas deben aparecer en la lista

---

## 🚨 Solución de Problemas

### Error: "Execution of scripts is disabled"
**Solución:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Error: "La etiqueta ya existe"
**Causa:** La etiqueta ya fue creada.
**Solución:** El script la omite automáticamente y continúa.

### Error: "fatal: not a git repository"
**Causa:** No estás en el directorio correcto.
**Solución:**
```powershell
cd $env:USERPROFILE\src\WhisperTranslator
```

### Error al hacer push (con -Push)
**Causa:** Problema de autenticación o conexión.
**Solución:**
```powershell
# Verificar configuración de Git
git config --global user.name
git config --global user.email

# Hacer push manual de etiquetas
git push origin --tags
```

### El script no detecta commits
**Causa Posible:** Todos los commits ya tienen etiqueta.
**Verificación:**
```powershell
# Ver commits sin etiqueta
git log --oneline --not --tags

# Si no devuelve nada, todos tienen etiqueta
```

---

## 📊 Ejemplos de Ejecución

### Ejemplo 1: Procesamiento Completo

```powershell
# 1. Iniciar script
.\docs\versionado\Apply-VersionTags.ps1

# Output:
# Se encontraron 5 commits sin etiquetar
# Última etiqueta: v1.1.4

# 2. Seleccionar opción 2 para procesar

# 3. Para cada commit:
#    - Ver detalles (opción 1)
#    - Asignar tipo (opción 2/3/4)
#    - Marcar procesado (opción 6)

# 4. Seleccionar opción 3 para preview

# 5. Seleccionar opción 4 para aplicar
#    ¿Desea aplicar las etiquetas? (s/n): s

# Output:
# ════════════════════════════════════════
# APLICANDO ETIQUETAS
# ════════════════════════════════════════
# Etiqueta: v1.1.5 | Commit: abc1234
#   ✓ Etiqueta creada exitosamente
```

### Ejemplo 2: Modo DryRun

```powershell
# Ver exactamente qué se haría
.\docs\versionado\Apply-VersionTags.ps1 -DryRun

# Output:
# [MODO PRUEBA ACTIVADO]
# Los comandos git se mostrarán pero NO se ejecutarán

# Luego procesa y aplica normalmente
# Verás los comandos sin ejecutarlos
```

### Ejemplo 3: Con Push

```powershell
# Aplicar y subir en una sola ejecución
.\docs\versionado\Apply-VersionTags.ps1 -Push

# Después de procesar y aplicar:
# Subiendo etiquetas al repositorio remoto...
# ✓ Etiquetas subidas exitosamente al remoto
```

---

## 📞 Soporte y Documentación

### Archivos relacionados
- `README.md` - Guía general de versionado
- `plan-etiquetado-versiones.md` - Análisis histórico
- `resumen-visual-versiones.md` - Tabla de referencia
- `Apply-VersionTags.ps1` - Script principal

### Referencias
- [Semantic Versioning 2.0.0](https://semver.org/)
- [Git Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Última actualización:** 31 de enero de 2026
**Script versión:** 2.0 (Interactivo)
**Mantenido por:** amillanaol
