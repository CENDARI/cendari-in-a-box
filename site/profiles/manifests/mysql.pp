# == Class: profiles::mysql
#
class profiles::mysql {

  class { '::mysql::server':
    root_password           => 'strongpassword',
    remove_default_accounts => true,
  }

}

