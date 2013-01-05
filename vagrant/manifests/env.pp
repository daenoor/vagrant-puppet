Exec {
    path => [
        '/usr/local/bin',
        '/opt/local/bin',
        '/usr/bin', 
        '/usr/sbin', 
        '/bin',
        '/sbin'],
    logoutput => true,
}

node default{
    
    include bootstrap

    include apache

    include php
    include php::apache

    include php::composer

    # Set up mysql db
    include mysql
    mysql::db { 'site_db':
        user     => 'vagrant',
        password => 'vagrant',
        host     => 'localhost',
        grant    => ['all'],
        require => Service["mysql"],
    }

    php::module{ "mysql":
        ensure => "present",
        require => [Package['php5-cli'], Class["mysql"]],
    }


    include symfony14
}