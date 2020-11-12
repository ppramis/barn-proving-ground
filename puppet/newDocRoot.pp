file { '/data':
  ensure => directory,
  owner => 'ec2-user',
  group => 'ec2-user',
}

file { '/data/www':
  ensure => directory,
  owner => 'ec2-user',
  group => 'ec2-user',
}

file { '/data/www/html':
  ensure => directory,
  owner => 'ec2-user',
  group => 'ec2-user',
}

file { '/data/www/html/index.html':
  ensure => file,
  owner => 'ec2-user',
  group => 'ec2-user',
  content => "This file managed by Puppet.\n\nThis is the new index.html page at /data/www/html.\n",
}