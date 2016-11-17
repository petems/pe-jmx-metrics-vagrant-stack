# Defined type: profile::metrics::jmxtrans::jvmcore
#
# Configure core JVM metrics shipping with jmxtrans.
#
define profile::metrics::jmx::jvmcore (
  String[1] $host,
  Integer $port,
  String[1] $graphite_host = 'graphite.example.com',
) {

  $graphite = {
    host => $graphite_host,
    port => 2003,
    root => "jmxtrans.${facts['hostname']}",
  }

  $queries = [
    {
      object       => 'java.lang:type=ClassLoading',
      attributes   => ['LoadedClassCount', 'TotalLoadedClassCount', 'UnloadedClassCount'],
      result_alias => 'lang.ClassLoading',
    },
    {
      object       => 'java.lang:type=GarbageCollector,*',
      type_names   => ['name'],
      attributes   => ['LastGcInfo'],
      result_alias => 'lang.GarbageCollector',
    },
    {
      object       => 'java.lang:type=Memory',
      attributes   => ['HeapMemoryUsage', 'NonHeapMemoryUsage'],
      result_alias => 'lang.Memory',
    },
    {
      object       => 'java.lang:type=Runtime',
      attributes   => ['Uptime'],
      result_alias => 'lang.Runtime',
    },
    {
      object       => 'java.lang:type=Threading',
      attributes   => ['ThreadCount', 'TotalStartedThreadCount', 'PeakThreadCount'],
      result_alias => 'lang.Threading',
    },
  ]

  jmxtrans::query { "${title}.java":
    host     => $host,
    port     => $port,
    graphite => $graphite,
    queries  => $queries,
  }
}
