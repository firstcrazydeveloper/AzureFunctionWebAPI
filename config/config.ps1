# Register Resource Providers if they're not already registered

$resourceGroupName = "fcd-dev-webapp-abc-old"
$functionAppName = "fcd-dev-web-app-abc-old"

# Create the parameters for the file, which for this template is the function app name.
$TemplateParams = @{"appName" = $functionAppName}


az provider register --namespace "microsoft.web"
az provider register --namespace "microsoft.storage"

$checkResourceGroupName = az resource show -g $resourceGroupName
if($checkResourceGroupName -eq $null){
    # Create a resource group for the function app
	az group create -n "fcd-dev-webapp-new" -l 'West Europe'
}
else{
    Write-Host "$resourceGroupName already exist"
}

$checkFunctionAppName = az resource show -g $resourceGroupName -n $functionAppName 
if($checkFunctionAppName -eq $null){
   # Deploy the template
az group deployment create -g @resourceGroupName --template-file azurefunctiondeploy.json --parameters $TemplateParams
}
else{
    Write-Host "$functionAppName already exist"
}




