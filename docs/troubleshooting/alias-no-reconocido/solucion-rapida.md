# Guía rápida: Error alias no reconocido

## 🔴 Síntoma
```powershell
wtranslator : The term 'wtranslator' is not recognized...
```

## ✅ Solución rápida

### 1. Verificar el problema
```powershell
Get-Module -ListAvailable WhisperTranslator  # ¿Módulo instalado?
Get-Alias wtranslator                        # ¿Alias existe?
```

### 2. Aplicar el fix

El módulo debe crear y exportar el alias. Edita `WhisperTranslator.psm1`:

```powershell
# Al final del archivo, reemplaza:
Export-ModuleMember -Function Invoke-WhisperTranslator

# Por:
New-Alias -Name wtranslator -Value Invoke-WhisperTranslator
Export-ModuleMember -Function Invoke-WhisperTranslator -Alias wtranslator
```

### 3. Reinstalar

```powershell
Remove-Module WhisperTranslator -ErrorAction SilentlyContinue
& "C:\Users\alexi\src\WhisperTranslator\module\Install-WhisperTranslator.ps1"
```

### 4. Verificar

```powershell
Get-Alias wtranslator
wtranslator -Version
```

## 📝 Causa

El archivo `.psd1` declaraba el alias en `AliasesToExport`, pero el archivo `.psm1` nunca lo creaba con `New-Alias` ni lo exportaba con `Export-ModuleMember`.

## 📚 Más información

Ver: `diagnostico-y-solucion.md` para documentación completa.
