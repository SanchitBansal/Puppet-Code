# == Class: mcollective::windows_remove_junk
#
class mcollective::windows_remove_junk {
  # resources

  exec { 'stop old mcollective service':
    command => 'C:\\windows\\System32\\sc.exe stop mcollectived',
    onlyif  => "C:\\windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy ByPass -command \"if (Test-Path C:\\mcollective\\unins000.exe) { exit 0;} else { exit 1; }\"",
  }

  exec {'uninstall old mcollective':
    command => 'C:\\mcollective\\unins000.exe /silent',
    onlyif  => "C:\\windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy ByPass -command \"if (Test-Path C:\\mcollective\\unins000.exe) { exit 0;} else { exit 1; }\"",
  }

  exec { 'remove old mcollective service':
    require => Exec['stop old mcollective service'],
    before => Exec['uninstall old mcollective'],
    command => 'C:\\windows\\System32\\sc.exe delete mcollectived',
    onlyif  => "C:\\windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy ByPass -command \"if (Test-Path C:\\mcollective\\unins000.exe) { exit 0;} else { exit 1; }\"",
  }

  exec {'uninstall old ruby':
    command => 'C:\\Ruby193\\unins000.exe /silent',
    onlyif  => "C:\\windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  -ExecutionPolicy ByPass -command \"if (Test-Path C:\\Ruby193\\unins000.exe) { exit 0;} else { exit 1; }\"",
  }

}
