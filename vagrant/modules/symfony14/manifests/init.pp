# Class: symfony14
#
#
class symfony14(
    $targetdir = '/vagrant'
) {
    php::pear::package{ "symfony":
        repository => "pear.symfony-project.com",
    }

    apache::site{ "default":
        ensure => absent,
    }

    apache::site{ "symfony.lo":
        ensure => present,
        content => template('symfony14/symfony.lo.erb'),
    }
}