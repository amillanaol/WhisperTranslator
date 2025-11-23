# Guía de Uso: Script de Instalación y Reparación Automática

## Propósito del Script `Install-WhisperTranslator.ps1`

Se ha creado un script auxiliar llamado `Install-WhisperTranslator.ps1` para mejorar la experiencia de instalación e importación del módulo.

Su objetivo principal es solucionar automáticamente un problema común que puede ocurrir la primera vez que se importa el módulo: un error de "GUID inválido".

## ¿Por qué es necesario?

El manifiesto de un módulo de PowerShell (`.psd1`) se procesa antes que el propio código del módulo (`.psm1`). Si el `GUID` en el manifiesto es incorrecto, PowerShell detiene la importación inmediatamente. Esto impide que el módulo pueda autocorregirse de forma nativa.

El script `Install-WhisperTranslator.ps1` actúa como un envoltorio inteligente para el proceso de importación.

## ¿Cómo funciona?

1.  **Intento de Importación:** El script primero intenta importar el módulo de la manera estándar.
2.  **Detección de Errores:** Si falla específicamente con el error de GUID inválido, lo captura.
3.  **Corrección Automática:** Genera un nuevo GUID válido y actualiza el archivo `WhisperTranslator.psd1` automáticamente.
4.  **Notificación:** Informa al usuario en la consola que ha detectado el problema y lo ha corregido.
5.  **Reintento de Importación:** Vuelve a importar el módulo, que ahora tiene un manifiesto válido.

## ¿Cómo usarlo?

Navega al directorio raíz del módulo `WhisperTranslator` en tu consola de PowerShell y ejecuta:

```powershell
.\Install-WhisperTranslator.ps1
```

La primera vez que lo ejecutes, el script reparará el módulo si es necesario. Para usos futuros, puedes seguir usando este mismo script o volver a usar el comando `Import-Module WhisperTranslator` de forma segura.
