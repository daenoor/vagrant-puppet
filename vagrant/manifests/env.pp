node default{
	
	include bootstrap

	include apache

	include php
	include php::apache

	class { "mysql":
		mysql_db => "site_db",
	}
}