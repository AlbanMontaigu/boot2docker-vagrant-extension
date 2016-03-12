
## 1.10.3 (2016-03-12)
- Update to boot2docker 1.10.3
- Update to my docker-toolbox 1.10.3
- My docker-toolbox extension OFF by default

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
