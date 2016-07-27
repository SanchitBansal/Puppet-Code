class activemq($brokerorder=0, $activemq_master=false ) {
				$brokername = hiera("activemq::broker.${brokerorder}.broker${brokerorder}.name")
        $activemq_brokers=hiera('activemq::broker')
				$maxConnections = hiera("activemq::broker.${brokerorder}.broker${brokerorder}.maxConnections")
				$initJavaHeap = hiera("activemq::broker.${brokerorder}.broker${brokerorder}.initJavaHeap")
				$maxJavaHeap = hiera("activemq::broker.${brokerorder}.broker${brokerorder}.maxJavaHeap")

        exec { 'activemq-install':
                command => "rpm -Uvh https://yum.puppetlabs.com/el/6/dependencies/x86_64/activemq-5.9.1-2.el6.noarch.rpm",
                creates => "/etc/init.d/activemq",
								path => '/bin',
                }

        file { '/etc/activemq/activemq.xml':
                ensure => file,
                content => template("activemq/activemq.xml.erb"),
                mode => "0644",
                require => Exec['activemq-install'],
        }

        file { '/etc/activemq/activemq-wrapper.conf':
                ensure => file,
                content => template("activemq/activemq-wrapper.conf.erb"),
                mode => "0644",
                require => Exec['activemq-install'],
        }

				file { '/etc/init.d/activemq':
                ensure => file,
                content => template("activemq/activemq-service.erb"),
                mode => "0755",
                require => Exec['activemq-install'],
        }

        service { 'activemq':
                ensure => running,
                enable => true,
                subscribe => File['/etc/activemq/activemq.xml','/etc/activemq/activemq-wrapper.conf','/etc/init.d/activemq'],
        }
}
