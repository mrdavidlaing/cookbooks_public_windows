# app_add::add_user
domain   = node[:ad][:domain]
username = node[:ad][:user_username]
password = node[:ad][:user_password]

log "domain:   #{domain}"
log "username: #{username}"

app_ad_active_directory domain do
  user_username username
  user_password password
  action :add_user
end
