mnt_utils_win32_svc "Set RightScale RightLink service account to Local System" do
  service_name "RightScale RightLink"
  restart_service "false"
  action :set_logon_account
end

mnt_utils_win32_svc "Set RightScale Level Manager service account to Local System" do
  service_name "RightScale Level Manager"
  restart_service "false"
  action :set_logon_account
end