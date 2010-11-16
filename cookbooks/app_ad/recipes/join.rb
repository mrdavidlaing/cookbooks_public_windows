# app_ad::join

# 1. Retrieve inputs
domain   = node[:ad][:domain]
admin_username = node[:ad][:admin_username]
admin_password = node[:ad][:admin_password]

log "domain:         #{domain}"
log "admin username: #{admin_username}"

# 2. Set DNS Server to be DC
app_ad_dns_server domain do
  action :set
end

## 3. Join domain
app_ad_active_directory domain do
  admin_username admin_username
  admin_password admin_password
  action :join
end

right_link_tag "ad:member=#{node[:ad][:domain]}"