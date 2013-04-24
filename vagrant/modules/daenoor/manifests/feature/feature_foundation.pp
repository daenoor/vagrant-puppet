# Class: daenoor::feature::feature_foundation
#
class daenoor::feature::feature_foundation {
    include daenoor::ruby

    rvm_gem { 
        'compass': 
            ensure => latest;
        'zurb-foundation': 
            ensure => latest;
    }
}