# Código de ejemplo - Creación y exportación de aliases

## ❌ Incorrecto (Problema original)

```powershell
# WhisperTranslator.psm1

function Invoke-WhisperTranslator {
    # ... código de la función ...
}

# Solo exportar la función, sin crear el alias
Export-ModuleMember -Function Invoke-WhisperTranslator
```

**Problema**: Aunque el `.psd1` declare el alias en `AliasesToExport`, este nunca se crea.

---

## ✅ Correcto (Solución)

```powershell
# WhisperTranslator.psm1

function Invoke-WhisperTranslator {
    # ... código de la función ...
}

# Crear el alias
New-Alias -Name wtranslator -Value Invoke-WhisperTranslator

# Exportar ambos: función y alias
Export-ModuleMember -Function Invoke-WhisperTranslator -Alias wtranslator
```

---

## 📋 Patrón general para módulos con aliases

```powershell
# 1. Definir funciones
function Invoke-MiComando {
    param(...)
    # Lógica aquí
}

function Get-MiDato {
    param(...)
    # Lógica aquí
}

# 2. Crear aliases
New-Alias -Name micmd -Value Invoke-MiComando
New-Alias -Name getmi -Value Get-MiDato

# 3. Exportar todo
Export-ModuleMember -Function Invoke-MiComando, Get-MiDato -Alias micmd, getmi
```

---

## 🔧 Declaración en el manifiesto (.psd1)

Debe coincidir con lo exportado en el `.psm1`:

```powershell
@{
    RootModule = 'MiModulo.psm1'
    ModuleVersion = '1.0.0'
    # ...
    
    # Declarar funciones a exportar
    FunctionsToExport = @('Invoke-MiComando', 'Get-MiDato')
    
    # Declarar aliases a exportar
    AliasesToExport = @('micmd', 'getmi')
}
```

---

## 🧪 Código de verificación

```powershell
# Después de instalar el módulo

# Verificar módulo cargado
Get-Module MiModulo

# Verificar funciones exportadas
Get-Command -Module MiModulo -CommandType Function

# Verificar aliases exportados
Get-Command -Module MiModulo -CommandType Alias

# O específicamente
Get-Alias micmd
Get-Alias getmi

# Verificar que el alias apunta a la función correcta
(Get-Alias micmd).Definition  # Debe mostrar: Invoke-MiComando
```

---

## 💡 Mejores prácticas

### 1. Nombres consistentes
```powershell
# Función usa verbo-sustantivo
function Invoke-WhisperTranslator { }

# Alias es corto y memorable
New-Alias -Name wtranslator -Value Invoke-WhisperTranslator
```

### 2. Documentar aliases en el help
```powershell
<#
.SYNOPSIS
    Genera subtítulos SRT usando Whisper.

.DESCRIPTION
    Este comando procesa archivos de video y genera subtítulos.

.NOTES
    Alias: wtranslator
    
.EXAMPLE
    wtranslator -Directory .\videos -Model tiny
#>
function Invoke-WhisperTranslator {
    # ...
}
```

### 3. Validar en tests
```powershell
# Test simple
Describe "WhisperTranslator Module" {
    It "Should export wtranslator alias" {
        $alias = Get-Alias wtranslator -ErrorAction SilentlyContinue
        $alias | Should -Not -BeNullOrEmpty
        $alias.Definition | Should -Be "Invoke-WhisperTranslator"
    }
}
```

---

## 🚫 Errores comunes

### Error 1: Alias en .psd1 pero no en .psm1
```powershell
# .psd1
AliasesToExport = @('micmd')

# .psm1 - ❌ FALTA CREAR Y EXPORTAR
Export-ModuleMember -Function Invoke-MiComando
```

### Error 2: Crear alias pero no exportarlo
```powershell
# ❌ Se crea pero no se exporta
New-Alias -Name micmd -Value Invoke-MiComando
Export-ModuleMember -Function Invoke-MiComando  # Falta -Alias
```

### Error 3: Exportar alias que no existe
```powershell
# ❌ Se exporta pero nunca se creó
Export-ModuleMember -Function Invoke-MiComando -Alias micmd
# Falta: New-Alias -Name micmd -Value Invoke-MiComando
```

---

## 📚 Referencias

- [New-Alias](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-alias)
- [Export-ModuleMember](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/export-modulemember)
- [about_Aliases](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases)
- [about_Modules](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_modules)
