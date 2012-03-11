class mysql {
	package {
		'mysql':
			ensure 	=> present,
			name	=> 'mysql-server',
	}
	file {
		'/etc/mysql/mysql.conf':
			source 	=> 'puppet:///modules/mysql/my.cnf',
			owner	=> 'root',
			group	=> 'root',
			mode	=> '0600',
			require => Package['mysql'],
	}
	service {
		'mysql':
			ensure	=> running,
			enable	=> true,
			hasstatus => true,
			hasrestart => true,
			subscribe => File['/etc/mysql/mysql.conf'],
			require => Package['mysql'],
	}
}
