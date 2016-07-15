# role class for frontoffice_setup
#
class roles::frontoffice_setup {

  include 'profiles::apache'

  include '::apache::mod::headers'
  include '::apache::mod::proxy'
  include '::apache::mod::proxy_http'

  class { '::apache::mod::fcgid':
    options => {'AddHandler' => 'fcgid-script .fcgi'},
  }


}
