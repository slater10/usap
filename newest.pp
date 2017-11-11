
class enable_services {


  service { 'puppet':
    enable => true,
    ensure => running
  }
  
  
  service { 'mariadb':
    enable => true,
	ensure => running
  }


  service { 'sshd':
    enable => true,
	ensure => running
  } 
 
  service { 'httpd': 
	enable => true, 
	start => true,
	ensure => running
  }
}


class base {


	package  { 'rubygems': ensure => installed }

	package { 'puppet-lint':

		ensure   => 'installed',

		provider => 'gem',

		require  => Package['rubygems'],

	}
	
	yumrepo { "epel" :

		baseurl  => "http://fedora.melbourneitmirror.net/epel/7/x86_64/",
		descr    => "epel",
		enabled  => 1,
	gpgcheck => 0,

	}

        case $::osfamily {

        'redhat': {
        
		$packagename = 'fuse-sshfs'
        
		}


        default: {
		
		$packagename = 'sshfs'
        
		}

	}

        package { $packagename:
                ensure  => installed,
		require => Yumrepo['epel'],
        }

	package { 'ruby-augeas': 
		ensure => installed, 
		require => Yumrepo['epel'],
	}

	package { 'augeas':
		ensure => installed,
		require => Yumrepo['epel']
	}

} 



class config {

#augeas { "configure_httpd_config":
#	context => '/files/etc/httpd/conf/httpd.conf',
#	changes => [
#			set ''
#
#}


  # add a notify to the file resource
  file { '/etc/ssh/sshd_config':
    notify  => Service['sshd'],  # this sets up the relationship
    mode    => '0600',
    require => Package['openssh'],
  }

 host { 'titan_server':
    ip           => '131.170.5.131',
    host_aliases => 'titan',
  }

host { 'jupiter_server':
	ip  => '131.170.5.135',
	host_aliases => 'jupiter'
}

host { 'saturn_server':
	ip  => '131.170.5.132',
	host_aliases => 'saturn'
}


#augeas { "configure_sudoers":
#	context => '/files/etc/sudoers',
#	changes => "set spec[user = 'Becca']/user Becca",
#	lens => '@Sudoers'
#}





file { '/var/www':
   ensure => 'link',
   target => '/s3550163',
   force => true,
}


augeas { "configure_sshd":
	context	=> "/files/etc/ssh/sshd_config",
	changes	=>	[ 	
				"set PermitRootLogin no",
				"set PasswordAuthentication yes"
			],
}

augeas { "configure_runinterval":
	context	=> "/files/etc/puppetlabs/puppet/puppet.conf/main",
	changes	=>	[
				"set runinterval 1200",
	
			],
}
	



}



class packages {

	Package { ensure => 'installed' }
	$packages = [ 'hiera', 'csh', 'openssh', 'httpd', 'tmux', 'mariadb', 'mariadb-server', 'vnc-server', 'gcc', 'gdb', 'cgdb', 'dia', 'vim', 'emacs' ]
	package { $packages: }


}

class users {

	user { 'Becca':
		ensure     => present,
		groups     => ['sysadmin', 'cars'],
		home       => '/home/Becca',
		managehome => true,
		uid        => 10010163,
		shell      => '/bin/bash'	

	}

	user { 'Fred':
		ensure     => present,
		uid        => 10020163,
		groups     => ['trucks', 'cars' ],
		home       => '/home/Fred',
		managehome => true,
		shell      => '/bin/csh',
	}

	user { 'Wilma':
		ensure     => present,
		home       => '/home/wilma',
		managehome => true,
		uid        => 10030163,
		groups     => ['trucks', 'cars', 'ambulances'],
		shell      => '/bin/bash'
	}


}

class groups {

	group { trucks:
		ensure => present
	}

	group { cars:
		ensure => present
	}

	group { sysadmin:
		ensure => present
	}

	group { ambulances:
		ensure => present
	}


}



