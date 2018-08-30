#Configuration Settings 

$DatabaseServer = "Server"

$ConfigDatabase = "ConfigDB"

$AdminContentDB = "CAContentDB"

$Passphrase = "FarmPassPhrase"

$FarmAccountName = "Domain\FarmAccount"

$ServerRole="MinRole"

 

#Get the Farm Account Credentials

$FarmAccount = Get-Credential $FarmAccountName

$Passphrase = (ConvertTo-SecureString $Passphrase -AsPlainText -force)

   

#Create SharePoint Farm

Write-Host "Creating Configuration Database and Central Admin Content Database..."

New-SPConfigurationDatabase -DatabaseServer $DatabaseServer -DatabaseName $ConfigDatabase -AdministrationContentDatabaseName $AdminContentDB -Passphrase $Passphrase -FarmCredentials $FarmAccount -LocalServerRole $ServerRole

 

$Farm = Get-SPFarm -ErrorAction SilentlyContinue -ErrorVariable err  

if ($Farm -ne $null) 

{

Write-Host "Installing SharePoint Resources..."

Initialize-SPResourceSecurity

  

Write-Host "Installing Farm Services ..."

Install-SPService

  

Write-Host "Installing SharePoint Features..."

Install-SPFeature -AllExistingFeatures

  

Write-Host "Creating Central Administration..."             

New-SPCentralAdministration -Port 2016 -WindowsAuthProvider NTLM

   

Write-Host "Installing Help..."

Install-SPHelpCollection -All 

  

Write-Host "Installing Application Content..."

Install-SPApplicationContent

   

Write-Host "SharePoint 2016 Farm Created Successfully!"

}
