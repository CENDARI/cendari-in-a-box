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

## Warning

The usernames and passwords used internally default to those set in cendari's `params.pp`
and the data from hiera respectively and are plainly visible!

