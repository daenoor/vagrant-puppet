# Class: daenoor::features::feature_cap
#
class daenoor::feature::feature_cap {
    include daenoor::ruby

    rvm_gem { 
        'compass': 
            ensure => latest;
        'zurb-foundation': 
            ensure => latest;
    }
}