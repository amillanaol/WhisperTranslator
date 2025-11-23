# Error: Alias 'wtranslator' no reconocido

**Fecha:** 23 de noviembre de 2025  
**Versión del módulo:** 0.1.0  
**Estado:** ✅ RESUELTO

## Descripción del problema

Al ejecutar el comando `wtranslator` en PowerShell, se mostraba el siguiente error:

```
wtranslator : The term 'wtranslator' is not recognized as a name of a cmdlet, function, 
script file, or executable program. Check the spelling of the name, or if a path was 
included, verify that the path is correct and try again.
```

A pesar de que:
- El módulo `WhisperTranslator` estaba correctamente instalado
- `Get-Module -ListAvailable WhisperTranslator` mostraba el módulo disponible
- El alias `wtranslator` estaba declarado en el archivo de manifiesto `.psd1`

## Diagnóstico

### Archivos revisados

1. **WhisperTranslator.psd1** (Manifiesto del módulo)
   - Ubicación: `C:\Users\alexi\Documents\PowerShell\Modules\WhisperTranslator\`
   - El alias estaba declarado correctamente en `AliasesToExport`:
   ```powershell
   AliasesToExport = @('wtranslator')
   ```

2. **WhisperTranslator.psm1** (Archivo del módulo)
   - El problema: **El alias nunca se creaba ni se exportaba**
   - Solo contenía: `Export-ModuleMember -Function Invoke-WhisperTranslator`
   - Faltaba: Crear el alias con `New-Alias` y exportarlo

### Causa raíz

El archivo de manifiesto (`.psd1`) declaraba el alias en `AliasesToExport`, pero esto solo es una declaración de intención. Para que un alias funcione, es necesario:

1. **Crear el alias** en el módulo usando `New-Alias`
2. **Exportar el alias** usando `Export-ModuleMember -Alias`

Sin estos pasos, PowerShell no puede reconocer el alias, aunque esté declarado en el manifiesto.

## Solución implementada

### Cambios en WhisperTranslator.psm1

Se modificó la sección final del archivo, reemplazando:

```powershell
# Exportar la función principal
Export-ModuleMember -Function Invoke-WhisperTranslator
```

Por:

```powershell
# Crear alias para la función principal
New-Alias -Name wtranslator -Value Invoke-WhisperTranslator

# Exportar la función principal y el alias
Export-ModuleMember -Function Invoke-WhisperTranslator -Alias wtranslator
```

### Pasos para aplicar la solución

1. **Remover el módulo de la sesión actual** (si estaba cargado):
   ```powershell
   Remove-Module WhisperTranslator -ErrorAction SilentlyContinue
   ```

2. **Reinstalar el módulo** con los cambios:
   ```powershell
   & "C:\Users\alexi\src\WhisperTranslator\module\Install-WhisperTranslator.ps1"
   ```

3. **Verificar que el alias funciona**:
   ```powershell
   Get-Alias wtranslator
   ```
   
   Salida esperada:
   ```
   CommandType     Name            Version    Source
   -----------     ----            -------    ------
   Alias           wtranslator -> Invoke-WhisperTranslator
   ```

4. **Probar el comando**:
   ```powershell
   wtranslator -Help
   ```

## Verificación post-solución

### Comandos para validar

```powershell
# Verificar que el módulo está cargado
Get-Module WhisperTranslator

# Verificar que el alias existe
Get-Alias wtranslator

# Verificar que el alias apunta a la función correcta
(Get-Alias wtranslator).Definition

# Probar el comando con el alias
wtranslator -Version
```

### Resultado esperado

```powershell
PS> Get-Alias wtranslator

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           wtranslator -> Invoke-WhisperTranslator

PS> wtranslator -Version
WhisperTranslator versión 0.1.0
```

## Lecciones aprendidas

1. **Declarar ≠ Implementar**: Declarar un alias en `AliasesToExport` del archivo `.psd1` no es suficiente. El alias debe ser creado y exportado explícitamente en el archivo `.psm1`.

2. **Orden correcto de operaciones**:
   - Primero: Definir funciones
   - Segundo: Crear aliases con `New-Alias`
   - Tercero: Exportar todo con `Export-ModuleMember`

3. **Testing de módulos**: Siempre verificar que los aliases funcionen después de instalar un módulo:
   ```powershell
   Get-Module NombreModulo
   Get-Alias NombreAlias
   ```

## Referencias

- [about_Aliases - Microsoft Docs](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases)
- [about_Modules - Microsoft Docs](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_modules)
- [New-Alias - Microsoft Docs](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-alias)
- [Export-ModuleMember - Microsoft Docs](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/export-modulemember)

## Archivos modificados

| Archivo | Ruta | Cambio |
|---------|------|--------|
| `WhisperTranslator.psm1` | `C:\Users\alexi\src\WhisperTranslator\module\` | Agregado `New-Alias` y actualizado `Export-ModuleMember` |

## Historial de cambios

- **2025-11-23**: Problema identificado y solucionado. Documentación creada.
