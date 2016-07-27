# == Class: mcollective::windows_server
#
class mcollective::windows_server_install(
  $psk = hiera("mcollective::prod_psk"),
  $activemq_server = hiera("mcollective::activemq::server"),
  $validation_regex = hiera("mcollective::validation::server")
  ){
  # resources
  include mcollective::windows_remove_junk

  file { 'C:/puppet_installation':
    ensure => directory,
    recurse => true,
    source => 'puppet:///modules/mcollective/windows/softwares'
  }

  exec { 'Installing 7zip':
    require => File['C:/puppet_installation'],
    command => 'C:\\windows\\System32\\msiexec.exe /i C:\\puppet_installation\\7z1514-x64.msi /q',
    creates => 'C:/Program Files/7-Zip/7z.exe',
  }

  file{ 'C:/mcollective':
    ensure => directory,
  }

  file { 'C:/mcollective/md5':
    ensure          => directory,
    recurse         => true,
    source          => 'puppet:///modules/mcollective/windows/softwares/md5'
  }

  file { 'C:/Program Files/Puppet Labs/Puppet/mcollective/lib/mcollective/agent/shell.ddl':
    ensure => file,
    content => template('mcollective/shell.ddl.erb'),
    notify => Service['mcollective']
  }

  file { 'C:/Program Files/Puppet Labs/Puppet/mcollective/lib/mcollective/agent/shell.rb':
    ensure => file,
    source => "puppet:///modules/mcollective/windows/conf/shell.rb",
    notify => Service['mcollective']
  }

  file { ['C:/Program Files/Puppet Labs/Puppet/mcollective/etc/server.cfg','C:/ProgramData/PuppetLabs/mcollective/etc/server.cfg']:
    require => File['C:/Program Files/Puppet Labs/Puppet/mcollective/lib/mcollective/agent/shell.ddl','C:/Program Files/Puppet Labs/Puppet/mcollective/lib/mcollective/agent/shell.rb'],
    ensure => file,
    content => template("mcollective/server.cfg.erb"),
  }

  file { 'C:/Program Files/Puppet Labs/Puppet/mcollective/etc/facts.yaml':
    require => File['C:/Program Files/Puppet Labs/Puppet/mcollective/lib/mcollective/agent/shell.ddl','C:/Program Files/Puppet Labs/Puppet/mcollective/lib/mcollective/agent/shell.rb'],
    ensure => file,
    source => "puppet:///modules/mcollective/windows/conf/facts.yaml"
  }

  file {'C:/Program Files/Puppet Labs/Puppet/mcollective/mcollective.log':
    require => File['C:/Program Files/Puppet Labs/Puppet/mcollective/lib/mcollective/agent/shell.ddl','C:/Program Files/Puppet Labs/Puppet/mcollective/lib/mcollective/agent/shell.rb'],
    ensure => file
  }

  service { 'mcollective':
    subscribe => File['C:/Program Files/Puppet Labs/Puppet/mcollective/etc/server.cfg','C:/ProgramData/PuppetLabs/mcollective/etc/server.cfg','C:/Program Files/Puppet Labs/Puppet/mcollective/etc/facts.yaml'],
    ensure => running,
    enable => true,
  }

}
