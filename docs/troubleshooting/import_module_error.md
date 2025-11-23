# Nota de Bug: Error al importar el módulo WhisperTranslator

**ID de Bug:** 001
**Fecha:** 23 de noviembre de 2025
**Estado:** Documentado

---

### 1. Descripción del Error

Al intentar cargar el módulo con el comando `Import-Module WhisperTranslator`, PowerShell arroja el siguiente error:

```
Import-Module: The specified module 'WhisperTranslator' was not loaded because no valid module file was found in any module directory.
```

### 2. Causa Raíz

El error ocurre porque el módulo `WhisperTranslator` no ha sido instalado en ninguno de los directorios estándar que PowerShell monitorea para encontrar módulos. El entorno de ejecución no sabe dónde localizar los archivos del módulo (`.psd1`, `.psm1`).

El módulo existe en el directorio de desarrollo del proyecto, pero no en una ruta de sistema reconocida por `$env:PSModulePath`.

### 3. Proceso de Diagnóstico

Para identificar las carpetas donde PowerShell busca módulos, se puede usar el siguiente comando:

```powershell
echo $env:PSModulePath
```

La salida de este comando muestra una lista de rutas separadas por punto y coma. Se debe verificar que la carpeta del módulo `WhisperTranslator` exista en alguna de estas ubicaciones.

### 4. Soluciones

#### Solución A: Importación Temporal por Ruta Directa

Para una carga rápida sin instalación permanente, se puede importar el módulo especificando la ruta completa a su archivo de manifiesto (`.psd1`).

**Comando:**
```powershell
Import-Module RUTA_AL_PROYECTO\WhisperTranslator\WhisperTranslator.psd1
```

**Ventaja:** Útil para desarrollo y pruebas rápidas.
**Desventaja:** No es persistente entre sesiones de consola.

#### Solución B: Instalación Permanente del Módulo

La solución recomendada es instalar el módulo para el usuario actual, copiando la carpeta del módulo a la carpeta de Módulos de PowerShell del perfil del usuario.

**Pasos:**

1.  Abrir PowerShell y navegar a la raíz del proyecto.
2.  Ejecutar el comando para copiar los archivos del módulo:

    ```powershell
    # Ejemplo de ruta de destino para el usuario 'alexi'
    $userModulesPath = "$env:USERPROFILE\Documents\PowerShell\Modules"
    Copy-Item -Path ".\WhisperTranslator" -Destination $userModulesPath -Recurse -Force
    ```

3.  Abrir una **nueva** terminal de PowerShell. El comando `Import-Module WhisperTranslator` funcionará correctamente.

**Ventaja:** El módulo queda disponible de forma global y persistente.
**Desventaja:** Requiere un paso de "instalación".

---
