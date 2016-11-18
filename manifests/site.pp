## site.pp ##

# Disable filebucket by default for all File resources:
# http://docs.puppetlabs.com/pe/latest/release_notes.html#filebucket-resource-no-longer-created-by-default
File { backup => false }


node 'grafana.puppetlabs.vm' {
  include ::profile::graphite
  include ::profile::grafana
}

node 'puppet-master.puppetlabs.vm' {
  include ::profile::master
  include ::profile::code_manager
}

node default {
}

