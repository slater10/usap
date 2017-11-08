
class enable_services {


  service { 'puppet':
    enable => true,
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

		ensure   => '1.1.0',

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


augeas { "configure_sshd":
	context	=> "/files/etc/ssh/sshd_config",
	changes	=>	[ 	
				"set PermitRootLogin no"
			],
}

        ini_setting { 'agent_runinterval':

                ensure  => present,
                path    => "/etc/puppetlabs/puppet/puppet.conf",
                section => "main",
                setting => "runinterval",
                value   => "1200",

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



