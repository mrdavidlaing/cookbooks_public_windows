# Handy DCPROMO answer file templates http://support.microsoft.com/kb/947034

powershell "Demote AD" do
  parameters({
    'ADMIN_USER' => @node[:ad_tools][:admin_user],
    'ADMIN_DOMAIN' => @node[:ad_tools][:admin_domain],
    'ADMIN_PASS' => @node[:ad_tools][:admin_pass]
    })

  powershell_script = <<'POWERSHELL_SCRIPT'
  $ansStream = [System.IO.StreamWriter] "C:\answers.txt"

  $ansStream.WriteLine("[DCINSTALL]")
  $ansStream.WriteLine("UserName=$env:ADMIN_USER")
  $ansStream.WriteLine("UserDomain=$env:ADMIN_DOMAIN")
  $ansStream.WriteLine("Password=$env:ADMIN_PASS")
  # TODO: This should really be a discreet input
  $ansStream.WriteLine("AdministratorPassword=$env:ADMIN_PASS")
  $ansStream.WriteLine("RemoveApplicationPartitions=yes")
  $ansStream.WriteLine("RemoveDNSDelegation=yes")
  # TODO: These should really be discreet inputs
  $ansStream.WriteLine("DNSDelegationUserName=$env:ADMIN_USER")
  $ansStream.WriteLine("DNSDelegationPassword=$env:ADMIN_PASS")
  $ansStream.WriteLine("RebootOnCompletion=No")
  $ansStream.close()

  start-process -FilePath "$env:windir\Sysnative\dcpromo.exe" -ArgumentList /answer:C:\answers.txt

  del "C:\answers.txt"
POWERSHELL_SCRIPT

  source(powershell_script)
end