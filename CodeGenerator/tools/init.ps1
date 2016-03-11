#
# init.ps1
#
param ($installPath, $toolsPath, $package, $project)

if (Get-Module | ? Name -eq CodeGenerator) {
    Remove-Module CodeGenerator
}

Import-Module (Join-Path $PSScriptRoot CodeGenerator.psd1) -DisableNameChecking
