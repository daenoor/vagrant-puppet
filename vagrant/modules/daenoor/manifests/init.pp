# Class: daenoor
#
#
class daenoor
{
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