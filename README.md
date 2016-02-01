# Hatchit
An Open Source 3D Game Engine written in C++

## Build instructions

This is subject to change and may not be complete or entirely accurate!

### Linux

All testing and development so far has been done on Ubuntu 15.x

Install the following dependencies:
* CMake
* GLEW
* SDL2
* Bullet3
* Assimp
* TinyXML2
* Python 3.4

Then follow these simple directions:
* Clone down the repo with `git clone --recursive http://github.com/thirddegree/Hatchit`
* `cd` into the Linux directory
* Run the `configure.sh` script
* `cd` into `_build/` and then either `debug/` or `release/`
* Run `make -j 16`
* Run your new `ht_test` executable!

### Windows

This is a bit more of a pain. All dependencies are submodules in the Third Party
directory and will need to be built before you build Hatchit.

All testing and development has been done on Windows 10 with Visual Studio 2015
and Visual Studio 2013. We recommend 2015.

#### Pre-Build
We recommend using some sort of cmd replacement in Windows such as cmder or some sort of bash shell
* Install CMake and make sure it is in your path
* Make sure that you can run `msbuild.exe` from your shell. If it's not there try running the `vcvarsall.bat` file located at `C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat` for Visual Studio 2015 or `C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat` for Visual Studio 2013.
* Clone down the repo with `git clone --recursive http://github.com/thirddegree/Hatchit`

#### Third Party
Next up is building all the dependencies. This should only have to be done once for your machine. After this you won't have to worry about `vcvarsall.bat` but you will need CMake.

* `cd` into `Hatchit\Windows\ThirdParty`
* Run the `config.bat` file located here. This should configure AND BUILD all your dependencies
* Your shell will be moved to a Python directory, just `cd` up a few directories

#### Hatchit
This is the easy part!

* `cd` into `Hatchit\Windows`
* Run the `config.bat` files located here. This will configure the Visual Studio solution
* Your shell should be located in `Hatchit\Windows\_build\debug\VS2015`
* Open the `HatchitEngine.sln` file however you'd like
* Make sure that `HatchitTest` is marked as your startup project
* Build and Run!
