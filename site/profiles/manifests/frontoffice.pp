# profile class for frontoffice
#
class profiles::frontoffice {

  include '::profiles::apache'
  include '::profiles::postgres'
  include '::profiles::elasticsearch'

  include '::apache::mod::headers'
  include '::apache::mod::proxy'
  include '::apache::mod::proxy_http'

  class { '::apache::mod::fcgid':
    options => {'AddHandler' => 'fcgid-script .fcgi'},
  }

  concat::fragment{'apache_frontoffice':
    target  => $::profiles::apache::cendarivhost,
    content => '
    Alias /docs /var/www/docs
    <Location /docs>
      Require all granted
    </Location>

    <Directory /var/www/docs>
      Options SymLinksIfOwnerMatch
      AllowOverride None
      Require all granted
    </Directory>


    <Directory /var/www/notes>
      Options SymLinksIfOwnerMatch
      AllowOverride None
      Require all granted
    </Directory>

    Alias /notes/static /var/www/notes/static
    Alias /notes/media /var/www/notes/media
    Alias /robots.txt /var/www/notes/static/robots.txt
    Alias /favicon.ico /var/www/notes/static/favicon.ico
    AliasMatch ^/([^/]*\.css) /var/www/notes/static/styles/$1
    WSGIDaemonProcess notes processes=8 threads=20 python-path=/var/www/notes:/var/www/notes/lib/python2.7/site-packages
    WSGIScriptAlias /notes /var/www/notes/cendari/wsgi.py

    <Location /notes>
      WSGIProcessGroup notes
      WSGIApplicationGroup django

      XSendFile on
      XSendFilePath /var/www/notes
    </Location>

    ProxyPass /ontologyuploader http://localhost:8080/ontologyuploader
    ProxyPassReverse /ontologyuploader http://localhost:8080/ontologyuploader
    ProxyRequests     Off
    ProxyPreserveHost On

    <Location /ontologyuploader >
      Require all granted
    </Location>

    Alias /ontologies /var/www/ontologies
    <Directory /var/www/ontologies>
      Options SymLinksIfOwnerMatch
      AllowOverride None
      Require all granted
    </Directory>

    ',
    order   => '3',
  }


}
