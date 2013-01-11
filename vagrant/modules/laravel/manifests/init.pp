# Class: laravel
#
#
class laravel(
    $targetdir = '/vagrant'
) {
    $secret = md5(inline_template("<%= Time.new.to_f %>"))

    file { "laravel config":
        path => "/root/application.php",
        ensure => file,
        content => template("laravel/application.php.erb"),
        mode => "0644",
    }

    exec { "copy laravel config":
        command => "cp /root/application.php ${targetdir}/application/config/application.php",
        unless => "test -f /root/laravel_secret",
        require => File["laravel config"],
        #path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        #refreshonly => true,
    }

    file { "/root/.laravel_secret":
        content => $secret,
        ensure => file,
        require => Exec["copy laravel config"],
    }

    file { "${targetdir}/public/.htaccess":
        ensure => file,
        source => 'puppet:///modules/laravel/.htaccess',
    }

    # vhost configuration
    apache::site{ "000-default":
        ensure => absent,
    }

    apache::site{ "laravel.lo":
        ensure => present,
        content => template('laravel/laravel.lo.erb'),
    }

    #dev config
    file { "${targetdir}/application/config/local":
        ensure => directory,
    }

    file { "${targetdir}/application/config/local/application.php":
        ensure => file,
        source => 'puppet:///modules/laravel/application_local.php',
    }
}