class apache {
	package {
		'apache2':
			ensure 	=> present,
			name	=> 'apache2',
	}

	exec {
		'a2enmod rewrite':
			command => "a2enmod rewrite",
			require => Package['apache2'],
			path => ['/usr/bin','/bin', '/usr/sbin'],
			unless => "/bin/readlink -e /etc/apache2/mods-enabled/rewrite.load"
	}

	#file {
	#	'/etc/apache2/apache2.conf':
	#		source 	=> 'puppet:///modules/apache/apache2.conf',
	#		owner	=> 'root',
	#		group	=> 'root',
	#		mode	=> '0600',
	#		require => Package['apache2'],
	#}
	service {
		'apache2':
			ensure	=> running,
			enable	=> true,
			hasstatus => true,
			hasrestart => true,
			#subscribe => File['/etc/apache2/apache2.conf'],
	}
	#apache::vhost {
	#	'diarioyoya':
	#		port	=> '8080',
	#		url	=> 'diarioyoya.vm',
	#		require	=> Package['apache2'],
	#		notify	=> Service['apache2'],
	#}
}
