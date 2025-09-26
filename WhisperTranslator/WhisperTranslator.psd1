@{
    RootModule = 'WhisperTranslator.psm1'
    ModuleVersion = '0.1.0'
    GUID = '1234567-1234-1234-1234-123456789012' # Un GUID único para tu módulo
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