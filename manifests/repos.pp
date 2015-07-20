class zabusd::repos {

	yumrepo { 'nginx':
		name => 'Nginx',
		baseurl => 'http://nginx.org/packages/centos/7/x86_64/',
		gpgcheck => 0,
		enabled => 1,
		protect => 1,
	}
	
	package { 'epel-release':
		provider => 'rpm',
		ensure => 'installed',
		source => 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm',
	}
	
	package { 'rpmforge-release':
		provider => 'rpm',
		ensure => 'installed',
		source => 'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm',
	}
	
	package { 'zabbix-release':
		provider => 'rpm',
		ensure => 'installed',
		source => 'http://repo.zabbix.com/zabbix/2.4/rhel/7/x86_64/zabbix-release-2.4-1.el7.noarch.rpm',
	}
	
	exec { 'update_sys':
		command => "yum -y update",
		path => '/usr/bin/',
	}

}