# b2d-syncd folder

## Desription

b2d-syncd daemon files. This daemon goal is to do a regular sync with files between the box and the root host.

This is a workaround for the sync bug provided by virtualbox guest additions tool. This bug occurs when small modifications are done on the host files and not propagated in the box environment.

## Content

### bin

Contains daemon script file.

### init.d

Contains daemon management file *(start, stop status ans do so on...)*.
