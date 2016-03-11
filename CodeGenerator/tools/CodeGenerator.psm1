function New-EntityClass {
	param(
		[string]$Name,
		[string]$FolderName = "Entities"
	)
	
	$project = Get-Project
	$projectPath = $project.Properties("FullPath").Value

	if(!(Test-Path (Join-Path $projectPath $FolderName))) {
		$project.ProjectItems.AddFolder($FolderName)
	}

	$classFilePath = (Join-Path $projectPath "$FolderName\$Name.cs")

	& (Join-Path $PSScriptRoot Templates\Class.ps1) -Name $Name | Out-File $classFilePath

	$project.ProjectItems.AddFromFile($classFilePath)
}

