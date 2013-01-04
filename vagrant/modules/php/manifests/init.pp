# Class: php
#
#
class php {
	$phpini = "/etc/php5/cli/php.ini"
  	$phpinidir = "/etc/php5/conf.d/"

  	package { "php5-cli":
  		ensure => latest,
  		require => Exec["apt-get update"],
  	}

  	package { "php-pear":
  		ensure => latest,
  		require => Package["php5-cli"],
  	}

  	php::module { "xdebug": 
  		ensure => "present",
  		before => File["xdebug config"],
  	}


  	if defined(Package['apache']) {
		file { "xdebug config":
			ensure => file,
			path => "${phpinidir}xdebug.ini",
			source => 'puppet:///modules/php/xdebug.ini',
			require => Package['php5-cli'],
			notify => Service['apache']
		}
  	}
  	else {
		file { "xdebug config":
			ensure => file,
			path => "${phpinidir}xdebug.ini",
			source => 'puppet:///modules/php/xdebug.ini',
			require => Package['php5-cli'],
		}
  	}
}