define apache::vhost($port, $url, $path = '/etc/apache2/sites-available') {
	file {
		"${path}/${name}":
			ensure	=> present,
			owner	=> 'root',
			group	=> 'root',
			mode	=> '0644',
			# assume that $port is used inside template
			content => template("${module_name}/vhost.erb"),
			before	=> File['enable site'],
	}
	file {
		"enable site":
			ensure	=> symlink,
			path	=> "/etc/apache2/sites-enabled/${name}",
			target	=> "${path}/${name}"
	}
#	exec {
#		'enable site':
#			#creates		=> '/etc/apache2/sites-enabled/${name}',
#			command		=> '/usr/sbin/a2ensite ${name}',
#			logoutput	=> on_failure,
#	}
}

