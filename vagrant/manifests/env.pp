node default{
	
	include bootstrap

	include apache

	include php
	include php::apache

	# Set up mysql db
	include mysql
	mysql::db { 'site_db':
   		user     => 'vagrant',
   		password => 'vagrant',
   		host     => 'localhost',
   		grant    => ['all'],
   		require => Service["mysql"],
 	}
}