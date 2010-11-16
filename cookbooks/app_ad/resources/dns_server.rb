actions :set

attribute :domain, :kind_of => [ String ], :regex => /^[a-z0-9][a-z0-9\-\.]*$/i, :required => true, :name_attribute => true

