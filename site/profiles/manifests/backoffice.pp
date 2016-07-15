# profile for backoffice
#
class profiles::backoffice {

  include '::profiles::tomcat7'
  include '::profiles::apache'
  include '::profiles::mysql'
  include '::profiles::elasticsearch'


  mysql::db { $::cendari::atom_mysql_db:
    user     => $::cendari::atom_mysql_user,
    password => $::cendari::atom_mysql_password,
    host     => 'localhost',
    grant    => ['ALL'],
  }


  concat::fragment{'apache_backoffice':
    target  => $::profiles::apache::cendarivhost,
    content => '
    Alias /atom2 /var/www/atom2

    <Directory /var/www/atom2>
      Options SymLinksIfOwnerMatch
      AllowOverride None
      Require all granted
    </Directory>

    <Location /atom2>
      Require all granted
    </Location>


    WSGIDaemonProcess ckan processes=2 threads=15 python-path=/var/www/ckan:/var/www/ckan/lib/python2.7/site-packages
    WSGIScriptAlias /ckan /etc/ckan/apache.wsgi

    <Directory /var/www/ckan>
      Options SymLinksIfOwnerMatch
      AllowOverride None
      Require all granted
    </Directory>

    # Pass authorization info on (needed for rest api).
    WSGIPassAuthorization On

    <Location /ckan>
      WSGIProcessGroup ckan
      Require all granted
    </Location>

    Alias /pineapple /var/www/pineapple/public

    <Directory /var/www/pineapple/public>
      Options SymLinksIfOwnerMatch
      AllowOverride All
      Require all granted
    </Directory>


    <Location /pineapple>
      Require all granted
    </Location>
    ',
    order   => '7',
  }


}
