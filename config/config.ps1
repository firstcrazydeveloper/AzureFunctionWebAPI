# Register Resource Providers if they're not already registered
$userId = "sahil.abhishek777@hotmail.com"
$passwd = ConvertTo-SecureString Abhinutan2018 -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential($userId ,$passwd)
$resourceGroupName = "fcd-dev-webapp-abc"
$functionAppName = "fcd-dev-web-app-abc"

# Create the parameters for the file, which for this template is the function app name.
$TemplateParams = @{"appName" = $functionAppName}

Login-AzAccount -Credential $cred -TenantId "09abbc86-84ed-4481-83a3-4dc0f095d0b9"
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




