# profile class for frontoffice
#
class profiles::frontoffice {

  include '::profiles::apache'

  include '::apache::mod::headers'
  include '::apache::mod::proxy'
  include '::apache::mod::proxy_http'

  class { '::apache::mod::fcgid':
    options => {'AddHandler' => 'fcgid-script .fcgi'},
  }


}
