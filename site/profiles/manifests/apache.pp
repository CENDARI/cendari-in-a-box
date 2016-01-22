# Class profiles::apache
#
class profiles::apache {

  # install apache from puppetlabs module
  class { '::apache': }

  apache::listen { '80': }

}

