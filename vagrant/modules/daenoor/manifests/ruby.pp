# Class: daenoor::ruby
#
#
class daenoor::ruby {
    include rvm

    rvm::system_user { developer: ; vagrant: ; }

    rvm_system_ruby {
        'ruby-1.9.3':
            ensure => 'present',
            default_use => true;
        'ruby-1.8.7':
        	ensure => 'present';
    }

    rvm_gem { 
        'ruby-1.8.7/puppet': 
            ensure => latest,
            require => Rvm_system_ruby['ruby-1.8.7'];
    }
}