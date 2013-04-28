class php {
    package { 'curl': ensure => installed }

    package { 'php5':
        ensure 	=> present,
        name	=> 'php5',
    }

    package { ['php5-mysql', 'php5-xdebug', 'php-apc', 'php-pear', 'php5-cli', 'php5-memcached', 'php5-imagick', 'php5-curl']:
        ensure 	=> present,
        require	=> Package['php5'],
    }

    exec { 'php-mongo':
        command => "pecl install mongo",
        path => '/usr/bin:/bin',
        require => [ Package['php5'], Package['build-essential'] ],
        notify => Service['apache2'],
        unless => "test -f /etc/php5/conf.d/mongo.ini"
    }

    exec { 'composer-install':
        command => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin",
        path    => '/usr/bin:/bin:/usr/sbin:/sbin',
        unless  => "test -f /usr/bin/composer.phar",
        require => Package['curl'],
    }

    exec { 'pear-discover':
        path		=> '/usr/bin',
        command		=> "pear config-set auto_discover 1",
        unless 		=> "test -f /usr/bin/phpunit",
        require		=> Package['php-pear'],
    }

    exec { 'phpunit-install':
        command => "pear install --alldeps pear.phpunit.de/PHPUnit",
        path => '/usr/bin:/bin',
        unless => "test -f /usr/bin/phpunit",
        require => Exec['pear-discover'],
    }
}
