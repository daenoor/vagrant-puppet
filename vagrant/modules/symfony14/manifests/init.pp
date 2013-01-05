# Class: symfony14
#
#
class symfony14(
	$targetdir = '/vagrant'
) {
	php::pear::package{ "symfony":
		repository => "pear.symfony-project.com",
	}

	file { "symfony vhost":
		ensure => file,
		path => "/etc/apache2/sites-available/symfony.lo",
		content => template('symfony14/symfony.lo.erb')
	}

	apache::site{ "default":
		ensure => absent,
	}

	apache::site{ "symfony.lo":
		ensure => present,
		require => File["symfony vhost"],
	}
}