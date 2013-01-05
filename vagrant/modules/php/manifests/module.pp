define php::module ($ensure="present") {

	$phpprefix = "php5-"

  	if defined(Package['apache']) {
	    package { "${phpprefix}${name}":
	      ensure => $ensure,
	      notify => Service["apache"],
	      require => Exec["apt-get update"],
	    }
  	}
  	else {
	    package { "${phpprefix}${name}":
	      ensure => $ensure,
	      require => Exec["apt-get update"],
	    }
  	}

} 