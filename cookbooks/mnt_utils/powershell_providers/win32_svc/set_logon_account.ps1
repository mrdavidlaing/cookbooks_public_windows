$service_name = Get-NewResource service_name
$service_account_user = Get-NewResource service_account_user
$service_account_pass = Get-NewResource service_account_pass
$restart_service = Get-NewResource restart_service

# If service account user & pass are blank, we set it to $null, meaning that the Local System account will be used
if ( $service_account_user == "" && $service_account_pass = "" ) {
  $service_account_user = $null
  $service_account_pass = $null
}

$service="name='$service_name'"

$svc=gwmi win32_service -filter $service
if ($restart_service.ToLower() == "true") { $svc.StopService() }
$svc.change($null,$null,$null,$null,$null,$null,$account,$password,$null,$null,$null)
if ($restart_service.ToLower() == "true") { $svc.StartService() }