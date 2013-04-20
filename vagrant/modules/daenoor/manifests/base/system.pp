# Class: base
# Some basic stuff
#
class daenoor::base::system {
    include daenoor::base::users

    User <| title == rot |>
    User::Managed <| tag == admins |>
    User::Managed <| tag == developers |>
    Group <| tag == admins |>
    Group <| tag == developers |>

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

    # If debian based - check apt and run update
    case $::osfamily {
        "debian": {
            include apt
        }
        default: {
            # code
        }
    }

    package { 'git': ensure => present }
    package { 'mercurial': ensure => present }
}   