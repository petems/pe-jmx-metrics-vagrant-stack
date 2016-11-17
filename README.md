# PE JMX Metrics Server Vagrant Stack

This Vagrant stack includes 2 virtual machines:

| VM Name       | Description |
|---------------|-------------|
| puppet-master | Monolithic install of PE 2016.4.2 on CentOS 7, with JMX enabled and transmitting to graphite |
| grafana       | Graphite and Grafana server              |

The `grafana` VM is setup to install Graphite and Grafana using most of the basic configuration required to get them up and running, Graphite hosted by Apache, Grafana running vanilla on port 3000.

The goal of the stack is to demonstrate JMX metrics into Graphite/Grafana, specificall the metrics from the Puppet Server stack.

## Grafana Access

You can reach the Grafana Server UI on port **3000**

Username is: **admin**
Password is: **admin**

## What this stack does for you

The stack sets up a PE 2016.4.2 puppet master with JMX enabled on 1099 and transmitting to Graphite on port 2003, with a Grafana instance providing the GUI.

### What's being automated?

* Install PE Puppet Master
* Auto-configure the modules to be installed on the master
* Setup the master with JMX enabled on puppetserver, port 1099
* Graphite taking in JMX metrics on port 2003
* Creates a basic Grafana dashboard with Puppet Server metrics

### Screenshot

<img width="1432" alt="JMX Stats" src="https://cloud.githubusercontent.com/assets/1064715/20410613/d927651c-ad15-11e6-9f9b-80814b24154a.png">

## Other Notes

This is based on the puppet-debugging-kit.

https://github.com/Sharpie/puppet-debugging-kit
