# Class: daenoor::features::feature_cap
#
class daenoor::feature::feature_cap {
    include daenoor::ruby

    rvm_gem { 
        'ruby-1.9.3/capifony': 
            ensure => latest,
            require => Rvm_system_ruby['ruby-1.9.3'];
    }
}