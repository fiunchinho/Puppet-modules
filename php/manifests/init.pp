class php {
	package {
		'php5':
			ensure 	=> present,
			name	=> 'php5',
			# require	=> Exec['php5.4 repository'],
	}
	package {
		['php5-mysql', 'php5-xdebug', 'php-apc', 'php-pear', 'php5-cli', 'php5-memcached', 'php5-imagick']:
			ensure 	=> present,
			require	=> Package['php5'],
	}
	# package {
	# 	['python-software-properties']:
	# 		ensure 	=> present,
	# }
	file {
		'/etc/php5/apache2/php.ini':
			source 	=> 'puppet:///modules/php/php.ini',
			owner	=> 'root',
			group	=> 'root',
			mode	=> '0600',
			require => Package['php5'],
	}
	# exec {
	# 	'php5.4 repository':
	# 		path		=> '/usr/bin',
	# 		logoutput	=> on_failure,
	# 		command		=> "apt-add-repository ppa:ondrej/php5 && apt-get update",
	# 		require		=> Package['python-software-properties'],
	# }
}
