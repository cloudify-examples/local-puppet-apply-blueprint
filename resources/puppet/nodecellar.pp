class nodecellar {

  package { 'wget':
    ensure  => present,
  }

  exec { 'nodecellar_source':
    path    => "/bin:/usr/bin",
    command => "wget https://github.com/cloudify-cosmo/nodecellar/archive/master.tar.gz -O /tmp/master.tar.gz",
    unless  => "test -f /tmp/master.tar.gz",
    notify  => Exec['extract_nodecellar'],
  }

  exec { 'extract_nodecellar':
    path        => "/bin:/usr/bin",
    onlyif      => [ "test -f /tmp/master.tar.gz"],
    tries       => 50,
    try_sleep   => 15,
    command     => "tar xzvf /tmp/master.tar.gz",
    unless      => "test -d /tmp/nodecellar-master",
    cwd         => "/tmp",
    notify      => Exec['install_nodecellar'],
  }

  exec { 'install_nodecellar':
    path        => "/bin:/usr/bin",
    onlyif      => [ "test -d /tmp/nodecellar-master"],
    tries       => 9,
    try_sleep   => 10,
    command     => "npm install",
    cwd         => "/tmp/nodecellar-master",
    notify      => Exec['check_mongo'],
  }

  exec { 'check_mongo':
    path        => "/bin:/usr/bin",
    tries       => 9,
    try_sleep   => 10,
    command     => "nc -z mongodb_host 27017",
    notify      => Exec['run_nodecellar'],
  }

  exec { 'run_nodecellar':
    path        => "/bin:/usr/bin",
    onlyif      => [ "test -d /tmp/nodecellar-master/node_modules/express",
                     "test -d /tmp/nodecellar-master/node_modules/mongodb",
                     "test -d /tmp/nodecellar-master/node_modules/morgan",
                     "test -d /tmp/nodecellar-master/node_modules/socket.io" ],
    tries       => 9,
    try_sleep   => 10,
    environment => ["MONGO_PORT=27017","MONGO_HOST=mongodb_host","NODECELLAR_PORT=8080"],
    command     => "nohup nodejs server.js &",
    cwd         => "/tmp/nodecellar-master",
  }

}
