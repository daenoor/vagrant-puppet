class php::apache inherits php{

	package { "apache php module":
		name => "libapache2-mod-php5",
		ensure => present,
		require => Package['php5-cli'],
	}

	file { "${phpinidir}01-settings.ini":
		ensure => file,
		source => 'puppet:///modules/php/01-settings.ini',
		require => Package['php5-cli'],
		notify => Service['apache']
	}

} 