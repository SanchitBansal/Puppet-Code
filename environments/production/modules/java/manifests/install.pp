class java::install ($version,$repopath,$reposerver)
{
  file { "java_folder":
        ensure => directory,
        mode => "0755",
        owner => "root",
        group => "root",
        path => "/opt/java/"
  }

  exec { 'untar_jdk':
        command => "wget http://$reposerver/$repopath/jdk${version}.tar.gz -O - | tar -xz -C /opt/java",
        path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
        creates => "/opt/java/jdk${version}",
        require => File["java_folder"]
  }

  file { "/opt/java/jdk":
        ensure => link,
        mode => '0777',
        group => "root",
        owner => "root",
        target => "/opt/java/jdk${version}",
        require => Exec["untar_jdk"]
  }

  file { "/etc/profile.d/set_java_env.sh":
            ensure  => present,
            mode    => "0400",
            owner   => "root",
            group   => "root",
            source  => "puppet:///modules/java/unix/set_java_env.sh",
            require => File["/opt/java/jdk"]
  }
  exec { 'source_env':
        command => "bash -c 'source /etc/profile.d/set_java_env.sh'",
        path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
        subscribe => File["/etc/profile.d/set_java_env.sh"],
        refreshonly => true,
        unless => 'echo $JAVA_HOME | grep -q /opt/java/jdk'
  }
}
