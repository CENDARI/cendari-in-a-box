# CENDARI in a box

This repository contains the code to build an empty CENDARI VM from the official
[CENDARI puppet module](https://github.com/CENDARI/puppetmodule-cendari).

## Getting Started

Install

* VirtualBox
* [Vagrant](https://www.vagrantup.com/), at least 1.7
* [librarian-puppet](http://librarian-puppet.com/)

Run

`librarian-puppet update`

Run

`vagrant up`

## Configuration

Once finished, the server will contain all software, but **no data**!
In particular, you will have to manually import/initialize the databases:

```
vagrant ssh
sudo -i

gunzip -k /vagrant/vagrantdata/ckan.sql.gz
sudo -u postgres pg_restore -d ckan < /vagrant/vagrantdata/ckan.sql

service litef-conductor restart

gunzip -k /vagrant/vagrantdata/atom2.sql.gz
mysql atom2 < /vagrant/vagrantdata/atom2.sql

cd /var/www/notes
sudo -u www-data fab sync_database
```

## Use

You should set up DNS resolution locally, i.e. on Linux/OSX add
`192.168.33.55 box.cendari.local` to `/etc/hosts`.
Than you can access from your browser at `http://box.cendari.local`.

* To use AtoM, login as with `admin@local.host`/`admin`.
* The CKAN admin is `default`/`password`.

## Warning

The usernames and passwords used internally default to those set in cendari's `params.pp`
and the data from hiera respectively and are plainly visible!

