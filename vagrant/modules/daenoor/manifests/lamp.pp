# Class: daenoor::lamp
#
#
class daenoor::lamp {
   
    # Apache
    class { 'apache':
    }
  
    apache::module { 'headers': }
    apache::module { 'rewrite': }

    # Mysql
    class { 'mysql':
        root_password => 'auto',
    }

    mysql::grant { 'app_db':
        mysql_privileges => 'ALL',
        mysql_password => 'myapp',
        mysql_db => 'app_db',
        mysql_user => 'myapp',
        mysql_host => 'localhost',
    }

    # php
    class { 'php': }

    php::module { "xdebug": }
}