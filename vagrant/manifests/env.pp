node default{
	
	include bootstrap

	include apache

	include php
	include php::apache
}