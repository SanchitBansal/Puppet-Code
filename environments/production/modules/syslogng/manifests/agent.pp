####

class syslogng::agent  (
$syslogng_lob = hiera("syslogng::$::lob"),
$lobname = undef,
$syslogng_appserver = hiera("syslogng::applicationserver"),
$syslogng_apacheserver = hiera("syslogng::apacheserver")
)
{
	file { "/usr/local" :
		source => "puppet:///modules/syslogng/syslog-ng_6_64",
		recurse => true,
		ensure => directory,
		mode => "0755",
		ignore    => ['syslog-ng.ctl'],
		notify => Service['syslog-ng'],
	}

	file { '/etc/init.d/syslog-ng':
		source => 'puppet:///modules/syslogng/syslog-ng-service',
		ensure => file,
		mode =>  '755',
		group => "root",
                owner => "root",
		require => File['/usr/local'],
		notify => Service['syslog-ng'],
	}

	file { '/etc/sysconfig/syslog-ng':
		source => 'puppet:///modules/syslogng/sysconfig-syslog-ng',
		ensure => file,
		mode =>  "0644",
		group => "root",
                owner => "root",
		require => File['/usr/local'],
		notify => Service['syslog-ng'],
	}

	file { '/usr/local/var':
		ensure => directory,
		mode => '0755',
		group => "root",
    		owner => "root",
		require => File['/usr/local'],
	}

	file {'/usr/local/etc/syslog-ng.conf':
		mode => '0644',
		group => 'root',
		owner => 'root',
		content => template('syslogng/syslog-ng.conf.erb'),
		require => File['/usr/local'],
		notify => Service['syslog-ng'],
	}
	service { 'syslog-ng' :
		ensure => running,
		enable => true,
		require => File['/etc/init.d/syslog-ng'],
	}
}
