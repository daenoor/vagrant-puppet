# Class: mysql
#
#
class mysql {
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
