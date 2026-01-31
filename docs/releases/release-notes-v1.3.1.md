# WhisperTranslator v1.3.1

Esta es una versión de corrección que mejora la compatibilidad del módulo con diferentes versiones de PowerShell mediante ajustes en los operadores lógicos.

## Novedades y Mejoras

### 🐛 Correcciones de Errores
- **Compatibilidad PowerShell Mejorada:** Se ha reemplazado el operador lógico `-o` con `-or` para garantizar compatibilidad total con todas las versiones de PowerShell. El operador `-o` puede causar problemas en algunas configuraciones, mientras que `-or` es el estándar recomendado.

### 🔧 Cambios Técnicos
- Mayor compatibilidad con PowerShell 5.1+ en diferentes entornos
- Mejor portabilidad del código para ejecutarse en sistemas variados
- Cumplimiento con los estándares de sintaxis de PowerShell

## Instalación

Consulta la [Guía de Instalación](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/instalacion).

## Uso Básico

Continúa usando el alias `wtranslator`:

```powershell
# Usar alias corto
wtranslator -m small -e mkv -d .

# Ver ayuda completa
wtranslator -h
```

## Requisitos del Sistema

Sin cambios: PowerShell 5.1+

## Documentación Completa

- [README Principal](https://github.com/amillanaol/WhisperTranslator/blob/main/README.md)
- [Guía de Instalación](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/instalacion)
- [Guía de Uso](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/uso)
- [Solución de Problemas](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/troubleshooting)

## Problemas Conocidos

Ninguno crítico.

---

**Fecha de lanzamiento:** 31 de enero de 2026
**Versión:** 1.3.1
