# Class: daenoor::base::apt
#
#
class daenoor::base::apt {
	exec { 'apt-get -y update': }
}