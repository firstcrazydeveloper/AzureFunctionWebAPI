param(
  [Parameter(Mandatory = $true)][String]$templateLocation,
  [Parameter(Mandatory = $false)][String]$resourceGroupName = "fcd-dev-function",
  [Parameter(Mandatory = $false)][String]$functionAppName = "centralus"
  [Parameter(Mandatory = $false)][String]$location = "centralus"
  
)

# Create the parameters for the file, which for this template is the function app name.
# $TemplateParams = @{"appName" = $functionAppName}

# Register Resource Providers if they're not already registered
az provider register --namespace "microsoft.web"
az provider register --namespace "microsoft.storage"

$resourceExist = az group exists -n $resourceGroupName

if($resourceExist -eq $true){
    # Create a resource group for the function app
	Write-Host "resources exist"
}
else{    
	Write-Host "resources not exist"
	az group create -n $resourceGroupName -l $location
}

$checkFunctionAppName = az functionapp show -g $resourceGroupName -n $functionAppName 
if($checkFunctionAppName -eq $null){
   # Deploy the template
   Write-Host "function not exist"
	az group deployment create --resource-group $resourceGroupName --template-file $templateLocation --parameters appName=$functionAppName --verbose
	
}
else{
    Write-Host "function exist"
}