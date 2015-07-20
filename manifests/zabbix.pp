class zabusd::zabbix {
	$zabpkg = ['zabbix-server-mysql', 'zabbix-web-mysql', 'zabbix-sender', 'zabbix-agent']
	$zbschemas = '/usr/share/doc/zabbix-server-mysql-2.4.5/create'
	
	package { $zabpkg: 
		ensure => "installed",
	}
	
	exec { 'import_schema':
		command => "mysql --user=zabbix --password=zabbix zabbix < ${zbschemas}/schema.sql",
		path => '/usr/bin/',
		require  => File["${zbschemas}/schema.sql"],
	}
	
	exec { 'import_images':
		command => "mysql --user=zabbix --password=zabbix zabbix < ${zbschemas}/images.sql",
		path => '/usr/bin/',
		require  => File["${zbschemas}/images.sql"],
	}
	
	exec { 'import_data':
		command => "mysql --user=zabbix --password=zabbix zabbix < ${zbschemas}/data.sql",
		path => '/usr/bin/',
		require  => File["${zbschemas}/data.sql"],
	}
	
	file { "${zbschemas}/schema.sql":
		ensure => 'present',
	}
	file { "${zbschemas}/images.sql":
		ensure => 'present',
	}
	file { "${zbschemas}/data.sql":
		ensure => 'present',
	}
	
	file { '/etc/zabbix/zabbix_server.conf':
		ensure => 'present',
		content => template('zabusd/zabbix_serverconf.erb'),
	}
	
	file { '/etc/zabbix/web/zabbix.conf.php':
		ensure => 'present',
		content => template('zabusd/zabbixconfphp.erb'),
		notify  => Service['nginx'],
	}
	
	service { 'zabbix-server':
		ensure => 'running',
		enable => 'true',
	}
	
	service { 'zabbix-agent':
		ensure => 'running',
		enable => 'true',
	}
}