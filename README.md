# Packer Image Builder for RHEL Family

## Introduction

This repository started by using the [veewee templates](https://github.com/jedi4ever/veewee/tree/master/templates) for Centos OS. They have been adapted and improved. Furthermore the build mechanism changed. Instead of maintaining multiple templates for RedHat, Centos and Oracle Linux we use the same scripts for all of them. Currently this templates support

 - RedHat 6.5
 - Centos 6.5
 - Oracle Linux 6.5

For all operating systems we generate images for 

 - Virtual Box (user: packer/packer)
 - VmWare (user: packer/packer)
 - OpenStack

This template only is tested against 64 bit systems. 

## Requirements

The templates are only tested with [packer](http://www.packer.io/downloads.html) 0.5.2 and later.

## Run conversion process

    # Build CentOS virtualbox image
    PACKER_LOG=1 packer build -only="centos-65-vbox" rhel65.json

    # Build Oracle Linux virtualbox image
    PACKER_LOG=1 packer build -only="oel-65-vbox" rhel65.json

## Build cloud images for openstack

### CentOS

    # Build CentOS openstack image and compress qcow2 image before 
    # upload (normally from 4.5 GB to less than 500 MB)
    packer build -only="centos-65-cloud-kvm" rhel65.json

    # Reduce the file size
    qemu-img convert -c -f qcow2 -O qcow2 -o cluster_size=2M img_centos_65_openstack/centos65_openstack.qcow2 img_centos_65_openstack/centos65_openstack_compressed.qcow2

    # Upload the file to open stack
    glance image-create --name "CentOS 6.5" --container-format ovf --disk-format qcow2 --file img_centos_65_openstack/centos65_openstack_compressed.qcow2 --is-public True --progress

### Oracle Linux

    # Build Oracle Linux openstack image and compress qcow2 image before 
    packer build -only="oel-65-cloud-kvm" rhel65.json
    
    # Reduce the file size
    qemu-img convert -c -f qcow2 -O qcow2 -o cluster_size=2M img_oel_65_openstack/oel65_openstack.qcow2 img_oel_65_openstack/centos65_openstack_compressed.qcow2
    
    # Upload the file to open stack
    glance image-create --name "OEL 6.5" --container-format ovf --disk-format qcow2 --file img_oel_65_openstack/centos65_openstack_compressed.qcow2 --is-public True --progress

### RedHat

Before you start with RedHat you need a valid subscription to download the latest iso image. Update the `iso_url` parameter in rhel65.json accordingly. Additionally you need to modify the file `scripts/rhn_reg` with your user credentials to recieve yum updates during the packer run.

    # Build RedHat openstack image
    packer build -only="rhel-65-cloud-kvm" rhel65.json

    # Reduce the file size
    qemu-img convert -c -f qcow2 -O qcow2 -o cluster_size=2M rhel65_openstack.qcow2 rhel65_openstack_compressed.qcow2

    # Upload the file to open stack
    glance image-create --name "RedHat 6.5" --container-format ovf --disk-format qcow2 --file rhel65_openstack_compressed.qcow2 --is-public True --progress

## Issues during build time

If you experience issues with packer, please use `PACKER_LOG=1 packer ... ` to find the errors.

## Author

 - Author:: Christoph Hartmann (<chris@lollyrock.com>)

# License

Company: Deutsche Telekom AG

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
