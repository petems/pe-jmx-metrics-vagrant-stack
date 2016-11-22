class profile::grafana {

  class { '::grafana':
    version => '3.0.1',
  }
  ->
  grafana_datasource { 'Graphite':
    ensure           => present,
    type             => 'graphite',
    url              => 'http://127.0.0.1:80',
    access_mode      => 'proxy',
    is_default       => true,
    grafana_url      => 'http://127.0.0.1:3000',
    grafana_user     => 'admin',
    grafana_password => 'admin',
  }
  ->
  grafana_dashboard { 'Puppetserver JMX Stats':
    ensure           => present,
    grafana_url      => 'http://127.0.0.1:3000',
    grafana_user     => 'admin',
    grafana_password => 'admin',
    content          => epp('profile/jmx_dashboard.json.epp'),
  }

}
