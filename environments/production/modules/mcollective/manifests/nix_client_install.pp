# == Class: mcollective::nix_server_install::nix_client_install
#
class mcollective::nix_client_install(
  $psk = hiera("mcollective::prod_psk"),
  $activemq_client = hiera("mcollective::activemq::client")
  ) {
  # resources

  class { 'mcollective::nix_server_install':
             psk => $psk,
             validation_regex => hiera("mcollective::validation::client"),
           }

  file { '/etc/puppetlabs/mcollective/client.cfg':
    ensure => file,
    mode => '0644',
    content => template('mcollective/client.cfg.erb'),
    notify => Service['mcollective']
  }

  file { '/usr/libexec/mcollective/mcollective/application/':
    ensure => directory,
    mode => '0755',
  }

  file { '/usr/libexec/mcollective/mcollective/application/shell.rb':
    ensure => file,
    mode => '0644',
    source => "puppet:///modules/mcollective/unix/conf/shell_client.rb"
  }

}
