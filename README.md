# 阿里云基础设施的playbook



## Roles清单

### base

* Disable selinux 
* Install the EPEL repo
* Replace repos with aliyun mirrors
* Import GPG keys
* Install basic tools and packages
* Install basic pip packages

### nginx
* Install nginx
* Start nginx service

### iptables
* Install iptables
* Start iptables service
* Set the policy for the INPUT chain to access
* Allow ESTABLISHED, RELATED in INPUT chain
* Allow ports in INPUT chain
* Remove ports in INPUT chain
* Set the policy for the INPUT chain to drop

### php (both php5 and php7 with sphinx, apcu, memcache, memcached and redis)

### nodejs

### dnsmasq

### openldap

### nfs

### redis

### memcache

### elasticsearch

### rabbitMQ

### mongodb



## 入口文件列表



## 注意事项