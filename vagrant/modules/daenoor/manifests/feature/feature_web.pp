# Class: daenoor::feature::feature_web
#
#
class daenoor::feature::feature_web {
	# Apache
    class { 'apache':
    }

	apache::vhost { "app_vhost":
        name => "myapp",
        docroot => "/vagrant/web",
        template => 'daenoor/apache/vhost/symfony14/app.local.conf',
    }
}