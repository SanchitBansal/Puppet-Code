# == Class: class_name
#
class mcollective (
  $psk = hiera("mcollective::prod_psk")
){
  # resources
  if $osfamily == "RedHat" {
    class { 'mcollective::nix_server_install':
  	  psk => $psk
  	}
  }

  if $osfamily == "windows" {
    class { 'mcollective::windows_server_install':
  	  psk => $psk
  	}
  }

}
