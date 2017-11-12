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
    password   => '$SKgvUnI6$nhbaLPjtaA1lrkE.b7rwmXdmks8L5NN37RCsVyegmYu7YLk4kzfeNBHlblAwU/5oFOPItQDjcpREzHK6GYLw9/'
  }

  # creating the user 'Wilma'
  user { 'Wilma':
    ensure     => present,
    home       => '/home/wilma',
    managehome => true,
    uid        => 10030163,
    groups     => ['trucks', 'cars', 'ambulances'],
    shell      => '/bin/bash',
    password   => '$etAvKuUL$39J3Z/6Yj1oCzU0U9auiceKVi4H4rDy8Kkf.A.hOqlITFouh5.CEGSSdQzUr/jZln5HRVTSj9emljQY9/cOFo0'
  }

}

