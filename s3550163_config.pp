# class for the configuration changes
class config {

  # this will be explained better in the report
  # retrieved public ip's for the folloiwing servers by using nslookup

  # host records for titan, jupiter, and saturn

  # use: ssh [studentID]@titan
  #eg s3550163@titan

  host { 'titan_server':
    ip           => '131.170.5.131',
    host_aliases => 'titan',
  }

  host { 'jupiter_server':
    ip           => '131.170.5.135',
    host_aliases => 'jupiter'
  }

  host { 'saturn_server':
    ip           => '131.170.5.132',
    host_aliases => 'saturn'
  }

  # created symbolic link to s3550163 folder 
  file { '/var/www':
    ensure => 'link',
    target => '/s3550163',
    force  => true,
  }

  # configure the sshd file with augeas
  # set PermitRootLogin to 'no'
  augeas { 'configure_sshd':
    context => '/files/etc/ssh/sshd_config', # the absolute file path to the file that will be changed
    changes =>  [ # the changes to be made
      'set PermitRootLogin no',
      'set PasswordAuthentication yes' # setting password authentication to yes for use with host records
      ],
  }

  # configure the runinterval setting in the puppet.conf to run every 20 minutes or '1200' seconds
  augeas { 'configure_runinterval':
    context => '/files/etc/puppetlabs/puppet/puppet.conf/main',
    changes =>  [
      'set runinterval 1200',
    ],
  }
}

