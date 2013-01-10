# Class: laravel
#
#
class laravel(
    $targetdir = '/vagrant'
) {
    $secret = md5(inline_template("<%= "%10.9f%i" % [Time.new.to_f, Random.rand(1000)] %>"))

    file { "laravel config":
        path => "${targetdir}/application/config/application.php",
        ensure => file,
        template => "laravel/application.php.erb",
        mode => "0644",
        unless => "test -f /root/.laravel_secret",
    }

    file { "/root/.laravel_secret":
        content => $secret,
        ensure => file,
        require => File["laravel config"],
    }

    file { "${targetdir}/public/.htaccess":
        ensure => file,
        source => 'puppet:///modules/laravel/.htaccess',
    }

    # vhost configuration
    apache::site{ "default":
        ensure => absent,
    }

    apache::site{ "laravel.lo":
        ensure => present,
        content => template('laravel/laravel.lo.erb'),
    }

    #dev config
    file { "${targetdir}/application/config/local/application.php":
        ensure => file,
        source => 'puppet:///modules/laravel/application_local.php',
    }
}