class roles::bigdata  inherits roles::base {
	if $os[family]=='RedHat' {
		class { 'sudoers':
 			sudo_alias_list => [hiera('sudoers::X'),hiera('sudoers::Y'),hiera('sudoers::BIGDATA')],
 		}
	}
}
