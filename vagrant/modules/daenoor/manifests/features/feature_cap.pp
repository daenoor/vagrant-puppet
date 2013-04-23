# Class: daenoor::features::feature_cap
#
class daenoor::features::feature_cap {
    include daenoor::ruby

    rvm_gem { 
        'capifony': 
            ensure => latest;
    }
}