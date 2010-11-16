actions [:add_user, :join]

attribute :domain,         :kind_of => [ String ], :regex => /^[a-z0-9][a-z0-9\-\.]*$/i, :required => true, :name_attribute => true
attribute :user_username,  :kind_of => [ String ]
attribute :user_password,  :kind_of => [ String ]
attribute :admin_username, :kind_of => [ String ]
attribute :admin_password, :kind_of => [ String ]


