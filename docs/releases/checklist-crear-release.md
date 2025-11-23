# ✅ Checklist para Crear tu Primer Release

## 🎯 Release Recomendado: v1.0.0

---

## Paso 1: Preparación (5 min)

### ☑️ Verificar que las etiquetas existen
```powershell
cd $env:USERPROFILE\src\WhisperTranslator
git tag -l
```

**Esperado:** Debes ver `v1.0.0` en la lista

- [ ] Etiqueta v1.0.0 existe localmente
- [ ] Etiquetas subidas a GitHub (`git push origin --tags`)

---

## Paso 2: Ir a GitHub (2 min)

### ☑️ Navegar al repositorio
1. [ ] Abrir navegador
2. [ ] Ir a: https://github.com/amillanaol/WhisperTranslator
3. [ ] Iniciar sesión (si es necesario)

### ☑️ Ir a la sección de Releases
1. [ ] Click en la pestaña **"Releases"** (barra superior)
2. [ ] O ir directo a: https://github.com/amillanaol/WhisperTranslator/releases

---

## Paso 3: Crear Nuevo Release (10 min)

### ☑️ Iniciar creación
1. [ ] Click en **"Draft a new release"** (botón verde)
2. [ ] O **"Create a new release"**

### ☑️ Configurar Tag
1. [ ] En "Choose a tag", seleccionar: **v1.0.0**
2. [ ] Verificar que apunta al commit correcto (95d6624)

### ☑️ Configurar Título
```
WhisperTranslator v1.0.0 - Módulo PowerShell
```
- [ ] Título copiado y pegado

### ☑️ Configurar Descripción
1. [ ] Abrir archivo: `docs\releases\release-notes-v1.0.0.md`
2. [ ] Copiar TODO el contenido
3. [ ] Pegar en el campo "Describe this release"
4. [ ] Verificar que el formato se ve bien en la previsualización

### ☑️ Opciones adicionales
- [ ] **¿Pre-release?** → ❌ NO marcar (es versión estable)
- [ ] **¿Set as the latest release?** → ✅ SÍ marcar
- [ ] **¿Create a discussion?** → ⚪ Opcional (tu elección)

---

## Paso 4: Adjuntar Assets (Opcional) (5 min)

### ☑️ Crear ZIP del módulo
```powershell
cd $env:USERPROFILE\src\WhisperTranslator
Compress-Archive -Path .\module\* -DestinationPath WhisperTranslator-v1.0.0.zip
```

### ☑️ Subir a GitHub
1. [ ] En la sección "Attach binaries"
2. [ ] Arrastrar archivo `WhisperTranslator-v1.0.0.zip`
3. [ ] Esperar que se suba (ver barra de progreso)

---

## Paso 5: Publicar (1 min)

### ☑️ Revisión final
- [ ] Título correcto
- [ ] Tag correcto (v1.0.0)
- [ ] Descripción completa
- [ ] NO marcado como pre-release
- [ ] Assets subidos (si aplicable)

### ☑️ Publicar
1. [ ] Click en **"Publish release"** (botón verde grande)
2. [ ] Esperar confirmación

### ☑️ Verificar publicación
1. [ ] El release aparece en la página de releases
2. [ ] El badge de "Latest" aparece en el release
3. [ ] Los assets (si los subiste) se pueden descargar

---

## Paso 6: Post-Publicación (5 min)

### ☑️ Actualizar README
Agregar badge de versión al README principal:

```markdown
[![GitHub release](https://img.shields.io/github/v/release/amillanaol/WhisperTranslator)](https://github.com/amillanaol/WhisperTranslator/releases)
```

1. [ ] Agregar badge al README.md
2. [ ] Commit y push
```powershell
git add README.md
git commit -m "docs: add release badge to README"
git push origin main
```

### ☑️ Verificaciones finales
- [ ] Release visible en: https://github.com/amillanaol/WhisperTranslator/releases
- [ ] Badge funciona correctamente
- [ ] Links en el release notes funcionan

---

## 📊 Resumen de Tiempo Estimado

| Paso | Tiempo | Actividad |
|------|--------|-----------|
| 1 | 5 min | Preparación y verificación |
| 2 | 2 min | Navegar a GitHub |
| 3 | 10 min | Configurar y crear release |
| 4 | 5 min | Adjuntar assets (opcional) |
| 5 | 1 min | Publicar |
| 6 | 5 min | Post-publicación |
| **Total** | **~30 min** | Primera vez (más rápido después) |

---

## 🎉 ¡Felicidades!

Si completaste todos los pasos, ahora tienes:
- ✅ Tu primer release publicado en GitHub
- ✅ Documentación profesional
- ✅ Assets descargables (si los agregaste)
- ✅ Badge de versión en el README

---

## 🔜 Próximos Releases

Para futuros releases (v1.1.4, v1.2.0, etc.):
1. El proceso es el mismo
2. Usa los archivos de release notes correspondientes
3. Será más rápido (10-15 min)

### Archivos de notas disponibles:
- `release-notes-v1.0.0.md` ✅ Usaste este
- `release-notes-v1.1.4.md` 📄 Para la versión actual
- `release-notes-v1.2.0.md` 🔜 Para la próxima versión (después del fix)

---

## 🆘 Troubleshooting

### Problema: No veo el tag v1.0.0
**Solución:**
```powershell
git push origin v1.0.0
```

### Problema: El formato del markdown no se ve bien
**Solución:**
- Usa la pestaña "Preview" para verificar
- Asegúrate de copiar TODO el contenido del archivo

### Problema: No puedo subir el ZIP
**Solución:**
- Verifica que el archivo sea menor a 2GB
- Intenta arrastrarlo directamente al área de "Attach binaries"

---

## 📚 Referencias

- [Guía Completa](./guia-primer-release.md)
- [Documentación GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github)
- [Notas v1.0.0](./release-notes-v1.0.0.md)
- [Notas v1.1.4](./release-notes-v1.1.4.md)

---

**Estado:** 📝 Lista de verificación lista  
**Acción:** Comenzar con el Paso 1  
**Tiempo estimado:** 30 minutos
