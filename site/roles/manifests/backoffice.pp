# role class for backoffice
#
class roles::backoffice {

  class { 'cendari':
    variant     => 'backoffice',
    manage_repo => true,
  }

  include '::profiles::backoffice'

}
