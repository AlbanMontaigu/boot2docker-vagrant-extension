# Vagrant files

## Introduction

Main files called directly by `vagrant` because they are referenced by the `Vagrantfile`.

Those file where previously included directly in [boot2docker-vagrant-template](https://github.com/AlbanMontaigu/boot2docker-vagrant-template).

Since I know Vagrant can call remote file directly, it's calld with the git raw URL in the Vagrantfile (see the template) to avoid maintenance in the final project.

## Where these files are called ?

These files are called inside the ```Vagrantfile``` provided at the root of this template in the section called *"Customization of the OS"*.

The call is done with the Vagrant ```config.vm.provision "shell", path:``` directive.

## Files description

### bootlocal.sh

Run during each boot **in third position**, with ```vagrant up``` or ```vagrant reload``` and during a provisioning with ```vagrant provision``` or equivalent with a ```--provision``` flag.

Basically, it runs its twin extension script located in ```BOOT2DOCKER_EXTENSION_DIR``` inside boot2docker system files to start extension booting process.

### param.sh

Run during provisioning phase **in second position** with ```vagrant provision```, ```vagrant up --provision```, ```vagrant reload --provision``` or  the first ```vagrant up```.

Basically, it runs its twin extension script located in ```BOOT2DOCKER_EXTENSION_DIR``` inside boot2docker system files to start extension parametrization process.

### provision.sh

Run during provisioning phase **in first position** with ```vagrant provision```, ```vagrant up --provision```, ```vagrant reload --provision``` or  the first ```vagrant up```.

Basically, it clones a [boot2docker-vagrant-extension](https://github.com/AlbanMontaigu/boot2docker-vagrant-extension) like extension and then it runs its twin extension script located in ```BOOT2DOCKER_EXTENSION_DIR``` inside boot2docker system files to start extension provisioning process.

Extension git URL is set in the ```VAGRANT_B2D_EXTENSION_REPO``` parameter of the root ```Vagrantfile```.
