# This class will control the running of services, and ensure that they restart if a config file is changed
class enable_services {

  # notify when the service config has been changed
  file { '/etc/ssh/sshd_config':
    notify  => Service['sshd'],  # this code creates the relationship to the service
    mode    => '0600', # set run mode permissions
    require => Package['openssh'], # this package requires openssh to be installed
  }

  # add a notify to the file resource
  file { '/etc/puppetlabs/puppet/puppet.conf':
    notify => Service['puppet'],  # this code creates the relationship to the service
    mode   => '0644', # set run mode permissions
  }


  # ensure puppet services are running
  service { 'puppet':
    ensure => running,
    enable => true,
      }

  # ensure mariadb or 'MySQL' services are running
  service { 'mariadb':
    ensure => running,
    enable => true,
  }

  # ensure that sshd services are running
  service { 'sshd':
    ensure => running,
    enable => true,
  }

  # ensure apache or 'httpd' services are running
  service { 'httpd':
    ensure => running,
    enable => true,
    start  => true,
  }
}

