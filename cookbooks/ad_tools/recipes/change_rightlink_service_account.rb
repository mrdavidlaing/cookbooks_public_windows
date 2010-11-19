mnt_utils_service "Set RightScale RightLink service account to Local System" do
  service_name "RightScale RightLink"
  restart_service false
  action :logon_account
end

mnt_utils_service "Set RightScale Level Manager service account to Local System" do
  service_name "RightScale Level Manager"
  restart_service false
  action :logon_account
end