class zabusd::system {
	class { selinux:
		mode => 'disabled',
	}
	host { $facts['fqdn']:
		ip => $facts['ipaddress'],
		host_aliases => $facts['hostname'],
		}
	service { 'disable_firewall':
		name => 'firewalld',
		ensure => 'stopped',
		enable => 'false',
	}
	$defaultapps = ['bash-completion', 'wget', 'unzip', 'make', 'gcc', 'cpp', 'zlib']
	package { $defaultapps: 
		ensure => "installed",
	}
}