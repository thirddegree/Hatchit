# Hatchit
An Open Source 3D Game Engine written in C++

## Build instructions

This is subject to change and may not be complete or entirely accurate!

### Linux

All testing and development so far has been done on Ubuntu 15.x

Install the following dependencies:
* GLEW
* SDL2
* Bullet3
* Assimp
* TinyXML2
* Python 3.4

Then follow these simple directions:
* `cd` into the Linux directory
* run the `configure.sh` script
* `cd` into `_build/` and then either `debug/` or `release/`
* run `make -j 16`
* run your new `ht_test` executable!

### Windows

This is a bit more of a pain. All dependencies are submodules in the Third Party
directory and will need to be built before you build Hatchit.

All testing and development has been done on Windows 10 with Visual Studio 2015
and Visual Studio 2013. We recommend 2015.

#### Pre-Build

#### Third Party

#### Hatchit
