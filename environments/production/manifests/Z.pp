node default {
    notify { "${::fqdn} host is ready to use": }
}

### DevOps Server ###
node /^Z-a-5[1-2]$/ {
												include roles::devops
                    class { 'syslogng':
                        lobname => 'testing',
        }
	}
  
node "Z-a-b" {
									                include roles::base
                                  class { 'activemq':
          				                        brokerorder => 0,
                                          activemq_master => true
          				                }
									                class { 'sudoers':
									                        sudo_alias_list => [hiera('sudoers::X'),hiera('sudoers::DEVOPS')],
									                }
									  }
node "Z-a-c" {
									                include roles::base
                                  class { 'activemq':
          				                        brokerorder => 1
          				                }
									                class { 'sudoers':
									                        sudo_alias_list => [hiera('sudoers::X'),hiera('sudoers::DEVOPS')],
									                }
									  }
