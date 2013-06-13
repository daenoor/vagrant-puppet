# Class: daenoor::node
#
#
class daenoor::node_js {
	package { 'build-essential': ensure => present }

	class { 'nodejs':
	  version => 'latest',
	  require => Package['build-essential'],
	}
}