description      "ActiveDirectory recipes"
version          "0.0.1"

recipe "app_ad::add_user", "Creates a new Active Directory user account, must be run on Domain Controller"
recipe "app_ad::remote_add_user", "Creates a new Active Directory user account, can be run anywhere"
recipe "app_ad::join", "Join instance to domain"
recipe "app_ad::set_dns_server", "Set DNS server entries"
recipe "app_ad::setup_controller", "Sets up domain controller tag"

attribute "ad/domain",
  :display_name => "Domain name",
  :description  => "Active Directory domain name",
  :recipes      => ["app_ad::add_user", "app_ad::remote_add_user", "app_ad::join"],
  :required     => "required"

attribute "ad/user_username",
  :display_name => "Application username",
  :description  => "New Active Directory domain account username",
  :recipes      => ["app_ad::add_user", "app_ad::remote_add_user"],
  :required     => "required"

attribute "ad/user_password",
  :display_name => "Application password",
  :description  => "New Active Directory domain account password",
  :recipes      => ["app_ad::add_user", "app_ad::remote_add_user"],
  :required     => "required"

attribute "ad/admin_username",
  :display_name => "Domain administrator username",
  :description  => "Username of domain account used to add computers to domain",
  :recipes      => ["app_ad::join"],
  :required     => "required"

attribute "ad/admin_password",
  :display_name => "Domain administrator password",
  :description  => "Password of domain account used to add computers to the domain",
  :recipes      => ["app_ad::join"],
  :required     => "required"


