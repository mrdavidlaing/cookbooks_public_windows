log "Hostname Set is #{@node[:mnt_utils_hostname_set]}"
log "DNS Set is #{@node[:mnt_utils_dns_set]}"
log "BDC Init is #{@node[:ad_tools_bdc_initialized]}"
log "Should run this script is #{@node[:mnt_utils_hostname_set] && @node[:mnt_utils_dns_set]}"

unless @node[:ad_tools_bdc_initialized]
  if(@node[:mnt_utils_hostname_set] && @node[:mnt_utils_dns_set])
    
    ad_tools_init_bdc "Create answers file, run dcpromo with it, then delete it" do
      admin_user @node[:ad_tools][:admin_user]
      admin_domain @node[:ad_tools][:admin_domain]
      admin_pass @node[:ad_tools][:admin_pass]
      domain_name @node[:ad_tools][:domain_name]
      action :bdc
    end

    right_link_tag "ad:bdc=#{@node[:ad_tools][:domain_name]}"

    @node[:ad_tools_bdc_initialized] = true

    # We're going to let DCPromo issue the reboot request
    # include_recipe 'utilities::system_reboot'
  end
end