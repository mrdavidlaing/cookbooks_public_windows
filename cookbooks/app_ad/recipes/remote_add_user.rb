# app_ad::remote_add_user

# 1. Retrieve inputs
domain   = node[:ad][:domain]
username = node[:ad][:user_username]
password = node[:ad][:user_password]

log "domain:   #{domain}"
log "username: #{username}"

# 2. Send remote recipe to add user
remote_recipe 'add user' do
  recipe 'app_ad::add_user'
  attributes({:ad => { :domain        => domain, 
                       :user_username => username,
                       :user_password => password }})
  recipients_tags 'provides:ad_role=controller'
end

