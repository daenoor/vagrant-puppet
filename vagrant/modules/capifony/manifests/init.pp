# Class: capifony
#
#
class capifony {
    exec { "install capifony":
        command => "gem install capifony --no-ri --no-rdoc",
        require => Package["ruby1.9.1"],
    }
}