# Class: daenoor
#
#
class daenoor
{
    # set path
    Exec { path => [ '/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'], logoutput => true, }
    
    # Apt
    stage {'preinstall':
        before => Stage['main'],
    }

    class { 'daenoor::base::apt':
        stage => preinstall
    }

    include daenoor::base::apt

    include daenoor::base::system

    define enable_features {
        include "daenoor::feature::feature_${name}"
    }

    enable_features { $::features: }
}