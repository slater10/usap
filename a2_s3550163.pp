

class config {

}

class base {

} 



class packages {

	package { 'csh': ensure => installed }
	package { 'vim': ensure => installed }
	package { 'links': ensure => installed }



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







