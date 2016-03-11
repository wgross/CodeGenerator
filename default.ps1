Import-Module psake
$nuget = (Get-Command nuget.exe).Path
$msbuild = (Get-Command msbuild.exe).Path
$solutionFile = (Resolve-path $PSScriptRoot\CodeGenerator.sln)

Task default -depends testpack

Task clean {
    Push-Location $PSScriptRoot/codeGenerator
    try {
        Remove-Item CodeGenerator.*.nupkg
    } finally {
        Pop-Location
    }
}

Task rebuild {
    & $msbuild $solutionFile /t:Rebuild /p:Configuration=Debug
}

Task testpack {
    Push-Location $PSScriptRoot/codeGenerator
    try {
        & $nuget pack CodeGenerator.csproj
        Copy-Item CodeGenerator.*.nupkg ..\..\packages 
        Get-Item CodeGenerator.*.nupkg
    } finally {
        Pop-Location
    }

} -depends clean,rebuild