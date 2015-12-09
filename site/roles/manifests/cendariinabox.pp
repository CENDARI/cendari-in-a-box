# role class for full 'CENDARI-in-a-box'
#
class roles::cendariinabox {

  class { 'cendari':
    variant     => 'cendariinabox',
    manage_repo => true,
  }

}
