# 🎉 WhisperTranslator v1.0.0

Primera versión estable de WhisperTranslator como **módulo de PowerShell**.

## ✨ Características Principales

- ✅ Módulo PowerShell instalable y reutilizable
- ✅ Generación automática de subtítulos SRT usando Whisper
- ✅ Soporte para múltiples formatos de video (mp4, mkv, webm)
- ✅ Múltiples modelos de Whisper disponibles (tiny, base, small, medium, turbo)
- ✅ Procesamiento por lotes de múltiples archivos
- ✅ Scripts de instalación automatizada
- ✅ Detección inteligente de archivos ya procesados

## 📦 Instalación

### Opción 1: Instalación Automática (Recomendada)
```powershell
# Clonar el repositorio
git clone https://github.com/milepmastering-labs/WhisperTranslator.git
cd WhisperTranslator

# Ejecutar script de instalación
.\module\Install-WhisperTranslator.ps1
```

### Opción 2: Instalación Manual
1. Descargar el código fuente de esta release
2. Extraer el contenido de la carpeta `module` a:
   ```
   C:\Users\TuUsuario\Documents\PowerShell\Modules\WhisperTranslator\
   ```
3. Reiniciar PowerShell
4. Verificar instalación: `Get-Module -ListAvailable WhisperTranslator`

## 🎯 Uso Básico

```powershell
# Importar el módulo (automático si está instalado)
Import-Module WhisperTranslator

# Procesar videos en el directorio inputs con modelo tiny
Invoke-WhisperTranslator -Directory ".\inputs" -Model tiny -Extension mp4

# Usar alias corto
Invoke-WhisperTranslator -d ".\videos" -m small -e mkv

# Ver versión
Invoke-WhisperTranslator -Version

# Ver ayuda completa
Invoke-WhisperTranslator -Help
```

## 📋 Requisitos del Sistema

### Requisitos Obligatorios
- **PowerShell:** 5.1 o superior
- **Python:** 3.8 o superior
- **Whisper:** Instalado vía pip (`pip install openai-whisper`)
- **FFmpeg:** Instalado y en el PATH del sistema

### Requisitos Opcionales
- **Git:** Para clonar el repositorio
- **CUDA:** Para aceleración GPU (opcional pero recomendado)

## 🔧 Comandos y Parámetros

### Comando Principal
```powershell
Invoke-WhisperTranslator [-Directory] [-Model] [-Extension] [-Version] [-Help]
```

### Parámetros Disponibles

| Parámetro | Alias | Valores | Por Defecto | Descripción |
|-----------|-------|---------|-------------|-------------|
| `-Directory` | `-d` | Ruta | `.\inputs` | Directorio con archivos de video |
| `-Model` | `-m` | tiny, base, small, medium, turbo | `tiny` | Modelo de Whisper a utilizar |
| `-Extension` | `-e` | mp4, mkv, webm | `mp4` | Extensión de archivos a procesar |
| `-Version` | `-v` | - | - | Muestra versión del módulo |
| `-Help` | - | - | - | Muestra ayuda detallada |

## 🚀 Ejemplos de Uso

### Ejemplo 1: Uso básico
```powershell
Invoke-WhisperTranslator
# Procesa archivos .mp4 en .\inputs con modelo tiny
```

### Ejemplo 2: Modelo específico
```powershell
Invoke-WhisperTranslator -Model medium -Extension mkv
# Procesa archivos .mkv con modelo medium (mejor calidad)
```

### Ejemplo 3: Directorio personalizado
```powershell
Invoke-WhisperTranslator -Directory "C:\Videos\Clases" -Model small
# Procesa videos en una ruta específica
```

### Ejemplo 4: Procesamiento avanzado
```powershell
Invoke-WhisperTranslator -d ".\series" -m turbo -e webm
# Procesa archivos .webm con el modelo turbo (más rápido)
```

## 📊 Modelos de Whisper Disponibles

| Modelo | Velocidad | Precisión | RAM Requerida | Uso Recomendado |
|--------|-----------|-----------|---------------|-----------------|
| **tiny** | ⚡⚡⚡⚡⚡ | ⭐⭐ | ~1 GB | Pruebas rápidas |
| **base** | ⚡⚡⚡⚡ | ⭐⭐⭐ | ~1 GB | Uso general rápido |
| **small** | ⚡⚡⚡ | ⭐⭐⭐⭐ | ~2 GB | Balance calidad/velocidad |
| **medium** | ⚡⚡ | ⭐⭐⭐⭐⭐ | ~5 GB | Alta calidad |
| **turbo** | ⚡⚡⚡⚡ | ⭐⭐⭐⭐ | ~3 GB | Rápido y preciso |

## 📚 Documentación Completa

- [README Principal](https://github.com/milepmastering-labs/WhisperTranslator/blob/main/README.md)
- [Guía de Instalación](https://github.com/milepmastering-labs/WhisperTranslator/tree/main/docs/instalacion)
- [Guía de Uso](https://github.com/milepmastering-labs/WhisperTranslator/tree/main/docs/uso)
- [Solución de Problemas](https://github.com/milepmastering-labs/WhisperTranslator/tree/main/docs/troubleshooting)

## 🔄 Migración desde versión de Script

Si usabas la versión anterior como script standalone:

1. **Desinstala** (si aplicaba) cualquier versión anterior
2. **Instala** el módulo usando `Install-WhisperTranslator.ps1`
3. **Usa** el comando `Invoke-WhisperTranslator` en lugar del script

Los parámetros son los mismos, pero ahora disponibles desde cualquier ubicación.

## 🐛 Problemas Conocidos

- Ningún problema crítico conocido en esta versión

## 🔮 Próximas Características

Planeadas para versiones futuras:
- Alias `wtranslator` para uso más rápido
- Soporte para más idiomas de transcripción
- Interfaz gráfica opcional
- Procesamiento paralelo de múltiples archivos

## 🙏 Agradecimientos

Gracias a:
- OpenAI por el modelo Whisper
- La comunidad de PowerShell
- Todos los early adopters y testers

## 🤝 Contribuciones

Las contribuciones son bienvenidas! 

Para contribuir:
1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver [LICENSE](https://github.com/milepmastering-labs/WhisperTranslator/blob/main/LICENSE) para más detalles.

## 👨‍💻 Autor

**amillanaol**
- GitHub: [@amillanaol](https://github.com/amillanaol)
- Email: alexis.millanao@hotmail.com

## 📞 Soporte

- **Issues:** [GitHub Issues](https://github.com/milepmastering-labs/WhisperTranslator/issues)
- **Discusiones:** [GitHub Discussions](https://github.com/milepmastering-labs/WhisperTranslator/discussions)

---

**Fecha de lanzamiento:** 24 de febrero de 2025  
**Commit:** 95d6624  
**Versión:** 1.0.0
