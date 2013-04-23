# Class: daenoor
#
#
class daenoor
{
    include daenoor::base::system

    define enable_features {
        include "daenoor::feature::feature_${name}"
    }

    enable_features($::features)
}