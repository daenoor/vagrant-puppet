# Class: daenoor::feature::feature_symfony14
#
class daenoor::feature::feature_symfony14 {
    php::pear::module{ "symfony": 
        repository => "pear.symfony-project.com",
    }

    apache::vhost { 'puppetdb.example42.com':
        name => "myapp",
        docroot => "/vagrant/web",
        template => 'daenoor/apache/vhost/symfony14/app.local.conf',
        sfroot => "/usr/php/data/symfony/web/sf",
    }
}