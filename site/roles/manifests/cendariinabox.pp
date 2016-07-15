# role class for full 'CENDARI-in-a-box'
#
class roles::cendariinabox {

  include '::profiles::frontoffice'
  include '::profiles::backoffice'

  class { 'cendari':
    variant     => 'cendariinabox',
    manage_repo => true,
  }

}
