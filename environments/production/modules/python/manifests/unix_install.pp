
class python::unix_install ($version,$repopath,$reposerver)
{

  exec { "python${version}" :
    cwd => "/opt",
    command => "wget http://$reposerver/$repopath/python-${version}.tgz -O - | tar -zx -C /opt/",
    creates => "/opt/python-${version}",
    path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
  }

  file { "/etc/ld.so.conf.d/libpython-${version}.conf" :
    ensure => file,
    mode => "0644",
    content => "/opt/python-${version}/lib",
    require => Exec["python${version}"],
  }

  exec { "ldconfig":
    command => "ldconfig",
    path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
    refreshonly => true,
    subscribe => File["/etc/ld.so.conf.d/libpython-${version}.conf"],
  }
}
