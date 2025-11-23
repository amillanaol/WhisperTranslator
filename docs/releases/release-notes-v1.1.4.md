# WhisperTranslator v1.1.4

Versión mejorada con documentación completa y múltiples mejoras incrementales.

## 📝 Novedades en esta Versión

### Documentación
- ✅ README actualizado con ejemplos más claros
- ✅ Nuevos ejemplos de uso para diferentes escenarios
- ✅ Mejora en la presentación de características
- ✅ Badges actualizados

## 🔄 Historial de Cambios desde v1.0.0

### v1.1.4 (Esta versión)
- **docs:** Actualización del README con nuevos ejemplos de uso

### v1.1.3
- **docs:** Guía de uso actualizada para reflejar el nuevo alias (preparación)

### v1.1.2
- **docs:** Actualización de la guía de instalación y scripts

### v1.1.1
- **fix:** Corrección de GUID inválido en el manifiesto del módulo
  - ⚠️ Este era un bug crítico que impedía la importación correcta

### v1.1.0
- **feat:** Agregado script de desinstalación completo
- **feat:** Nueva documentación de desinstalación

### v1.0.1
- **docs:** Reescritura completa del README con mejor estructura

## 📦 Instalación

```powershell
# Clonar repositorio
git clone https://github.com/amillanaol/WhisperTranslator.git
cd WhisperTranslator

# Instalar módulo
.\module\Install-WhisperTranslator.ps1
```

## 🚀 Uso

```powershell
# Comando básico
Invoke-WhisperTranslator

# Con parámetros
Invoke-WhisperTranslator -Directory ".\videos" -Model medium -Extension mkv

# Ver ayuda
Invoke-WhisperTranslator -Help
```

## 🐛 Correcciones Importantes

Esta versión incluye todas las correcciones críticas desde v1.0.0:
- ✅ GUID del módulo corregido (v1.1.1)
- ✅ Script de desinstalación funcional
- ✅ Documentación completa y actualizada

## 📚 Documentación

- [README](https://github.com/amillanaol/WhisperTranslator/blob/main/README.md)
- [Guía de Instalación](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/instalacion)
- [Guía de Uso](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/uso)
- [Guía de Desinstalación](https://github.com/amillanaol/WhisperTranslator/tree/main/docs/instalacion/uninstall-guide.md)

## ⚠️ Nota sobre el Alias

**Nota importante:** En esta versión, el alias `wtranslator` está declarado pero no se exporta correctamente. 
Esto será corregido en la v1.2.0. Por ahora, usa `Invoke-WhisperTranslator`.

## 🔜 Próxima Versión (v1.2.0)

La próxima versión incluirá:
- ✅ Corrección del alias `wtranslator` 
- ✅ Documentación del problema y solución
- ✅ Mejores prácticas para aliases en módulos

## 📄 Licencia

MIT License - Ver [LICENSE](https://github.com/amillanaol/WhisperTranslator/blob/main/LICENSE)

---

**Versión:** 1.1.4  
**Commit:** 5ea9cd9  
**Fecha:** 1 de mayo de 2025
