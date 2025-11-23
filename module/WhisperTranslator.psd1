@{
    RootModule = 'WhisperTranslator.psm1'
    ModuleVersion = '0.1.0'
    GUID = 'a1b2c3d4-e5f6-47a8-b9c0-d1e2f3a4b5c6'
    Author = 'amillanaol'
    Description = 'Módulo para generar subtítulos SRT a partir de archivos de video usando Whisper'
    PowerShellVersion = '5.1'
    FunctionsToExport = @('Invoke-WhisperTranslator')
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            Tags = @('Whisper', 'Subtitles', 'SRT', 'Video', 'Transcription')
            ProjectUri = 'https://github.com/amillanaol/WhisperTraductor'
        }
    }
}