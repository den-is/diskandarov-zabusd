# == Class: zabusd
#
# Full description of class zabusd here.
#
# === Authors
#
# Denis Iskandarov <d.iskandarov [at] gmail.com>
#
# === Copyright
#
# Copyright 2015 Denis Iskandarov
#
class zabusd {
	include zabusd::system
	include zabusd::repos
	include zabusd::database
	include zabusd::nginxsetup
	include zabusd::phpsetup
	include zabusd::zabbix
	include zabusd::crawler
}
