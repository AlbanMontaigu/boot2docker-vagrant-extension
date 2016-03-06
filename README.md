# boot2docker-vagrant-extension

## Introduction

Standard extension files proposal for a vagrant boot2docker environment.

It should run with [vagrant-boot2docker-box](https://github.com/AlbanMontaigu/boot2docker-vagrant-box) and a project with [vagrant-boot2docker-template](https://github.com/AlbanMontaigu/boot2docker-vagrant-template) included.

All with appropriate versions :).

## Files synchronization between your host and your boot2docker

By default, files are shared between your host and your boot2docker with Virtualbox Guest additions system. 

You have differnts ways to achieve that sync, see [vagrant documentation](https://www.vagrantup.com/docs/synced-folders/).

**Known bug:** for very small modifications on your files on your host, it may not sync with your boot2docker. Since ```1.10.2``` I have added some ```b2d-syncd``` daemon to refresh regularly the files *(every 2 sec)*. This can do some small overload so you can stop it with ```b2d syncd stop``` and do a manual ```b2d sync``` when requested.

## Custom commands

### boot2docker commands

- ```b2d sync``` if your files (especially for very small modifications) doesn't sync very well between your computer and boot2docker try this command
- ```b2d synd start/stop/status``` management of ```b2d-syncd```daemon *(activated by default)*

### Custom docker and compose commands

- ```dk toolbox``` or ```dk tb``` runs and go into your [docker-toolbox](https://github.com/AlbanMontaigu/docker-toolbox)
- ```dk toolbox update``` to update the toolbox
- ```dk proxy``` to get all proxy param in a docker parameter way for your containers
- ```dc prefix``` changes the docker compose prefix

For all the **docker** commands please refer to the [official documentation](https://docs.docker.com/reference/commandline/cli/).

## Improved enviroment with custom docker-toolbox

To enjoy more commands and features, go in [docker-toolbox](https://github.com/AlbanMontaigu/docker-toolbox) with this command: ```dk tb```.

This will bring you in a custom container with compose and lot of other commands.

To exit, just type ```exit```.
