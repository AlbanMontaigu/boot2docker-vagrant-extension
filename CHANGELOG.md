
## 1.12.3 (2016-11-21)
- FEATURE: now transparent proxy will detect host machine proxy listening on 8888 port to use it instead of internals

## 1.12.3 (2016-11-06)
- UPDATE: update to boot2docker 1.12.3
- UPDATE: update to my docker-toolbox 1.12.3
- UPDATE: now sample proxy file is removed since readme gives the right info (avoid unused files)
- UPDATE: no more proxy flags for ```dk tb``` since you can activate transparent proxy
- UPDATE: logs improvements
- UPDATE: now all param load are managed in ```environment.sh```
- FEATURE: docker toolbox container name removed to allow multiple run of ```dk tb``` on the same b2d
- FEATURE: redsocks service removed for transparent-proxy service future use
- FEATURE: [transparent-proxy](https://github.com/AlbanMontaigu/docker-transparent-proxy) service added
- FEATURE: now daemons files are located in ```daemons``` folder
- FEATURE: ```b2d dk ibackup``` command added to backup all your images to a local folder
- FEATURE: ```b2d dk irestore``` command added to restore all your images from a local folder
- FEATURE: ```b2d dk iremove [backups]``` command added to remove all your docker images (```dk rmi``` on all ```dk images```) or backups (ibackup)
- FEATURE: now ```dk_proxyd``` will try to auto detect your proxy context to select the right proxy configuration files (see README.md in the proxy folder)
- FEATURE: ```b2d_dk_ipull``` command added to update all your images
- FEATURE: ```BOOT2DOCKER_EXTENSION_LIB_DIR``` added to share code snippets between multiple locations (ash, bootlocal, ...)
- FEATURE: auto docker pull system now available (with cron param)
- FEATURE: auto docker image backup system now available (with cron param)
- BUGFIX: updated syncd daemon lunching process to avoid bugs when capturing logs with tee on bootlocal

## 1.12.2 (2016-10-25)
- Update to boot2docker 1.12.2
- Update to my docker-toolbox 1.12.2

## 1.12.1f (2016-09-19)
- UPDATE: update to dk tb 1.12.1f
- UPDATE: update to dk tb extension 1.12.1f
- UPDATE: now shell scripts have sh extension for better edition

## 1.12.1e (2016-09-01)
- BUGFIX: Now ```dk proxy update``` is working and not displaying help
- FEATURE: Now ```dk proxy update``` uses env variable (use ```b2d proxy change [PROFILE]``` to change env var)
- FEATURE: Now ```dk tb``` takes in account current proxy values inside itself
- Update to dk tb 1.12.1e
- Update to dk tb extension 1.12.1e

## 1.12.1d (2016-08-31)
- Update to dk tb 1.12.1d
- Update to dk tb extension 1.12.1d

## 1.12.1c (2016-08-31)
- Update to dk tb 1.12.1c
- Update to dk tb extension 1.12.1c

## 1.12.1b (2016-08-29)
- Major doc update
- Sample proxy file added
- Update to dk tb 1.12.1b

## 1.12.1 (2016-08-26)
- Update to boot2docker 1.12.1
- Update to my docker-toolbox 1.12.1

## 1.12.0 (2016-07-28)
- Update to boot2docker 1.12.0
- Update to my docker-toolbox 1.12.0
- ```dk proxy``` now renamed to dk proxy flags
- ```dk proxy``` is now for a set of sub commands 
- new ```dk proxy update``` to update docker proxy with current proxy env vars
- new ```b2d proxy``` change cmd added
- new ```b2d proxy``` restore cmd added

## 1.11.2 (2016-06-04)
- Update to boot2docker 1.11.2
- Update to my docker-toolbox 1.11.2

## 1.11.0 (2016-04-14)
- Update to boot2docker 1.11.0
- Update to my docker-toolbox 1.11.0

## 1.10.3 (2016-03-13)
- Update to boot2docker 1.10.3
- Update to my docker-toolbox 1.10.3
- My docker-toolbox extension OFF by default
- ```dk tb extension [on/off]```command added
- Introducing persistent param change with ```param.sh```

## 1.10.2 (2016-03-06)
- Update to boot2docker 1.10.2
- Now all ```b2d``` commands are like this ```b2d sub_command````
- Now all ```dc``` commands are like this ```dc sub_command````
- Now all ```dk``` commands are like this ```dk sub_command````
- ```b2d syncd``` command added
- Daemon b2d-syncd added
- Better ```b2d sync``` command
- Renamed to ```vagrant-boot2docker-extension```

## 1.10.1 (2016-02-15)
- Update to boot2docker 1.10.1
- Documentation update / fix
- Now ```dk-proxy-env``` is available
- Totally new layout with ```*.d``` folder to load commands dynamically
- ```dk-toolbox-update``` command to update toolbox
- Dynamic provision and bootlocal scripts hook
- ```dktb``` command added
- ```dktb-update``` command added
- ```b2d_proxy_host``` and ```b2d_proxy_port``` commands added
- Now redsocks will read directly proxy from b2d env
- New ```b2d-dk-redsocks``` command to manage docker redsocks proxy
- ```b2d``` commands are now in their dedicated file

## 1.10.0 (2016-02-07)
- Initial version for docker 1.10.0 and compose 1.6.0
- Work with [boot2docker-vagrant-template](https://github.com/AlbanMontaigu/boot2docker-vagrant-template)
