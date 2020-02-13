# Register Resource Providers if they're not already registered

$resourceGroupName = "fcd-dev-function"
$functionAppName = "fcd-dev-web-app"

# Create the parameters for the file, which for this template is the function app name.
$TemplateParams = @{"appName" = $functionAppName}


az provider register --namespace "microsoft.web"
az provider register --namespace "microsoft.storage"

$resourceExist = az group exists -n $resourceGroupName

if($resourceExist -eq $true){
    # Create a resource group for the function app
	Write-Host "resources exist"
}
else{    
	Write-Host "resources not exist"
	az group create -n $resourceGroupName -l 'West Europe'
}

$checkFunctionAppName = az functionapp show -g $resourceGroupName -n $functionAppName 
if($checkFunctionAppName -eq $null){
   # Deploy the template
   Write-Host "function not exist"
	az group deployment create --resource-group $resourceGroupName --template-file azurefunctiondeploy.json --parameters appName=$functionAppName --verbose
	
}
else{
    Write-Host "function exist"
}