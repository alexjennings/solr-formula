solr-formula
============

* Installs Oracle JDK
* Installs Solr
* Sets defaults zookeeper server
* Adds Jetty service running solr
* Adds custom solr config/schema

Installation
--

* Install VirtualBox - https://www.virtualbox.org/wiki/Downloads
* Install Vagrant - http://downloads.vagrantup.com/
* Download a zip or git clone this project.
* In a terminal, change into the extracted directory and run ```vagrant up```
* Two virtual machines will be created
* Select Interface to bridge to (i.e. ethernet).
* SSH into virtual machine ```vagrant ssh vagrantsolr1``` and ```vagrant ssh vagrantsolr2```
* This VM will also be accessible on the private address ```192.168.0.21``` and ```192.168.0.22```


Usage
--

Use with zookeeper-formula 


Default Pillar Values:
--
```
jdk:
  version: <version of Oracle's JDK to install, defaults to '1.7.0_21'>

solr:
  version: <SOLR version to deploy, defaults to '4.4.0'>
  schema: <Custome schema version to deploy, defaults to '4.1'>
  config: <Custom config version to deploy, defaults to '4.1'>

zookeeper:
  ip: <IP Address of Zookeeper, defaults to '192.168.0.11'>

```
