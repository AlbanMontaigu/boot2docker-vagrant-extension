# boot2docker-vagrant-config

## Introduction

Standard configuration files proposal for a vagrant boot2docker environment.

It should run with [vagrant-boot2docker-box](https://github.com/AlbanMontaigu/boot2docker-vagrant-box) and a project with [vagrant-boot2docker-template](https://github.com/AlbanMontaigu/boot2docker-vagrant-template) included.

All with appropriate versions :).

## Main (custom) docker commands

- ```dk-ip [container-name-or-id]``` to know current ip of the specified container
- ```dk-killall``` stop all running containers
- ```dk-cleanc``` delete all stoped conainters
- ```dk-cleani```delete untagged images
- ```dk-clean``` do a ```dk-cleanc``` and a ```dk-cleani```
- ```dk ps``` show all running containers
- ```dk ps -a``` show all running and stoped containers
- ```dk images``` show all donloads images
- ```dk-flogs [container-name-or-id]``` show containers logs in a tail way
- ```dk-sh [container-name-or-id]``` opens a terminal in the specified container
- ```dk-ls [container-name-or-id]``` do a ls command in the specified container
- ```dk-cat [container-name-or-id] [file]``` do a cat command in the specified container for the specified file
- ```dk-vi [container-name-or-id] [file]``` do a vi command in the specified container for the specified file

For all the **docker** commands please refer to the [official documentation](https://docs.docker.com/reference/commandline/cli/).

## Main (custom) docker-compose commands

**Here you are in the directory where you have a ```docker-compose.yml``` file**. If you do not have this file, commands won't work.

All these commands will process the services you described in your ```docker-compose.yml``` file.

**Important note: ** all ```dc``` commands are available with the ```dcn``` like command to enable compose and docker networking feature. See the [documentation](https://docs.docker.com/compose/networking/). Be carefull, this introduce breaking changes with the old way to manage links and so on in compose files for example. That's the reason why this feature is separated with a different command.

- ```dc-up``` create start all your services in a daemon mode
- ```dc-init``` if requested stop and delete old containers en recreate then start them. **You should use this command the first time you want to start your sercices or when you want to go from scratch**
- ```dc-reset``` same as ```dc-init``` but without a pull so will be quicker than init
- ```dc start``` start all your containers *(if they have been created before !!)*
- ```dc stop ``` stop all your containres *(if they are started before)*
- ```dc restart ``` restart all your containres *(if they are started before)*
- ```dc start [container-compose-yml-name]``` start a specific container
- ```dc stop [container-compose-yml-name]``` stop a specific container **Do not stop all the containers if you work only with one !**
- ```dc restart [container-compose-yml-name]``` restart a specific container **Do not stop all the containers if you work only with one !**
- ```dc-prefix``` show current compose project name *(will be used as a prefix for containers names)*. Default is ```app``` and will produce containers names like ```app_myname_1```
- ```dc-prefix [newprefix]``` change the project name for compose

For all the **docker-compose** commands please refer to the [official documentation](https://docs.docker.com/compose/reference/).
