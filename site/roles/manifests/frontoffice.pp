# role class for frontoffice
#
class roles::frontoffice {

  include 'roles::frontoffice_setup'

  class { 'cendari':
    variant     => 'frontoffice',
    manage_repo => true,
  }

}

