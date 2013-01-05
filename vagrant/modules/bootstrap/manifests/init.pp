# Class: bootstrap
#
# Preparing environment
class bootstrap {

    Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

    group { 'puppet':
        ensure => 'present'
    }

    file { "10gen repository":
        ensure => file,
        path => "/etc/apt/sources.list.d/10gen.list",
        owner => "root",
        group => "root",
        mode => "0644",
        content => "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen",
    }

    exec { "Import 10gen key":
        command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
    }

    # make packages list up to date
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
        require => [File["10gen repository"], Exec["Import 10gen key"]],
    }

    # install software
    package { ["build-essential", "git-core", "curl", "mercurial"]:
        ensure => latest,
        require => Exec["apt-get update"],
    }
}