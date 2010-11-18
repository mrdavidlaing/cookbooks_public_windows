# TODO: When a machine becomes a domain controller, local users and groups are destroyed/ignored
# Need to get rightlink setup with the correct credentials to be able to continue running
# RightLink service - Needs AD service account?

ntds_dir = "C:\\Windows\\NTDS"

log "Hostname Set is #{@node[:mnt_utils_hostname_set]}"
log "DNS Set is #{@node[:mnt_utils_dns_set]}"
log "NTDS exists is #{default[:ad_bdc_initialized]}"
log "Should run this script is #{@node[:mnt_utils_hostname_set] && @node[:mnt_utils_dns_set] && !default[:ad_bdc_initialized]}"

if(@node[:mnt_utils_hostname_set] && @node[:mnt_utils_dns_set] && !default[:ad_bdc_initialized] )
  log "Entered if other scripts run"
  template "C:\\answers.txt" do
    source "answers_bdc.txt.erb"
  end

  ad_tools_ad "Runs DC Promo" do
    action :unattended_dcpromo
  end

  right_link_tag "ad:domain=#{@node[:ad_tools][:domain_name]}"
  right_link_tag "ad:role=bdc"

  #@node[:ad_tools_is_bdc] = true
  default[:ad_bdc_initialized] = false
end