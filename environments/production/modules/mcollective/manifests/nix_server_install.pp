# == Class: class_name
#
class mcollective::nix_server_install(
  $psk = hiera("mcollective::prod_psk"),
  $activemq_server = hiera("mcollective::activemq::server"),
  $validation_regex = hiera("mcollective::validation::server")
  ) {
  # resources

  file { '/etc/yum.repos.d/puppetlabs-pc1.repo':
    ensure => file,
    source => 'puppet:///modules/mcollective/unix/puppetlabs-pc1.repo',
  }

  package { 'puppet-agent':
    require => File['/etc/yum.repos.d/puppetlabs-pc1.repo'],
    ensure => installed,
  }


  file { '/etc/puppetlabs/mcollective/server.cfg':
    require => Package['puppet-agent'],
    ensure => file,
    mode => '0644',
    content => template('mcollective/server.cfg.erb'),
    notify => Service['mcollective'],
  }

  file {['/usr/libexec/mcollective','/usr/libexec/mcollective/mcollective','/usr/libexec/mcollective/mcollective/agent/']:
    ensure => directory,
    recurse => true,
    mode => '0755',
  }

  file { '/usr/libexec/mcollective/mcollective/agent/shell.rb':
    ensure => file,
    mode => '0644',
    source => "puppet:///modules/mcollective/unix/conf/shell_server.rb"
  }

  file { '/usr/libexec/mcollective/mcollective/agent/shell.ddl':
    ensure => file,
    mode => '0644',
    content => template('mcollective/shell.ddl.erb'),
  }

  service { 'mcollective':
    subscribe => File['/etc/puppetlabs/mcollective/server.cfg','/usr/libexec/mcollective/mcollective/agent/shell.rb','/usr/libexec/mcollective/mcollective/agent/shell.ddl'],
    ensure => running,
    enable => true,
  }

  exec { 'Checking nrpe file for mcollecive check':
    command => '/bin/sed  -i  "/sbin\/mcollectived/s^/usr/sbin/mcollectived^/opt/puppetlabs/puppet/bin/mcollectived^" /etc/nagios/nrpe.cfg ',
    onlyif => "/bin/grep -q 'sbin/mcollectived' /etc/nagios/nrpe.cfg"
  }

  exec { 'Restart nrpe':
    subscribe => Exec['Checking nrpe file for mcollecive check'],
    command => '/etc/init.d/nrpe restart',
    refreshonly => true,
  }

}
