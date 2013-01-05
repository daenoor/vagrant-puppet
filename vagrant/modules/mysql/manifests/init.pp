# Class: mysql
#
#
class mysql  (
  $package_ensure   = 'present',
  $config_hash      = {},
  $enabled          = true,
  $manage_service   = true
) {
	Class['mysql'] -> Class['mysql::config']

  	$config_class = { 'mysql::config' => $config_hash }

	create_resources( 'class', $config_class ) 

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
