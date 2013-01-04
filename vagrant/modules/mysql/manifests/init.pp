# Class: mysql
#
#
class mysql {
	$dbuser = 'vagrant'
	$dbpass = 'vagrant'
	
	$dbname = $mysql_db ? {
		"" => 'site_db',
		"default" => $mysql_db
	}

	package { "mysql-server":
    	ensure => installed,
  	} 

  	service { "mysql":
    	ensure => running,
    	enable => true,
    	name => "mysql",
	    require => Package["mysql-server"],
  	}
}
