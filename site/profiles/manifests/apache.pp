# Class profiles::apache
#
class profiles::apache {

  # install apache from puppetlabs module
  class { '::apache':
    mpm_module => 'prefork',
    before     => Anchor['cendari::begin'],
  }

  include '::apache::mod::php'

  ::apache::mod { 'rewrite':
    before => Anchor['cendari::begin'],
  }
  ::apache::mod { 'wsgi':
    before => Anchor['cendari::begin'],
  }

  ::apache::listen { '80':
    before => Anchor['cendari::begin'],
  }

  # x-sendfile for use by NTE
  include ::apache::mod::xsendfile

  # install php packages
  ensure_packages(['php5-curl','php5-fpm','php5-mysql','php-apc','php5-xsl','php5-json','php5-cli'])

  Package['php5-cli'] ->  Anchor['cendari::begin']


}

