# role class for full 'CENDARI-in-a-box'
#
class roles::cendariinabox {

  include 'roles::frontoffice_setup'
  include 'roles::backoffice_setup'

  class { 'cendari':
    variant     => 'cendariinabox',
    manage_repo => true,
  }

}
