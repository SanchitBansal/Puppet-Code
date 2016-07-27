class roles::devops {
	if $os[family]=='RedHat' {
		include mcollective::nix_client_install
		class { 'sudoers':
 			sudo_alias_list => [hiera('sudoers::X'),hiera('sudoers::Y'),hiera('sudoers::DEVOPS')],
 		}
	}
}
