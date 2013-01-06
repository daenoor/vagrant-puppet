# Class: capifony
#
#
class capifony {
    include rvm

    rvm_system_ruby {
        'ruby-1.9.3-p362':
            ensure => 'present',
            default_use => true;
    }

    rvm_gem {
        'ruby-1.9.3-p362/capifony':
            ensure => latest,
            require => Rvm_system_ruby['ruby-1.9.3-p362'];
    }
}