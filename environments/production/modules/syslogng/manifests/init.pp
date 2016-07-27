####

class syslogng ($lobname=$::lob){ 
	if $os[family]=="RedHat" and $os[architecture]=="x86_64" and $os[release][major]=="6" {
		if "$lobname" and hiera("syslogng::$lobname") { 
			class { 'syslogng::agent' :
				syslogng_lob => hiera("syslogng::$lobname"),
				lobname => $lobname,
			}
		}
		else { notify { "Facter lob is Not Set" : } }
	}	
}