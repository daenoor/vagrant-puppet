define apache::site ($ensure='present') {
	$a2ensite_deps = Package["apache"]

	case $ensure {
		"present": {
			exec { "a2ensite ${name}":
				command => "/usr/sbin/a2ensite ${name}",
				require => $a2ensite_deps,
				notify => Service["apache"],
				unless => "/bin/sh -c '[ -L /etc/apache2/sites-enabled/${name} ] \\
					&& [ /etc/apache2/sites-enabled/${name} -ef /etc/apache2/sites-available/${name} ]'",
			}
		}

		"absent": {
			exec { "a2dissite ${name}":
				command => "/usr/sbin/a2dissite ${name}",
				require => $a2ensite_deps,
				notify => Service["apache"],
				onlyif => "/bin/sh -c '[ -L /etc/apache2/sites-enabled/${name} ] && [ -e /etc/apache2/sites-enabled/${name} ]'",
			}
		}

		default: {
			err ( "Unknown ensure value: '${ensure}'" )
		}
	}
}