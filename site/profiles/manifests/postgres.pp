# == Class: profiles::postgres
#
class profiles::postgres {

  # install postgres
  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => '9.3',
  } ->
  class { 'postgresql::server':  needs_initdb => true, }

  ensure_packages(['postgresql-contrib-9.3','postgresql-server-dev-9.3'])

  # need to initialize postgres cluster
  exec { 'pg_createcluster':
    path        => ['/usr/bin','/bin'],
    environment => ['LC_ALL=C'],
    command     => 'pg_createcluster --start -u postgres -g postgres 9.3 main',
    unless      => "pg_lsclusters -h | awk '{ print \$1,\$2; }' | egrep '^9.3 main\$'",
  }

}

