$service_name = Get-NewResource service_name
$service_account_user = Get-NewResource service_account_user
$service_account_pass = Get-NewResource service_account_pass
$restart_service = Get-NewResource restart_service

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

$svc=Get-WmiObject win32_service -filter $service

#if ($restart_service.ToLower() -eq "true") { $svc.StopService() }
$svc.change($null,$null,$null,$null,$null,$null,$account,$password,$null,$null,$null)
#if ($restart_service.ToLower() -eq "true") { $svc.StartService() }