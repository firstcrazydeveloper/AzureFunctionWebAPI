# Register Resource Providers if they're not already registered

$resourceGroupName = "fcd-dev-webapp-abc"
$functionAppName = "fcd-dev-web-app-abc"

# Create the parameters for the file, which for this template is the function app name.
$TemplateParams = @{"appName" = $functionAppName}


Register-AzResourceProvider -ProviderNamespace "microsoft.web"
Register-AzResourceProvider -ProviderNamespace "microsoft.storage"

$checkResourceGroupName = Get-AzResource -ResourceGroupName $resourceGroupName
if($checkResourceGroupName -eq $null){
    # Create a resource group for the function app
	New-AzResourceGroup -Name "fcd-dev-webapp-new" -Location 'West Europe'
}
else{
    Write-Host "$resourceGroupName already exist"
}

$checkFunctionAppName = Get-AzResource -ResourceGroupName $resourceGroupName -ResourceName $functionAppName 
if($checkFunctionAppName -eq $null){
   # Deploy the template
New-AzResourceGroupDeployment -ResourceGroupName "fcd-dev-webapp-new" -TemplateFile azurefunctiondeploy.json -TemplateParameterObject $TemplateParams -Verbose
}
else{
    Write-Host "$functionAppName already exist"
}




