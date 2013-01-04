# Class: apache
#
#
class apache {
	package { "apache":
		name => "apache2",
		ensure => latest,
		require => Exec["apt-get update"],
	}

	service { "apache":
		name => "apache2",
	    enable => true,
		ensure => running,
		hasrestart => true,
		#hasstatus => true,
		require => Package["apache"],
	}

	apache::module { "rewrite":
		ensure => "present",
	}
}