# Class: mysql
#
#
class mysql (
    $mysql_db = ""      
){
	$dbuser = 'vagrant'
	$dbpass = 'vagrant'
	
	$dbname = $mysql_db ? {
		"" => "site_db",
		default => "${mysql_db}",
	}

	package { "mysql-server":
    	ensure => installed,
    	require => Exec["apt-get update"],
  	} 

  	service { "mysql":
    	ensure => running,
    	enable => true,
    	name => "mysql",
	    require => Package["mysql-server"],
  	}
}
