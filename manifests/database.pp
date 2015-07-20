class zabusd::database {
	class { '::mysql::server':
		root_password => 'badpassword',
		override_options => { 'mysqld' => { 'max_connections' => '1024' } },
	}
	
	include mysql::server::account_security
	
	mysql::db { 'zabbix':
		user     => 'zabbix',
		password => 'zabbix',
		host     => 'localhost',
		grant    => ['ALL'],
		}
}