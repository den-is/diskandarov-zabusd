class zabusd::nginxsetup {
	package {'nginx':
		ensure => "installed"
	}
	file { '/etc/nginx/conf.d/default.conf':
		ensure => 'present',
		content => template('zabusd/nginxdefaultconf.erb'),
	}
	service { 'nginx':
		ensure => 'running',
		enable => 'true',
	}
}