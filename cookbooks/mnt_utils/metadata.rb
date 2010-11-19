maintainer "Ryan J. Geyer"
maintainer_email "rgeyer@its.jnj.com"
description "Random useful bits of code"
long_description "Random useful bits of code"
name "mnt_utils"
version "0.0.1"

depends "utilities"

recipe "mnt_utils::default", "Just for experimentation right now"
recipe "mnt_utils::set_dns", "Sets the DNS search list ot the provided CSV list"
recipe "mnt_utils::set_hostname", "Sets the system's hostname to match the nickname in the RightScale dashboard"
recipe "mnt_utils::install_bginfo", "Installs the BGInfo tool and sets it to run on each user login"
recipe "mnt_utils::helloworld", "A recipe which should always work, used as a control test"

attribute "mnt_utils/dns_list",
          :display_name => "A comma separated list of IPV4 addresses of DNS servers",
          :description => "A comma separated list of IPV4 addresses of DNS servers",
          :recipes => [ "mnt_utils::set_dns" ],
          :required => "required"

attribute "mnt_utils/rs_server_name",
          :display_name => "RightScale dashboard nickname",
          :description => "The RightScale dashboard nickname, this should be set to ENV:RS_SERVER_NAME",
          :recipes => [ "mnt_utils::set_hostname" ],
          :required => "required"