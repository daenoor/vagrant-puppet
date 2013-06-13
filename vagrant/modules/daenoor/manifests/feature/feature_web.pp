# Class: daenoor::feature::feature_web
#
#
class daenoor::feature::feature_web {
	# Apache
    class { 'apache':
    }
  
    apache::module { 'headers': }
    apache::module { 'rewrite': }

	apache::vhost { "${fqdn}":
        name => "myapp",
        docroot => "/vagrant/web",
        template => 'daenoor/apache/vhost/symfony14/app.local.conf',
    }
}