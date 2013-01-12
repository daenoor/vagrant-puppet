# Set PATH
Exec{
	path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"],
}

### Bootstrap

## Set up puppet group
group { "puppet":
	ensure => 'present',
}

## Set up package system

# Add 10gen repository to package system to install actual version of MongoDB
file { "/etc/apt/sources.list.d/10gen.list":
	ensure => file,
	owner => "root",
	group => "root",
	mode => 0644,
	content => "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen",
}

exec { "import 10gen public GPG key":
	command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
}

# Update packages tree
exec { "apt-get update":
	require => Exec["import 10gen public GPG key"],
}

# Install build-essential package
package { "build-essential":
	ensure => installed,
	require => Exec["apt-get update"],
}

## System configuration

# Hostname
#TODO: Hostname is project name. We should get this info from project dir name or from some config file


### Apache web server

# Install 
package { "apache2":
	ensure => installed,
	require => Exec["apt-get update"],
}

# Ensure that mod_rewrite is loaded
file { "/etc/apache2/mods-enabled/rewrite.load":
	ensure => link,
	target => "/etc/apache2/mods-available/rewrite.load",
	require => Package["apache2"],
}

service { "apache2":
    enable => true,
	ensure => running,
	#hasrestart => true,
	#hasstatus => true,
	require => Package["apache2"],
	subscribe => [
		File["/etc/apache2/mods-enabled/rewrite.load"],
		File["/etc/apache2/sites-available/default"],
	],
}

### MySQL
$root_password = 'l00s3MenOw'

package { "mysql-server":
	ensure => installed,
	require => Exec["apt-get update"],
}

service { "mysql":
    enable => true,
    ensure => running,
    require => Package['mysql-server'],
}

exec { "set mysql password":
	command => "mysqladmin -uroot password $root_password",
	require => Service["mysql"],
	unless => "mysqladmin -uroot -p$root_password status",
}

### MongoDB
package { "mongodb-10gen":
	ensure => installed,
	require => Exec["apt-get update"],
}

service { "mongodb":
    enable => true,
	ensure => running,
	require => Package["mongodb-10gen"],
}

### PHP 
$php_base = ["php5-cli", "libapache2-mod-php5"]
package { $php_base:
	ensure => installed,
	require => Exec["apt-get update"],
	alias => "php5",
}

# Install additional packages
$php_packages = ["php5-mysql", "php-pear", "php5-dev", "php5-gd", "php-apc", "php5-intl", "php5-xdebug"]
package { $php_packages:
	ensure => installed,
	require => Package[php5],
}

# Install MongoDB driver from PECL
exec { "Install PHP MongoDB extension":
	command => "pecl install mongo",
	unless => "pecl info mongo",
}

# Do PEAR upgrade
exec { "Upgrade PEAR":
	command => "pear upgrade",
	require => Package["php-pear"],
}

# Enable channel autodiscover in PEAR
exec { "Enable PEAR channel autodiscover":
	command => "pear config-set auto_discover 1",
	require => Package["php-pear"],
}

# Install Symfony 1.4 via PEAR
exec { "Install Symfony 1.4":
	command => "pear install pear.symfony-project.com/symfony",
	require => Exec["Enable PEAR channel autodiscover"],
	unless => "pear info symfony/symfony",
}

# Install PHPUnit via PEAR
exec { "Install PHPUnit":
	command => "pear install pear.phpunit.de/PHPUnit",
	require => Exec["Enable PEAR channel autodiscover"],
	unless => "pear info phpunit/PHPUnit",
}


### RVM
## To be discovered
