# Class: php::composer
#
#
class php::composer {
	exec { "composer":
		command => "curl -s https://getcomposer.org/installer | php -- --install-dir=bin",
		require => [Package["curl"], Package["php5-cli"]],
		user => root
	}
}