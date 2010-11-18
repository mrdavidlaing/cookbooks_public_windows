# TODO: When a machine becomes a domain controller, local users and groups are destroyed/ignored
# Need to get rightlink setup with the correct credentials to be able to continue running
# RightLink service - Needs AD service account?

ntds_dir = "C:\\Windows\\NTDS"

log "Hostname Set is #{@node[:mnt_utils_hostname_set]}"
log "DNS Set is #{@node[:mnt_utils_dns_set]}"
log "Default ad_bdc_init is #{default[:ad_bdc_initialized]}"
log "Should run this script is #{@node[:mnt_utils_hostname_set] && @node[:mnt_utils_dns_set]}"

if(@node[:mnt_utils_hostname_set] && @node[:mnt_utils_dns_set] && !File.directory?(ntds_dir))
  log "Entered if other scripts run"
  answers_file = "C:\\answers.txt"

  template answers_file do
    source "answers_bdc.txt.erb"
  end
#
#  ad_tools_ad "Promote Server To BDC" do
#    :unattended_dcpromo
#  end

#  powershell "Promote BDC" do
#    powershell_script = <<'POWERSHELL_SCRIPT'
#    start-process -FilePath "$env:windir\Sysnative\dcpromo.exe" -ArgumentList /answer:C:\answers.txt -Wait
#
#    del "C:\answers.txt"
#POWERSHELL_SCRIPT
#
#    source(powershell_script)
#  end

  right_link_tag "ad:domain=#{@node[:ad_tools][:domain_name]}"
  right_link_tag "ad:role=bdc"

  #default[:ad_bdc_initialized] = true

  #@node[:ad_tools_is_bdc] = true
end