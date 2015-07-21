class zabusd::crawler {
	require zabusd::zabbix
	class { 'python':
		version    => 'system',
		dev        => true,
		pip        => true,
		}
	python::pip { 'setuptools':
		pkgname       => 'setuptools',
		ensure        => '18.0.1',
		timeout       => 300,
		}
	python::pip { 'pip':
		pkgname       => 'pip',
		ensure        => '7.1.0',
		timeout       => 300,
		}
	python::pip { 'requests':
		pkgname       => 'requests',
		ensure        => '2.7.0',
		timeout       => 300,
		}
	python::pip { 'lxml':
		pkgname       => 'lxml',
		ensure        => '3.4.4',
		timeout       => 300,
		}
	python::pip { 'subprocess32':
		pkgname       => 'subprocess32',
		ensure        => '3.2.6',
		timeout       => 300,
		}
	file { '/opt/scripts':
		ensure => 'directory',
		owner  => 'root',
		group  => 'wheel',
		mode   => '0750',
		}
	file { '/tmp/createhost.py':
		require => Python::Pip['requests'],
		replace => 'no',
		ensure => 'present',
		owner  => 'root',
		group  => 'wheel',
		mode   => '0750',
		source => 'puppet:///modules/zabusd/createhost.py',
		}
	exec { 'create_host':
		command => 'python /tmp/createhost.py',
		path => '/usr/bin/',
		require  => File['/tmp/createhost.py'],
		}
	exec { 'remove_create_host':
		command => 'rm -f /tmp/createhost.py',
		path => '/usr/bin/',
		require  => Exec['create_host'],
		}
	file { "/opt/scripts/tbccrawler.py":
		replace => 'no',
		ensure => 'present',
		owner  => 'root',
		group  => 'wheel',
		mode   => '0750',
		source => 'puppet:///modules/zabusd/tbccrawler.py',
		}
	cron { tbccrawler:
		command => '/usr/bin/python /opt/scripts/tbccrawler.py >/dev/null 2>&1',
		user    => root,
		minute  => '*/5',
		}
}