# app_ad::add_user

# 1. Retrieve inputs
$Domain   = Get-ChefNode ad, domain
$UserName = Get-ChefNode ad, user_username
$Password = Get-ChefNode ad, user_password

# 2. Create user
Write-Host "Creating Account for User $userName"
$Domain = $Domain.Split('.')
$Domain = [string]::join(", DC=", $Domain)
$container = [ADSI] "LDAP://CN=Users,DC=$Domain"
$newUser = $container.Create("User", "CN=" + $UserName)
$newUser.Put("sAMAccountName", $UserName)
$newUser.SetInfo()
$newUser.SetPassword($Password)
$newUser.psbase.InvokeSet('AccountDisabled', $false)
$newUser.SetInfo()

# 3. Add user to 'Remote Desktop Users' group
$remoteUsers = [ADSI] "LDAP://CN=Remote Desktop Users, CN=Builtin, DC=$Domain"
$remoteUsers.add($newUser.psbase.Path)

