# == Class: class_name
#
class python (
  $version  = $python::params::version,
  $repopath = $python::params::repopath
  ) inherits python::params{

    $reposerver = hiera("${::datacenter}::reposerver")

  # resources
  if $osfamily == "RedHat" {
    class { 'python::unix_install':
  	  version => $version,
      repopath => $repopath,
      reposerver => $reposerver
  	}
  }

  if $osfamily == "windows" {
    class { 'python::windows_install':
  	  version => $version,
      repopath => $repopath,
      reposerver => $reposerver
  	}
  }
}
