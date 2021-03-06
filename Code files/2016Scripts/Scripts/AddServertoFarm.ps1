$ServerRole="Application"

#"Custom","WebFrontEnd","Application","DistributedCache","SingleServerFarm","Search","ApplicationWithSearch","WebFrontEndWithDistributedCache"

 

Connect-SPConfigurationDatabase -DatabaseServer $DBServer -DatabaseName $DBName -PassPhrase $Passphrase -LocalServerRole $ServerRole

  

Write-Host "Installing SharePoint Resources..."

Initialize-SPResourceSecurity

  

Write-Host "Installing Farm Services ..."

Install-SPService

  

Write-Host "Installing SharePoint Features..."

Install-SPFeature -AllExistingFeatures

  

Write-Host "Installing Help..."

Install-SPHelpCollection -All 

  

Write-Host "Installing Application Content..."

Install-SPApplicationContent

   

Write-Host "Joined the Server to Farm Successfully!"
