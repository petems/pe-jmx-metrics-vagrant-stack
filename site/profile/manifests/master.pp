class profile::master {

  include profile::metrics::jmx::puppet_master

  service { 'puppet':
    ensure => running,
    enable => true,
  }

}

