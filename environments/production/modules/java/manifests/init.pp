
class java(
$version  = $java::params::version,
$repopath = $java::params::repopath
) inherits java::params{

  $reposerver = hiera("${::datacenter}::reposerver")

  if $os[family]=="RedHat" and $os[architecture]=="x86_64" and $os[release][major]=="6"
    {
      class { 'java::install':
    	  version => $version,
        repopath => $repopath,
        reposerver => $reposerver
    	}

    }
    else { notify { "Only linux jdk support till now" : }}
}
