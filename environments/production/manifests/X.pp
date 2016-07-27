node default {
        include roles::base
        notify { "${::fqdn} host is ready to use": }
}

node "X-a-b" {
                include roles::base
                class { 'activemq':
                        brokerorder => 2
                }
                class { 'sudoers':
                        sudo_alias_list => [hiera('sudoers::DEVOPS')],
                }
        }

node "X-a-c" {
				                include roles::base
				                class { 'activemq':
				                        brokerorder => 3
				                }
				                class { 'sudoers':
				                        sudo_alias_list => [hiera('sudoers::DEVOPS')],
				                }
				  }
