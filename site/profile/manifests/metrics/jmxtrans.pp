# Class: profile::metrics::jmxtrans
#
# Include base requirements for metrics collection with jmxtrans.
#
class profile::metrics::jmxtrans {
  include ::java

  case $facts['os']['family'] {
    'RedHat': {
      $package_name = 'jmxtrans'
      $service_name = 'jmxtrans'
    }
    default: {
      fail("profile::metrics::jmxtrans does not support OS '${facts['os']['name']}'")
    }
  }

  class { '::jmxtrans':
    package_name        => $package_name,
    service_name        => $service_name,
    package_source      => 'http://central.maven.org/maven2/org/jmxtrans/jmxtrans/254/jmxtrans-254.rpm',
    manage_service_file => true,
  }

  contain ::jmxtrans
}
