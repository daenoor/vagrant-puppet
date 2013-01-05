# Class: php::composer
#
#
class php::composer {
	exec { "composer":
		command => "curl -s http://getcomposer.org/installer | php -- --install-dir=/usr/local/bin",
		require => [Package["curl"], Package["php5-cli"]],
		user => root
	}
}