class ssh {
	package {
		"openssh-server":
			ensure 	=> present,
	}
	file {
		'/etc/ssh/sshd_config':
			source 	=> 'puppet:///modules/ssh/sshd_config',
			owner	=> 'root',
			group	=> 'root',
			mode	=> '0644',
			require => Package["openssh-server"],
	}

	service {
		"ssh":
			ensure		=> running,
			enable		=> true,
			hasstatus 	=> false,
			pattern		=> "/usr/sbin/sshd",
			hasrestart 	=> true,
			subscribe 	=> [File["/etc/ssh/sshd_config"],Package["openssh-server"]],
			require 	=> [
            	File["/etc/ssh/sshd_config"],
            	Package["openssh-server"]
        	],
	}
}