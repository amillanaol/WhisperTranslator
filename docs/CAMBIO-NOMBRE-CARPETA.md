# Cambio de Nombre de Carpeta: WhisperTranslator → module

## Resumen

Se ha renombrado la carpeta `WhisperTranslator` a `module` para hacer la estructura del proyecto más descriptiva y clara.

**Antes:**
```
WhisperTranslator/
├── Install-WhisperTranslator.ps1
├── Uninstall-WhisperTranslator.ps1
├── WhisperTranslator.psd1
└── WhisperTranslator.psm1
```

**Después:**
```
module/
├── Install-WhisperTranslator.ps1
├── Uninstall-WhisperTranslator.ps1
├── WhisperTranslator.psd1
└── WhisperTranslator.psm1
```

## Razón del Cambio

- **Más descriptivo:** `module/` claramente indica que esta carpeta contiene el módulo de PowerShell
- **Mejor organización:** Evita confusión entre el nombre del proyecto y el nombre de la carpeta
- **Estándar común:** Es una práctica común en proyectos de código tener una carpeta `module/`, `src/`, `lib/`, etc.

## Cambios Realizados

### 1. Carpeta Renombrada ✅
- `WhisperTranslator/` → `module/`

### 2. Documentación Actualizada ✅

Se actualizaron todas las referencias en:

| Archivo | Cambios |
|---------|---------|
| `README.md` | 5 referencias actualizadas |
| `docs/uso/guia-completa-de-uso.md` | 1 referencia actualizada |
| `docs/troubleshooting/validacion-psd1.md` | 1 referencia actualizada |
| `docs/troubleshooting/error-parametro-manifestpath.md` | 3 referencias actualizadas |
| `docs/troubleshooting/invalid-guid-error-on-import-module.md` | 2 referencias actualizadas |
| `docs/RESUMEN-CORRECCIONES.md` | 9 referencias actualizadas |
| `docs/REFERENCIA-RAPIDA-GUID.md` | 3 referencias actualizadas |
| `docs/instalacion/instalacion-rapida.md` | 1 referencia actualizada |
| `docs/instalacion/desinstalacion.md` | 2 referencias actualizadas |
| `docs/articulos/documentacion_proyecto.md` | 2 referencias actualizadas |

**Total:** 29 referencias actualizadas en documentación

### 3. Scripts Automáticos ✅

Los scripts `Install-WhisperTranslator.ps1` y `Uninstall-WhisperTranslator.ps1` utilizan `$PSScriptRoot` para las rutas, por lo que **no requieren cambios** y funcionan correctamente en la nueva ubicación.

## Nuevas Instrucciones de Instalación

```powershell
# 1. Navegar al proyecto
cd C:\Users\alexi\src\WhisperTranslator

# 2. Ejecutar instalación desde la carpeta module
.\module\Install-WhisperTranslator.ps1

# 3. Cierra PowerShell completamente y abre una nueva ventana

# 4. Verifica que funciona
Import-Module WhisperTranslator
Invoke-WhisperTranslator -Help
```

## Estructura del Proyecto Actualizada

```
WhisperTranslator/
├── README.md
├── LICENSE
├── WispherTranslator.ps1          # Script independiente
├── inputs/                         # Directorio de entrada
├── docs/                          # Documentación
│   ├── instalacion/
│   ├── uso/
│   ├── troubleshooting/
│   ├── guides/
│   └── articulos/
└── module/                        # ← Carpeta del módulo (RENOMBRADA)
    ├── Install-WhisperTranslator.ps1
    ├── Uninstall-WhisperTranslator.ps1
    ├── WhisperTranslator.psd1
    ├── WhisperTranslator.psm1
    └── Descripcion.md
```

## Impacto para Usuarios

- ✅ **Sin cambios en funcionalidad:** El módulo funciona exactamente igual
- ✅ **Mejor claridad:** El nombre `module/` es más descriptivo
- ✅ **Rutas actualizadas:** Toda la documentación refleja el nuevo nombre
- ⚠️ **Importante:** Los usuarios deben usar `.\module\Install-WhisperTranslator.ps1` en lugar de `.\WhisperTranslator\Install-WhisperTranslator.ps1`

## Verificación

Para verificar que el cambio se aplicó correctamente:

```powershell
# Verificar que la carpeta existe
Test-Path ".\module\WhisperTranslator.psd1"  # Debe retornar True

# Verificar que la vieja carpeta no existe
Test-Path ".\WhisperTranslator"  # Debe retornar False (si se eliminó completamente)
```

## Documentos de Referencia

- [README.md](../README.md) - Documento principal actualizado
- [instalacion-rapida.md](../instalacion/instalacion-rapida.md) - Guía de instalación actualizada
- [desinstalacion.md](../instalacion/desinstalacion.md) - Guía de desinstalación actualizada

---

**Fecha del cambio:** 23 de noviembre de 2025
