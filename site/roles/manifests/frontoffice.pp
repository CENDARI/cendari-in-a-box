# role class for frontoffice
#
class roles::frontoffice {

  class { 'cendari':
    variant     => 'frontoffice',
    manage_repo => true,
  }

  include '::profiles::frontoffice'

}

