log "Fixin' to set the DNS to " + @node[:mnt_utils][:dns_list]

powershell "Sets the DNS search list to the provided CSV list" do
  parameters({'DNS_LIST' => @node[:mnt_utils][:dns_list]})

  powershell_script = <<'POWERSHELL_SCRIPT'
  $NICs = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=TRUE"
  foreach($NIC in $NICs) {
    # We keep the last one in the list since that's the one Ec2 gave us and we don't wanna nuke it
    [array]$dnsAry = @($NIC.DNSServerSearchOrder[-1])
    $dnsAry = $env:DNS_LIST.split(',') + $dnsAry 
    $NIC.SetDNSServerSearchOrder($dnsAry)
  }
POWERSHELL_SCRIPT

  source(powershell_script)
end

@node[:mnt_utils_dns_set] = true