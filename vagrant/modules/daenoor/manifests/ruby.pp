# Class: daenoor::ruby
#
#
class daenoor::ruby {
    include rvm

    rvm::system_user { developer: ; vagrant: ; }

    rvm_system_ruby {
        'ruby-1.9.3':
            ensure => 'present';
    }

    
}