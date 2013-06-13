# Class: daenoor::feature::feature_foundation
#
class daenoor::feature::feature_foundation {
    include daenoor::ruby

    rvm_gem { 
        'ruby-1.9.3/compass': 
            ensure => latest,
            require => Rvm_system_ruby['ruby-1.9.3'];
        'ruby-1.9.3/zurb-foundation': 
            ensure => latest,
            require => Rvm_system_ruby['ruby-1.9.3'];
    }
}