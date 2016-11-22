# Class: profile::metrics::jmx::puppet_master
#
# Configures metrics collection for puppet master services.
#
class profile::metrics::jmx::puppet_master (
  $graphite_host = 'graphite.example.com'
) {

  include ::profile::metrics::jmxtrans

  $graphite = {
    host => $graphite_host,
    port => 2003,
    root => "jmxtrans.${facts['hostname']}",
  }

  $count = ['Count']
  $value = ['Value']
  $histo = ['Max', 'Min', 'Mean', 'StdDev', 'Count', '50thPercentile', '75thPercentile', '95thPercentile', '99thPercentile']

  $attributes = {
    'compiler.compile'                                                    => $histo,
    'compiler.compile.production'                                         => $histo,
    'compiler.evaluate_ast_node'                                          => $histo,
    'compiler.evaluate_main'                                              => $histo,
    'compiler.evaluate_node_classes'                                      => $histo,
    'compiler.evaluate_definitions'                                       => $histo,
    'compiler.evaluate_generators'                                        => $histo,
    'compiler.finish_catalog'                                             => $histo,
    'compiler.set_node_params'                                            => $histo,
    'compiler.create_settings_scope'                                      => $histo,
    'http.active-requests'                                                => $count,
    'http.active-histo'                                                   => $histo,
    'http.total-requests'                                                 => $histo,
    'jruby.borrow-count'                                                  => $count,
    'jruby.borrow-retry-count'                                            => $count,
    'jruby.borrow-timeout-count'                                          => $count,
    'jruby.borrow-timer'                                                  => $histo,
    'jruby.free-jrubies-histo'                                            => $histo,
    'jruby.num-free-jrubies'                                              => $value,
    'jruby.num-jrubies'                                                   => $value,
    'jruby.request-count'                                                 => $count,
    'jruby.requested-jrubies-histo'                                       => $histo,
    'jruby.return-count'                                                  => $count,
    'jruby.wait-timer'                                                    => $histo,
  }

  $queries = $attributes.reduce([]) |$memo, $val| {
    $obj_name = $val[0]
    $obj_attr = $val[1]
    $memo + [{
      object       => "metrics:name=petems.${facts['hostname']}.${obj_name}",
      attributes   => $obj_attr,
      result_alias => "petems.${obj_name}",
    }]
  }

  jmxtrans::query { 'puppetserver':
    host     => $facts['fqdn'],
    port     => 1099,
    graphite => $graphite,
    queries  => $queries,
  }

  profile::metrics::jmx::jvmcore { 'puppetserver':
    host          => $facts['fqdn'],
    graphite_host => $graphite_host,
    port          => 1099,
  }
}
