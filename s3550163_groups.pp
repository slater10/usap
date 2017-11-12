# creating the groups that users can be added to
class groups {

  group { 'trucks':
    ensure => present
  }

  group { 'cars':
    ensure => present
  }

  group { 'sysadmin':
    ensure => present
  }

  group { 'ambulances':
    ensure => present
  }

}

