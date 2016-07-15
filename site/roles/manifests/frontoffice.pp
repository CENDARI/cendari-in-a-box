# role class for frontoffice
#
class roles::frontoffice {

  include '::profiles::frontoffice'

  class { 'cendari':
    variant     => 'frontoffice',
    manage_repo => true,
  }

}

