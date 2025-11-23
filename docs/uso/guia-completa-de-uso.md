# Guía Completa de Uso

## Comando Principal y Alias

El módulo proporciona el comando `Invoke-WhisperTranslator`, pero para mayor comodidad, también registra un alias más corto: `wtranslator`.

En todos los ejemplos de esta guía usaremos el alias `wtranslator`.

```powershell
# Estos dos comandos son equivalentes
Invoke-WhisperTranslator -Directory "."
wtranslator -d "."
```

## Usando el Módulo Instalado

```powershell
wtranslator [-Directory <ruta>] [-Model <modelo>] [-Extension <extensión>]
```

## Usando el Script Independiente

Ejecuta directamente el script sin instalar:

```powershell
.\WispherTranslator.ps1 -Directory "." -Model "tiny" -Extension "mp4"
```

O invócalo como comando registrado en el sistema:

```powershell
whisper-translator .
```

Para registrar el comando, ver [Registro de Comando](../registro-comando/registro-como-comando-global.md)

## Parámetros Disponibles

- **`-Directory` o `-d`**: Ruta al directorio que contiene los archivos de video
  - Valor por defecto: `./inputs`
  - Acepta `.` para usar el directorio actual
  
- **`-Model` o `-m`**: Modelo de Whisper a utilizar
  - Valores permitidos: `base`, `tiny`, `small`, `medium`, `turbo`
  - Valor por defecto: `tiny`
  
- **`-Extension` o `-e`**: Extensión de los archivos a procesar
  - Valores permitidos: `mp4`, `mkv`, `webm`
  - Valor por defecto: `mp4`
  
- **`-Help`**: Muestra el mensaje de ayuda

## Ejemplos Prácticos

### Procesar archivos en el directorio actual

```powershell
wtranslator -d "."
```

### Procesar archivos MKV con modelo base

```powershell
wtranslator -Directory "C:\Videos" -Model "base" -Extension "mkv"
```

### Procesar archivos WEBM con modelo medium (máxima precisión)

```powershell
wtranslator -d "C:\Videos" -m "medium" -e "webm"
```

### Usar abreviaturas

```powershell
# Los parámetros tienen alias cortos
wtranslator -d "." -m "small" -e "mp4"
```

### Ver la ayuda

```powershell
wtranslator -Help
```

## Cómo Funciona

1. **Búsqueda de archivos**: Busca recursivamente todos los archivos del formato especificado
2. **Verificación de subtítulos**: Verifica si cada video ya tiene un archivo `.srt`
3. **Procesamiento selectivo**: Solo procesa archivos sin subtítulos existentes
4. **Transcripción**: Utiliza Whisper AI para generar las transcripciones en español
5. **Generación de SRT**: Crea archivos `.srt` con el mismo nombre que el video

### Características

- ✅ Procesamiento recursivo de subdirectorios
- ✅ Salto automático de archivos ya procesados
- ✅ Soporte para múltiples formatos de video (mp4, mkv, webm)
- ✅ Selección flexible del modelo de Whisper
- ✅ Optimizado para transcripción en español
- ✅ Información detallada del progreso en consola

## Guía de Modelos de Whisper

| Modelo | Velocidad | Precisión | Caso de Uso |
|--------|-----------|-----------|------------|
| **tiny** | ⚡⚡⚡⚡ Muy rápido | ⭐⭐ Baja | Pruebas, GPU limitada |
| **base** | ⚡⚡⚡ Rápido | ⭐⭐⭐ Media | Balance general |
| **small** | ⚡⚡ Medio | ⭐⭐⭐⭐ Alta | Producción estándar |
| **medium** | ⚡ Lento | ⭐⭐⭐⭐⭐ Muy alta | Máxima precisión |
| **turbo** | ⚡⚡⚡ Rápido | ⭐⭐⭐⭐ Alta | GPU disponible |

### Recomendaciones por Caso de Uso

- **Desarrollo/Pruebas**: Usa `tiny` para iteraciones rápidas
- **Producción estándar**: Usa `base` o `small` para balance
- **Contenido crítico**: Usa `medium` para máxima precisión
- **Con GPU potente**: Usa `turbo` para mejor relación velocidad-precisión

## Mejores Prácticas

### Organización

Organiza los videos en carpetas por categorías:
```
Videos/
├── Podcast/
│   ├── episodio1.mp4
│   └── episodio2.mp4
├── Conferencias/
│   ├── charla1.mp4
│   └── charla2.mp4
└── Tutoriales/
    └── tutorial.mp4
```

Luego procesa cada carpeta:
```powershell
wtranslator -d "Videos\Podcast" -m "small"
```

### Selección de Modelo

- **Modelos ligeros** (`tiny`, `base`): Videos de calidad alta, audio claro
- **Modelos pesados** (`small`, `medium`): Audio de mala calidad, acentos diversos

### Espacio en Disco

Cada modelo requiere aproximadamente:
- `tiny`: ~40 MB
- `base`: ~140 MB
- `small`: ~465 MB
- `medium`: ~1.5 GB
- `turbo`: Similar a `medium`

Asegúrate de tener espacio suficiente antes de procesar muchos archivos.

### Archivos Largos

Para archivos muy largos (>2 horas):
- Considera usar modelos más ligeros (`tiny`, `base`)
- O divide el archivo en partes más pequeñas
- Monitorea el consumo de memoria en la consola

### Idioma

El módulo está optimizado para español. Si necesitas otro idioma:

1. Edita el archivo `module/WhisperTranslator.psm1`
2. Busca la línea: `--language Spanish`
3. Reemplázala con el idioma deseado (ej: `English`, `French`, etc.)

## Troubleshooting Rápido

**P: ¿Por qué no procesa archivos?**
R: Verifica que los archivos tengan la extensión correcta y que no tengan ya un `.srt` asociado.

**P: ¿El proceso es muy lento?**
R: Usa un modelo más ligero (`tiny` o `base`).

**P: ¿Error de permisos?**
R: Ejecuta PowerShell como administrador o verifica permisos en la carpeta.

**P: ¿Quiero detener el proceso?**
R: Presiona `Ctrl+C` en la consola para interrumpir.

Para más problemas, ver [Solución de Problemas](../troubleshooting/)
