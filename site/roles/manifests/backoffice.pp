# role class for backoffice
#
class roles::backoffice {

  include 'roles::backoffice_setup'

  class { 'cendari':
    variant     => 'backoffice',
    manage_repo => true,
  }

}
