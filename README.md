# PLAYBOOKS FOR ALI-ESC

[TOC]

## Roles list

### Base

* Disable selinux 
* Install the EPEL repo
* Replace repos with aliyun mirrors
* Import GPG keys
* Install basic tools and packages
  * lsof
  * telnet
  * vim 
  * tree
  * libselinux-python
  * yum-utils
  * python-pip
  * bind-tools
  * iptalbes-services
* Install basic pip packages
* Kernel tweaks

### Nginx
* Version: 1.16.1

### Iptables
* version: 1.4.21

### PHP (Both php5 and php7 with sphinx, apcu, memcache, memcached and redis)
* php5
    * version: 5.6.40  (php-remi: 5.6.40)
    * Extensions:
      * Redis: 4.3.0 (remi: 3.1.6)
      * Memcache: 2.2.7 (remi: 3.0.8)
      * Memcached: 2.2.0
      * Apcu: 4.0.11
      * Sphinx: 1.3.0 (remi: 1.3.3)
    * running socket or ports

* php7
    * Version: 7.2.24 (7.2.25 - remi repository)
    * Extensions:
      * Apcu: 5.1.11 (remi: 5.1.18)
      * Redis: 5.1.1
      * Mcrypt: 1.0.3(2.5.8) 
      * Memcached: 3.0.4 (remi: 3.1.4)
      * Memcache: 4.0.4
      * Sphinx remi only: 1.4.0-dev

### Sphinx

* Version: coreseek-4.1
  * Mmseg-3.2.14
  * Csft-4.1

### NodeJS

* Nvm version: v0.35.1
* Nodejs version: v12.13.0

### Dnsmasq

*  Version: 2.76-10

### OpenLDAP

* some unknown error occured after installing

### redis
* Version: 3.2.12

### memcached

* Version: 1.4.15-10


### RabbitMQ

* Version: 3.3.5-34

### Mongodb

* Version: 2.6.12-6

### Rsyslog

* Version: 8.24.0-41


### NFS (#)
### Elasticsearch (#)


## entries

### template

Reference testing.yml for more info.



## notes

### 配置相关

