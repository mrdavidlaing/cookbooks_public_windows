# TODO: When a machine becomes a domain controller, local users and groups are destroyed/ignored
# Need to get rightlink setup with the correct credentials to be able to continue running
# RightLink service - Needs AD service account?

ntds_dir = "C:\\Windows\\NTDS"

log "Hostname Set is #{@node[:mnt_utils_hostname_set]}"
log "DNS Set is #{@node[:mnt_utils_dns_set]}"
#log "NTDS exists is #{File.directory? ntds_dir}"
log "Should run this script is #{@node[:mnt_utils_hostname_set] && @node[:mnt_utils_dns_set] && !File.directory?(ntds_dir)}"

if(@node[:mnt_utils_hostname_set] && @node[:mnt_utils_dns_set] && !File.directory?(ntds_dir) )
  log "Entered if other scripts run"

  ad_tools_init_bdc "Create answers file, run dcpromo with it, then delete it" do
    admin_user @node[:ad_tools][:admin_user]
    admin_domain @node[:ad_tools][:admin_domain]
    admin_pass @node[:ad_tools][:admin_pass]
    domain_name @node[:ad_tools][:domain_name]
    action :bdc
  end

  right_link_tag "ad:bdc=#{@node[:ad_tools][:domain_name]}"

  #@node[:ad_tools_is_bdc] = true

  # We're going to let DCPromo issue the reboot request
  # include_recipe 'utilities::system_reboot'
end