# boot2docker-vagrant-config

## Introduction

Standard configuration files proposal for a vagrant boot2docker environment.

It should run with [vagrant-boot2docker-box](https://github.com/AlbanMontaigu/boot2docker-vagrant-box) and a project with [vagrant-boot2docker-template](https://github.com/AlbanMontaigu/boot2docker-vagrant-template) included.

All with appropriate versions :).

## Main (custom) commands

- ```b2d-sync``` if requested to force resync of files between your laptop and your boot2docker

## Main (custom) docker commands

- ```dk-toolbox``` runs and go into your [docker-toolbox](https://github.com/AlbanMontaigu/docker-toolbox)
- ```dk-toolbox-update``` to update the toolbox
- ```dk-proxy-env``` to get all proxy param in a docker parameter way for your containers
- ```dc-prefix``` changes the docker compose prefix


For all the **docker** commands please refer to the [official documentation](https://docs.docker.com/reference/commandline/cli/).
