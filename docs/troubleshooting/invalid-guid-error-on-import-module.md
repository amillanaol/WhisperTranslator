# Solución de Problemas (Troubleshooting)

## Error al importar el módulo: "The 'guid' member is not valid"

**Problema:**

Al ejecutar `Import-Module WhisperTranslator`, puedes encontrar el siguiente error:

```powershell
Import-Module: The 'guid' member is not valid in the module manifest file '...\\WhisperTranslator.psd1': Cannot convert value "..." to type "System.Guid". Error: "Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)."
```

**Causa:**

Este error ocurre porque el `GUID` especificado en el archivo de manifiesto del módulo (`WhisperTranslator.psd1`) no es un Identificador Único Global válido. Usualmente, esto sucede si el valor es un marcador de posición.

**Solución:**

1.  Abre el archivo `WhisperTranslator.psd1` en un editor de texto.
2.  Busca la línea que contiene `GUID`.
3.  Reemplaza el valor actual del GUID por uno nuevo y válido. Puedes generar un nuevo GUID ejecutando el siguiente comando en PowerShell:
    ```powershell
    [guid]::NewGuid().Guid
    ```
4.  Guarda el archivo `WhisperTranslator.psd1`.

Después de corregir el GUID, el comando `Import-Module` debería funcionar correctamente.

```