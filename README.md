# 阿里云基础设施的playbook

## Roles清单

### Base

* Disable selinux 
* Install the EPEL repo
* Replace repos with aliyun mirrors
* Import GPG keys
* Install basic tools and packages
* Install basic pip packages
* Kernel tweaks

### Nginx
* Version: 1.16.1

### Iptables
* version: 1.4.21

### PHP (Both php5 and php7 with sphinx, apcu, memcache, memcached and redis)
* php5
    * version: 5.6.40
    * Extensions:
      * Redis: 4.3.0
      * Memcache: 2.2.7
      * Memcached: 2.2.0
      * Apcu: 4.0.11
      * Sphinx: 1.3.0
* php7
    * Version: 7.2.24
    * Extensions:
        * Apcu: 5.1.11
        * Redis: 5.1.1
        * Mcrypt: 1.0.3(2.5.8)
        * Memcached: 3.0.4
        * Memcache: 4.0.4
### NodeJS

* Nvm version: v0.35.1
* Nodejs version: v12.13.0

### Dnsmasq

*  Version: 2.76-10

### OpenLDAP

### NFS (#)

### Redis

### Memcache

### Elasticsearch (#)

### RabbitMQ

### Mongodb

### Rsyslog






## 入口文件列表



## 注意事项

