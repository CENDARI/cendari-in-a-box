# role class for backoffice_setup
#
class roles::backoffice_setup {

  include 'profiles::tomcat7'
  include 'profiles::apache'

}
