# boot2docker-vagrant-extension

## Introduction

Standard extension files proposal for a vagrant boot2docker environment.

**It should run with [vagrant-boot2docker-box](https://github.com/AlbanMontaigu/boot2docker-vagrant-box) and a project with [vagrant-boot2docker-template](https://github.com/AlbanMontaigu/boot2docker-vagrant-template) included all with appropriate versions.**

This extension is the heart of environment features and commands but **the finest part will comme from [docker-toolbox](https://github.com/AlbanMontaigu/docker-toolbox)** that you can run with ```dk tb``` command. This will bring you in a custom container with compose and lot of other commands. To exit, just type ```exit```.

**Important:** please note that all indications below consider that you are in your box run with the [vagrant-boot2docker-template](https://github.com/AlbanMontaigu/boot2docker-vagrant-template).

## Available commands

Each command has integrated help, just type the command to see detailed usage.

### Box commands

**b2d = commands to manage your boot2docker environment.**

Just type ```b2d``` to see available commands list.

### Custom docker commands

**dk = docker alias with enhancements.**

For all the **docker** commands please refer to the [official documentation](https://docs.docker.com/reference/commandline/cli/).

Just type ```dk``` to see available commands list.

### Custom docker compose commands

**dc = docker-compose utilities for your boot2docker environment.**

Just type ```dc``` to see available commands list.

## Files and folders description

### ash

Here you have all custom commands loaded in your environment by this extension.

### b2d-syncd

Daemon to auto sync small files modifications between the host and the box.

### bootlocal.sh.d

Contains all scripts dynamically run by ```bootlocal.sh```.

### dk-redsocks

Contains daemon files to run a redsocks docker container an allow transparent proxy management for containers.

### param.d

All persistent parameter requested by the extension.

### provision.sh.d

Contains all scripts dynamically run by ```provision.sh```.

### proxy

Contains all your custom proxy definition to load them as a simple profile with built in ```b2d proxy``` commands.

### bootlocal.sh, param.sh, provision.sh

Twin script with same ones in the [boot2docker-vagrant-template](https://github.com/AlbanMontaigu/boot2docker-vagrant-template) project.

Their twin's in the template project will execute them one in the same stage. Read their docs to know what are their goals.

## Known bugs and built-in workaround

### Files synchronization between your host and the box

By default, files are shared between your host and your box with *Virtualbox Guest additions* system.

For very small modifications on your files on your host, it may not sync with your boot2docker. Since ```1.10.2``` I have added some ```b2d-syncd``` daemon to refresh regularly the files *(every 2 sec)*. This can do some small overload so you can stop it with ```b2d syncd stop``` and do a manual ```b2d sync``` when requested.
