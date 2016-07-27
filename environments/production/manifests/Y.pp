node default  {
	include roles::base
	notify { "${::fqdn} host is ready to use": }
}

node "Z-puppetdev" {
	include roles::puppetdbconfig
}
