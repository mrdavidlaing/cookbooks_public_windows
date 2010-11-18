maintainer "Ryan J. Geyer"
maintainer_email "rgeyer@its.jnj.com"
description "Microsoft SQL 2008 Enterprise Bits"
long_description "Microsoft SQL 2008 Enterprise Bits"
name "db_mssql"
version "0.0.1"


recipe "db_mssql::default", "Runs db_mssql::install"
recipe "db_mssql::install", "Installs Microsoft SQL 2008 Enterprise Server with specified options"

attribute "db_mssql/security_mode",
          :display_name => "What type of logins the server will accept.  Only Active Directory logins if set to 'Windows', mixed mode if set to 'SQL'",
          :description => "What type of logins the server will accept.  Only Active Directory logins if set to 'Windows', mixed mode if set to 'SQL'",
          :recipes => [
            "db_mssql::default",
            "db_mssql::install"
          ],
          :choice => [
            "Windows",
            "SQL"
          ],
          :required => "required"