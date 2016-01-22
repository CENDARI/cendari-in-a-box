# == Class: profiles::tomcat7
#
class profiles::tomcat7 {

  package {
    'openjdk-6-jdk':            ensure => absent;
    'openjdk-6-jre':            ensure => absent;
    'openjdk-6-jre-headless':   ensure => absent;
    'openjdk-6-jre-lib':        ensure => absent;
  }

  ensure_packages(['openjdk-7-jre-headless','tomcat7'])

  service { 'tomcat7':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['tomcat7'],
  }

}

