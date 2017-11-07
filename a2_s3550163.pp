class config {

}

class base {
	
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

} 


class packages {

	Package { ensure => 'installed' }
	$packages = [ 'openssh', 'httpd', 'tmux', 'mariadb', 'mariadb-server', 'vnc-server', 'gcc', 'gdb', 'cgdb', 'dia', 'vim', 'emacs' ]
	package { $packages: }

}

class users {

	user { 'Becca':
		ensure => present,
		groups => ['sysadmin', 'cars'],
		home => '/home/Becca',
		managehome => true,
		uid => 10010163,
		shell => '/bin/bash'	

	}

	user { 'Fred':
		ensure => present,
		uid => 10020163,
		groups => ['trucks', 'cars' ],
		home => '/home/Fred',
		managehome => true,
		shell => '/bin/csh',
	}


	user { 'Wilma':
		ensure => present,
		home => '/home/wilma',
		managehome => true,
		uid => 10030163,
		groups => ['trucks', 'cars', 'ambulances'],
		shell => '/bin/bash'
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







