# Simulación de Ejecución - Apply-VersionTags.ps1 (Interactivo v2.0)

**Actualizado:** 31 de enero de 2026
**Script Versión:** 2.0 (Interactivo)
**Comando simulado:**
```powershell
.\docs\versionado\Apply-VersionTags.ps1 -DryRun
```

---

## 📋 Salida del Script (Modo Prueba Interactivo)

### 1. Inicialización del Script

```
═════════════════════════════════════════════════
  GESTOR INTERACTIVO DE ETIQUETAS DE VERSIÓN
═════════════════════════════════════════════════

[MODO PRUEBA ACTIVADO]
Los comandos git se mostrarán pero NO se ejecutarán

Se encontraron 5 commits sin etiquetar

Última etiqueta: v1.1.4

═════════════════════════════════════════════════
```

### 2. Menú Principal

```
═════════════════════════════════════════════════
  GESTOR DE ETIQUETAS DE VERSIÓN
═════════════════════════════════════════════════

Commits sin etiquetar: 5
Commits procesados: 0

1. Ver lista de commits
2. Procesar commits individualmente
3. Ver preview de tags pendientes
4. Aplicar tags
5. Salir sin aplicar
═════════════════════════════════════════════════

Seleccione opción: 1
```

### 3. Ver Lista de Commits (Opción 1)

```
════════════════════════════════════════
COMMITS SIN ETIQUETAR (5 encontrados)
════════════════════════════════════════

○ 1. abc1234 - docs: update README
○ 2. def5678 - feat: add new feature
○ 3. ghi9012 - fix: correct bug
○ 4. jkl3456 - docs: update guides
○ 5. mno7890 - chore: maintenance

════════════════════════════════════════

Presione Enter para continuar
```

### 4. Procesar Commits Individualmente (Opción 2)

```
─────────────────────────────────────────
PROCESANDO COMMIT [1/5]
─────────────────────────────────────────
Commit: abc1234 - docs: update README

1. Ver detalles completos
2. Asignar tipo: MAJOR (versión principal)
3. Asignar tipo: MINOR (nueva funcionalidad)
4. Asignar tipo: PATCH (corrección)
5. Asignar mensaje personalizado
6. Marcar como procesado
7. Volver al menú principal
8. Salir sin aplicar

Seleccione opción: 1
```

### 5. Detalles Completos del Commit

```
════════════════════════════════════════
DETALLES DEL COMMIT
════════════════════════════════════════

Hash:      abc1234abc1234abc1234abc1234abc1234abc1234
Mensaje:   docs: update README
Autor:     amillanaol <user@example.com>
Fecha:     2025-11-23
Tipo:      No asignado
Etiqueta:  Pendiente
════════════════════════════════════════

Seleccione opción: 4
```

### 6. Asignar Tipo de Versión (PATCH)

```
Tipo asignado: PATCH - v1.1.5

─────────────────────────────────────────
PROCESANDO COMMIT [1/5]
─────────────────────────────────────────
Commit: abc1234 - docs: update README

1. Ver detalles completos
2. Asignar tipo: MAJOR (versión principal)
3. Asignar tipo: MINOR (nueva funcionalidad)
4. Asignar tipo: PATCH (corrección)
5. Asignar mensaje personalizado
6. Marcar como procesado
7. Volver al menú principal
8. Salir sin aplicar

Seleccione opción: 6

Commit marcado como procesado
```

### 7. Procesar Segundo Commit

```
─────────────────────────────────────────
PROCESANDO COMMIT [2/5]
─────────────────────────────────────────
Commit: def5678 - feat: add new feature

1. Ver detalles completos
2. Asignar tipo: MAJOR (versión principal)
3. Asignar tipo: MINOR (nueva funcionalidad)
4. Asignar tipo: PATCH (corrección)
5. Asignar mensaje personalizado
6. Marcar como procesado
7. Volver al menú principal
8. Salir sin aplicar

Seleccione opción: 3

Tipo asignado: MINOR - v1.2.0

Seleccione opción: 6

Commit marcado como procesado
```

### 8. Procesar Resto de Commits

```
─────────────────────────────────────────
PROCESANDO COMMIT [3/5]
─────────────────────────────────────────
Commit: ghi9012 - fix: correct bug

...

Tipo asignado: PATCH - v1.2.1

─────────────────────────────────────────
PROCESANDO COMMIT [4/5]
─────────────────────────────────────────
Commit: jkl3456 - docs: update guides

...

Tipo asignado: PATCH - v1.2.2

─────────────────────────────────────────
PROCESANDO COMMIT [5/5]
─────────────────────────────────────────
Commit: mno7890 - chore: maintenance

...

Tipo asignado: PATCH - v1.2.3
```

### 9. Volver al Menú Principal y Ver Preview

