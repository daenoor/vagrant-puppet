# Define: php::composer::deps
# Parameters:
# arguments
#
define php::composer::deps (
	$dev = false,
	$working_dir = '/vagrant'
) {
	if $dev {
		$command = "composer install --dev"
	} else {
		$command = "composer install"
	}

	exec { "install composer deps":
		command => $command,
		cwd => $working_dir,
		onlyif => "test -f ${working_dir}/composer.json",
		require => Class["php::composer"],
	}
}