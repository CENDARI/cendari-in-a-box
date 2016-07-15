# Class profiles::apache
#
class profiles::apache {

  # install apache from puppetlabs module
  class { '::apache':
    mpm_module    => 'prefork',
    default_vhost => false,
    before        => Anchor['cendari::begin'],
  }

  include '::apache::mod::php'

  ::apache::mod { 'rewrite':
    before => Anchor['cendari::begin'],
  }
  ::apache::mod { 'wsgi':
    before => Anchor['cendari::begin'],
  }

  ::apache::listen { '80':
    before => Anchor['cendari::begin'],
  }

  # x-sendfile for use by NTE
  include ::apache::mod::xsendfile

  # install php packages
  ensure_packages(['php5-curl','php5-fpm','php5-mysql','php-apc','php5-xsl','php5-json','php5-cli'])

  Package['php5-cli'] ->  Anchor['cendari::begin']


  # put together vhost config
  $cendarivhost = "/etc/apache2/sites-enabled/${::fqdn}.conf"
  concat { $cendarivhost:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['apache2'],
  }


  # start vhost's config
  concat::fragment{'apache_default_head':
    target  => $cendarivhost,
    content => "
#####################
# MANAGED BY PUPPET #
#####################

<VirtualHost *:80>
  ServerName ${::fqdn}
  ServerAdmin root@localhost

  DocumentRoot \"/var/www/html\"

  ErrorLog \"/var/log/apache2/${::fqdn}_error.log\"
  CustomLog \"/var/log/apache2/${::fqdn}_access.log\" combined

    ",
    order   => '1',
  }

  # end vhost's config
  concat::fragment{'apache_default_tail':
    target  => $cendarivhost,
    content => '
  RewriteEngine on
  RewriteRule ^/Shibboleth.sso / [R=301,L]

</VirtualHost>
     ',
    order   => '9',
  }

  file { '/var/www/html/index.html':
    content => '<h1>CENDARI in a box</h1><ul>
    <li><a href="/atom2">AtoM</a></li>
    <li><a href="/ckan">CKAN</a></li>
    <li><a href="/docs">docs</a></li>
    <li><a href="/notes">NTE</a></li>
    <li><a href="/ontologies">Ontologies</a></li>
    <li><a href="/pineapple">Pineapple</a></li>
    </ul>',
    require => Class['::apache'],
  }

}

