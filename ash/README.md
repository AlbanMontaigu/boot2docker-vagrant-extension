# Ash folder

## Desription

Contains all extension stuff loaded inside the box shell user environment.

## Content

### .ashrc.d

Contains all extensions we want to load in box user environment. If you want to add some, just put a new script in this folder. Be carefull order might be important. These scripts are loaded by ```.ashrc```.

### .ashrc

This file is integrated in the box own ```.ashrc``` by the extension ```bootlocal.sh```.

Then it allows to load some vars and then execute all extensions scripts located in ```.ashrc.d``` when the user connects into the box.
