# Class: base
# Some basic stuff
#

class daenoor::base::system {
    # OpenSSH
    class { 'openssh':
        template => 'daenoor/openssh/sshd_config.erb',
    }

    # DNS configuration
    class { 'resolver': 
        dns_servers => [ '8.8.4.4', '8.8.8.8' ],
        search => "ayaroshenko.me",
        options => {
            rotate => '',
            timeout => '2',
        }
    }

    # Hosts file
    file { "/etc/hosts":
        ensure => present,
        content => template('daenoor/hosts/hosts.erb'),
    }

    # Sudo
    class { 'sudo': 
        source => "puppet:///modules/daenoor/sudo/sudoers",
    }

    package { 'git': ensure => present }
    package { 'mercurial': ensure => present }
}
