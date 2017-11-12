# this is the base class, all fundamental config and packages are installed here
# as well as any special 'case' packages
class base {

  exec { 'time':
    path      => '/bin',
    command   => 'echo $(date +"%D-%T")('base::time')',
    logoutput => true,
  }

  #notify when puppet is running on the client
  notify { 'puppet_run_msgs':
    message => 'Agent run starting at time'
  }

  # make sure ruby gems package is installed
  package { 'rubygems': ensure => installed }

  # make sure that puppet lint is installed
  package { 'puppet-lint':
    ensure   => 'installed',
    provider => 'gem', # use gem provider for installation
    require  => Package['rubygems'], # this package requires ruby gems for installation
  }

  # retrieve the epel repository from the 'mirror' or 'baseurl'
  yumrepo { 'epel' :
    baseurl  => 'http://fedora.melbourneitmirror.net/epel/7/x86_64/',
    descr    => 'epel repository',
    enabled  => 1,
    gpgcheck => 0,
  }

  # make package name 'fuse-sshfs for redhat operating systems
  # if not part of redhat family, default to sshfs
  case $::osfamily {
    'redhat': {
      $packagename = 'fuse-sshfs'
    }

    default: {
      $packagename = 'sshfs'
    }
  }

  # ensure that the sshfs package is installed
  package { $packagename:
    ensure  => installed,
    require => Yumrepo['epel'],
        }

  # installing ruby-augeas & augeas - these tools will be used to change config files
  package { 'ruby-augeas':
    ensure  => installed,
    require => Yumrepo['epel'],
  }

  package { 'augeas':
    ensure  => installed,
    require => Yumrepo['epel']
  }

  # make the package name 'httpd' for redhat family operating systems
  # or default to 'apache2' for all other operating systems
  case $::osfamily {

    'redhat': {
      $apache_package = 'httpd'
    }

    default: {
      $apache_package = 'apache2'
    }
  }

  # ensure that apache package is installed
  package { $apache_package:
    ensure  => installed,
  }

}


