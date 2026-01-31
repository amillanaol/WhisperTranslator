# Variable para almacenar la versión del módulo
$script:Version = "1.2.3"

function Invoke-WhisperTranslator {
    param (
        [Parameter(Mandatory=$false,Position=0)]
        [Alias("d")]
        [string]$Directory = (Join-Path (Get-Location).Path "inputs"),
        
        [Parameter(Mandatory=$false,Position=1)]
        [Alias("m")]
        [ValidateSet("base", "tiny", "small", "medium", "turbo")]
        [string]$Model = "tiny",

        [Parameter(Mandatory=$false,Position=2)]
        [Alias("e")]
        [ValidateSet("mp4", "mkv", "webm")]
        [string]$Extension = "mp4",

        [Parameter(Mandatory=$false)]
        [Alias("v")]
        [switch]$Version,

        [Parameter(Mandatory=$false)]
        [switch]$Help
    )

    if ($Version) {
        Write-Host "WhisperTranslator versión $script:Version"
        return
    }

    if ($Help) {
        Write-Host "Uso: Invoke-WhisperTranslator [-Directory|-d <ruta>] [-Model|-m <modelo>] [-Extension|-e <extensión>] [-Version|-v] [-Help]"
        Write-Host ""
        Write-Host "Descripción:"
        Write-Host "    Este comando procesa archivos de video en un directorio y genera subtítulos SRT usando Whisper."
        Write-Host ""
        Write-Host "Parámetros:"
        Write-Host "    -Directory, -d    Ruta al directorio que contiene los archivos de video"
        Write-Host "                     (por defecto: /inputs)"
        Write-Host "    -Model, -m       Modelo de Whisper a utilizar"
        Write-Host "                     Valores permitidos: base, tiny, small, medium, turbo"
        Write-Host "                     (por defecto: tiny)"
        Write-Host "    -Extension, -e   Extensión de los archivos a procesar"
        Write-Host "                     Valores permitidos: mp4, mkv, webm"
        Write-Host "                     (por defecto: mp4)"
        Write-Host "    -Version, -v     Muestra la versión actual del módulo"
        Write-Host "    -Help            Muestra este mensaje de ayuda"
        Write-Host ""
        Write-Host "Ejemplo:"
        Write-Host "    Invoke-WhisperTranslator -Directory '.\inputs' -e 'mp4' -Model 'tiny'"
        return
    }

    if (-not (Test-Path -Path $Directory)) {
        Write-Host "Error: El directorio especificado no existe: $Directory"
        Write-Host "Use -Help para ver las instrucciones de uso"
        return 1
    }

    Test-VideoFileExists -Path $Directory -Extension $Extension
    Test-SrtFileExists -Path $Directory
    Invoke-VideoFiles -Path $Directory -Extension $Extension
}

function Test-VideoFileExists {
    param (
        [string]$Path,
        [string]$Extension
    )
    $videoFiles = Get-ChildItem -Path $Path -Recurse -Filter "*.$Extension" -ErrorAction SilentlyContinue
    return $videoFiles.Count -gt 0
}

function Test-SrtFileExists {
    param (
        [string]$Path
    )
    $srtFiles = Get-ChildItem -Path $Path -Recurse -Filter *.srt -ErrorAction SilentlyContinue
    return $srtFiles.Count -gt 0
}

function Invoke-VideoFiles {
    param (
        [string]$Path,
        [string]$Extension
    )
    
    $videoFiles = Get-ChildItem -Path $Path -Recurse -Filter "*.$Extension" -ErrorAction SilentlyContinue
    
    foreach ($videoFile in $videoFiles) {
        $srtFile = Join-Path -Path $videoFile.DirectoryName -ChildPath ($videoFile.BaseName + ".srt")
        
        if (-not (Test-Path -Path $srtFile)) {
            Write-Host "No se encontró un archivo .srt para el archivo: $($videoFile.FullName)"
            Write-Host ""
            Write-Host "Generando transcripción para: $($videoFile.DirectoryName)\$($videoFile.Name)"
            Write-Host ""
            Write-Host "Transcribiendo el archivo '$($videoFile.Name)' usando el modelo: '$Model'."
            Write-Host ""
            whisper "$($videoFile.FullName)" --fp16=False --language Spanish --model $Model --output_format srt --output_dir "$($videoFile.DirectoryName)"
            # Transcripción completada
            Write-Host "Transcripción completada para: $($videoFile.Name)"
            Write-Host ""
            Write-Host "Transcripción guardada en: $($videoFile.DirectoryName)"
        } else {
            Write-Host ""
            Write-Host "El archivo $($videoFile.Name) ya tiene un archivo .srt asociado".
            Write-Host ""
        }
    }
}

# Crear alias para la función principal
New-Alias -Name wtranslator -Value Invoke-WhisperTranslator

# Exportar la función principal y el alias
Export-ModuleMember -Function Invoke-WhisperTranslator -Alias wtranslator