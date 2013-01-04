define apache::module ($ensure='present') {
	$a2enmod_deps = Package["apache"]

	case $ensure {
		"present": {
			exec { "a2enmod ${name}":
				command => "/usr/sbin/a2enmod ${name}",
				require => $a2enmod_deps,
				notify => Service["apache"],
				unless => "/bin/sh -c '[ -L /etc/apache2/mods-enabled/${name}.load ] \\
					&& [ /etc/apache2/mods-enabled/${name}.load -ef /etc/apache2/mods-available/${name}.load ]'",
			}
		}

		"absent": {
			exec { "a2dismod ${name}":
				command => "/usr/sbin/a2dismod ${name}",
				require => $a2enmod_deps,
				notify => Service["apache"],
				onlyif => "/bin/sh -c '[ -L /etc/apache2/mods-enabled/${name}.load ] && [ -e /etc/apache2/mods-enabled/${name}.load ]'",
			}
		}

		default: {
			err ( "Unknown ensure value: '${ensure}'" )
		}
	}
}