# ActiveDirectoryProvider#join
$Domain   = Get-ChefNode ad_tools, admin_domain
$UserName = Get-ChefNode ad_tools, admin_user
$Password = Get-ChefNode ad_tools, admin_pass
$Password = ConvertTo-SecureString $Password -AsPlainText -Force

$UserName = "$Domain\$UserName"
$Cred = New-Object System.Management.Automation.PSCredential $UserName, $Password
Add-Computer -credential $Cred -DomainName $Domain