```
═════════════════════════════════════════════════
  GESTOR DE ETIQUETAS DE VERSIÓN
═════════════════════════════════════════════════

Commits sin etiquetar: 5
Commits procesados: 5

1. Ver lista de commits
2. Procesar commits individualmente
3. Ver preview de tags pendientes
4. Aplicar tags
5. Salir sin aplicar
═════════════════════════════════════════════════

Seleccione opción: 3
```

### 10. Preview de Etiquetas a Crear

```
════════════════════════════════════════
PREVIEW DE ETIQUETAS A CREAR
════════════════════════════════════════

Etiqueta: v1.1.5
Commit:   abc1234
Mensaje:  docs: update README

Etiqueta: v1.2.0
Commit:   def5678
Mensaje:  feat: add new feature

Etiqueta: v1.2.1
Commit:   ghi9012
Mensaje:  fix: correct bug

Etiqueta: v1.2.2
Commit:   jkl3456
Mensaje:  docs: update guides

Etiqueta: v1.2.3
Commit:   mno7890
Mensaje:  chore: maintenance

════════════════════════════════════════
Total de etiquetas a crear: 5
════════════════════════════════════════

Presione Enter para continuar
```

### 11. Aplicar Etiquetas (Opción 4)

```
═════════════════════════════════════════════════
  GESTOR DE ETIQUETAS DE VERSIÓN
═════════════════════════════════════════════════

Commits sin etiquetar: 5
Commits procesados: 5

1. Ver lista de commits
2. Procesar commits individualmente
3. Ver preview de tags pendientes
4. Aplicar tags
5. Salir sin aplicar
═════════════════════════════════════════════════

Seleccione opción: 4

¿Desea aplicar las etiquetas?
Esta acción no puede deshacerse fácilmente
¿Continuar? (s/n): s
```

### 12. Aplicación de Etiquetas en Modo DryRun

```
════════════════════════════════════════
APLICANDO ETIQUETAS
════════════════════════════════════════

[MODO PRUEBA - Los comandos NO serán ejecutados]

Etiqueta: v1.1.5 | Commit: abc1234
  Comando: git tag -a v1.1.5 abc1234abc1234abc1234abc1234abc1234abc1234 -m "docs: update README"

Etiqueta: v1.2.0 | Commit: def5678
  Comando: git tag -a v1.2.0 def5678def5678def5678def5678def5678def5678 -m "feat: add new feature"

Etiqueta: v1.2.1 | Commit: ghi9012
  Comando: git tag -a v1.2.1 ghi9012ghi9012ghi9012ghi9012ghi9012ghi9012 -m "fix: correct bug"

Etiqueta: v1.2.2 | Commit: jkl3456
  Comando: git tag -a v1.2.2 jkl3456jkl3456jkl3456jkl3456jkl3456jkl3456 -m "docs: update guides"

Etiqueta: v1.2.3 | Commit: mno7890
  Comando: git tag -a v1.2.3 mno7890mno7890mno7890mno7890mno7890mno7890 -m "chore: maintenance"

════════════════════════════════════════
RESUMEN
════════════════════════════════════════

Se crearían 5 etiquetas

[MODO PRUEBA] Se ejecutaría: git push origin --tags

════════════════════════════════════════
Script completado.
```

---

## 🎯 Diferencias vs. Versión Anterior

### Versión 1.0 (Hardcodeada)
- Versiones predefinidas en el script
- Parámetro `-Strategy` para elegir (Essential/Full/Custom)
- Ejecución no interactiva
- Aplicación automática de todas las etiquetas

### Versión 2.0 (Interactiva)
- ✅ Detección automática de commits sin etiquetar
- ✅ Menú interactivo con navegación
- ✅ Asignación de tipos (major/minor/patch) por commit
- ✅ Opción de personalizar mensajes de tags
- ✅ Preview de etiquetas antes de aplicar
- ✅ Mejor visualización con colores
- ✅ Control total del usuario sobre qué etiquetar

---

## 💡 Notas Importantes

1. **DryRun muestra comandos pero no los ejecuta** - Perfecto para validar
2. **El script detecta automáticamente commits** - No hay hardcoding
3. **Puedes salir en cualquier momento** - Sin cambios aplicados
4. **Los colores facilitan la lectura** - Cyan para info, Verde para éxito, Rojo para errores
5. **Validación de etiquetas existentes** - Se omiten si ya existen

---

## 🚀 Próximos Pasos en Modo Real

Para ejecutar sin `-DryRun`:
```powershell
.\docs\versionado\Apply-VersionTags.ps1
```

Las etiquetas se crearán realmente. Para subirlas:
```powershell
git push origin --tags
```

O en una sola ejecución:
```powershell
.\docs\versionado\Apply-VersionTags.ps1 -Push
```

---

**Última actualización:** 31 de enero de 2026
**Script versión:** 2.0 (Interactivo)
