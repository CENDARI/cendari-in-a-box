# role class for backoffice
#
class roles::backoffice {

  include '::profiles::backoffice'

  class { 'cendari':
    variant     => 'backoffice',
    manage_repo => true,
  }

}
