# == Class: profiles::elasticsearch
#
class profiles::elasticsearch {

  ensure_packages(['openjdk-7-jre-headless'])

  class { '::elasticsearch':
    manage_repo  => true,
    repo_version => '1.4',
    autoupgrade  => true,
    config       => {
      'cluster.name' => 'cendari',
    },
    java_install => false,
  }

  elasticsearch::instance { 'masternode':
    config => {
      'node.master'        => true,
      'node.data'          => true,
      'http.port'          => '9200',
      'transport.tcp.port' => '9300',
    }
  }

}

