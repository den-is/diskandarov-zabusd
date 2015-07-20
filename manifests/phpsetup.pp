class zabusd::phpsetup {
	$phpmodules = ['php-fpm', 'php-bcmath', 'php-cli', 'php-common', 'php-snmp', 'php-gd', 'php-mbstring', 'php-mysql', 'php-pdo', 'php-xml', 'php-xmlrpc', 'php-imap', 'php-mcrypt', 'php-odbc', 'php-pear', 'curl', 'curl-devel', 'perl-libwww-perl', 'ImageMagick', 'libxml2', 'libxml2-devel', 'libxslt-devel']
	
	package { $phpmodules: 
		ensure => "installed",
	}
	
	file { '/etc/php.ini':
		ensure => 'present',
		content => template('zabusd/phpini.erb'),
	}
	
	file { '/etc/php-fpm.d/www.conf':
		ensure => 'present',
		content => template('zabusd/fpmwww.erb'),
	}
	
	service { 'php-fpm':
		ensure => 'running',
		enable => 'true',
	}
}
