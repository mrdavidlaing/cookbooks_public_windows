# app_ad::join

# 1. Retrieve inputs
domain   = node[:ad_tools][:admin_domain]
admin_username = node[:ad_tools][:admin_user]
admin_password = node[:ad_tools][:admin_pass]

log "domain:         #{domain}"
log "admin username: #{admin_username}"

# 2. Set DNS Server to be DC
app_ad_dns_server domain do
  action :set
end

## 3. Join domain
ad_tools_ad domain do
  admin_user admin_username
  admin_pass admin_password
  action :join_domain
end

right_link_tag "ad:domain=#{@node[:ad_tools][:domain_name]}"
right_link_tag "ad:role=member"