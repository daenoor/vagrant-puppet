# Class: daenoor::feature::feature_web
#
#
class daenoor::feature::feature_web {
<<<<<<< HEAD
	# Apache
    class { 'apache':
    }
=======
	include daenoor::lamp
>>>>>>> use daenoor:lamp in web feature

	apache::vhost { "app_vhost":
        name => "myapp",
        docroot => "/vagrant/web",
        template => 'daenoor/apache/vhost/symfony14/app.local.conf',
    }
}