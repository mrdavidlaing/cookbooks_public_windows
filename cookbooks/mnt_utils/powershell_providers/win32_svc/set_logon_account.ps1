$service_name = Get-NewResource service_name
$service_account_user = Get-NewResource service_account_user
$service_account_pass = Get-NewResource service_account_pass
$restart_service = Get-NewResource restart_service

$computer = get-content env:computername

# TODO: Need to make this smarter so I can use the local admin or AD admin depending on the circumstances
$Password = Get-ChefNode utilities, admin_password

Write-Output("This is super naughty, but the password is $Password")

$Password = ConvertTo-SecureString $Password -AsPlainText -Force

$UserName = ".\Administrator"
$Cred = New-Object System.Management.Automation.PSCredential $UserName, $Password

Write-Output("Service name is $service_name")
Write-Output("restart service is $restart_service")

# If service account user & pass are blank, we set it to $null, meaning that the Local System account will be used
if ( ($service_account_user -eq "") -and ($service_account_pass -eq "") ) {
  $service_account_user = $null
  $service_account_pass = $null
}

Write-Output("Past the conditional statement")

$service="name='$service_name'"

Write-Output("The service WMI search is $service")

$svc=Get-WmiObject win32_service -computer $computer -cred $Cred -filter $service

Write-Output("Service object is $svc")

#if ($restart_service.ToLower() -eq "true") { $svc.StopService() }
if ($svc) {
  $svc.change($null,$null,$null,$null,$null,$null,$account,$password,$null,$null,$null)
}
else { Write-Output("I no can getting the svc") }
#if ($restart_service.ToLower() -eq "true") { $svc.StartService() }