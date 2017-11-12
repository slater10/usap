# this will create the users, and assignment them and id and groups etc
class users {

  # creating user 'Becca'
  user { 'Becca':
    ensure     => present,
    groups     => ['sysadmin', 'cars'],
    home       => '/home/Becca',
    managehome => true,
    uid        => 10010163,
    shell      => '/bin/bash',
    password   => '$O23Nn9Kb$00PzwTV4wtSGUvOBESji/Dy/sI7maF8IEchtGMJhgRbrY9BbQYahLBAfdPWQpSBzskmf5i1hI5Ve159VlvNNM0'
  }

  # creating the user 'Fred'
  user { 'Fred':
    ensure     => present,
    uid        => 10020163,
    groups     => ['trucks', 'cars', 'wheel' ],
    home       => '/home/Fred',
    managehome => true,
    shell      => '/bin/csh',
    password   => '$6$/AL7yzZx$pRNkYfpqfh8blIQaWX6rYTBB.SuAc/8NYgDY5ZHwuFCNJEHnOSHoHIIsIAITpWAJy24MQm/sgxD3P59p6hSL/1'
  }

  # creating the user 'Wilma'
  user { 'Wilma':
    ensure     => present,
    home       => '/home/wilma',
    managehome => true,
    uid        => 10030163,
    groups     => ['trucks', 'cars', 'ambulances'],
    shell      => '/bin/bash',
    password   => '$6$Ifcwt.uN$dB4Ed6RaA1gVh6UeLA3Ss2Q4huPYIojgtJveyOlqHbBhtpTOIqwYvruM7.dCvV3imaiiNbnqTQJkZoBSJwQUn/'
  }

}

