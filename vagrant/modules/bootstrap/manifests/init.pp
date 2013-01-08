# Class: bootstrap
#
# Preparing environment
class bootstrap {

    Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

    # make packages list up to date
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
        # require => [File["10gen repository"], Exec["Import 10gen key"]],
    }

    Exec["apt-get update"] -> Package <| |> 
    
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

    # install software
    package { ["build-essential", "git-core", "curl", "mercurial", "python-software-properties"]:
        ensure => latest,
        require => Exec["apt-get update"],
    }

    # Install ruby from Brightbox ppa
    exec { "add brightbox ppa":
        command => "apt-add-repository ppa:brightbox/ruby-ng",
        require => Package["python-software-properties"],
    }

    exec { "use brightbox ppa":
        command => "apt-get update",
        require => Exec["add brightbox ppa"],
    }

    package { "ruby1.9.1":
        ensure => latest,
        require => Exec["use brightbox ppa"],
    }
}