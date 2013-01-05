# Class: pear
#
#
class pear {
	
	$package = "php-pear"

	package { $package:
    	ensure => installed,
    	requrie => Package["php5-cli"],
  	} 
}