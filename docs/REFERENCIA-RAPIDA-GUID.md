# Referencia Rápida - Error de GUID y Soluciones

## El Problema en una Línea

El archivo `.psd1` tenía un GUID inválido: `1234567-1234-1234-1234-123456789012` (formato incorrecto)

## Solución en una Línea

Se corrigió el GUID a formato válido: `a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6` (8-4-4-4-12 dígitos)

## Verificación Rápida

```powershell
# Si ves este error:
# "Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)"

# Solución 1 - Automática (RECOMENDADO)
cd C:\Users\alexi\src\WhisperTranslator\module
.\Install-WhisperTranslator.ps1

# Solución 2 - Manual
# 1. Abre: notepad .\module\WhisperTranslator.psd1
# 2. Busca: GUID = '...'
# 3. Reemplaza con: GUID = 'a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6'
# 4. Guarda (Ctrl+S)
# 5. Cierra PowerShell completamente
# 6. Abre una NUEVA ventana de PowerShell
```

## Documentación Disponible

- 📄 [Error de GUID Inválido](docs/troubleshooting/invalid-guid-error-on-import-module.md) - Completo
- 📄 [Validación de .psd1](docs/troubleshooting/validacion-psd1.md) - Técnico
- 📄 [Problemas de Import-Module](docs/troubleshooting/problemas-import-module.md) - Debugging
- 📄 [Resumen de Correcciones](docs/RESUMEN-CORRECCIONES.md) - Overview

## Generar un GUID Válido (Si lo Necesitas)

```powershell
# En PowerShell
[guid]::NewGuid().Guid
# Resultado: a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6 (diferente cada vez)

# En línea: https://www.guidgenerator.com/
```

## Formato Válido Explicado

```
a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6
││││││││ ──── ──── ──── ────────────────
│└─ 8 dígitos hexadecimales
└─ 4 guiones en posiciones: 8, 13, 18, 23
```

## ¿Y si Aún Tengo el Error?

1. ✅ Asegúrate de tener el GUID correcto (36 caracteres exactamente)
2. ✅ Cierra PowerShell **COMPLETAMENTE** (todas las ventanas)
3. ✅ Abre una **NUEVA** ventana de PowerShell
4. ✅ Si persiste, consulta [Error de GUID Inválido](docs/troubleshooting/invalid-guid-error-on-import-module.md)

## Archivos Implicados

- `module/WhisperTranslator.psd1` - Contiene el GUID
- `module/Install-WhisperTranslator.ps1` - Lo corrige automáticamente
- `docs/troubleshooting/invalid-guid-error-on-import-module.md` - Documentación

---

**Última actualización:** 23 de noviembre de 2025
