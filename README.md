# Hatchit

[![Join the chat at https://gitter.im/thirddegree/Hatchit](https://badges.gitter.im/thirddegree/Hatchit.svg)](https://gitter.im/thirddegree/Hatchit?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


A Free and Open Source 3D Game Engine written in C++

---

### Contributing

Any issues not related to the build system should go onto the page of the repo best suited for that issue. Graphics code goes onto the HatchitGraphics page for instance.

If you would like to submit a pull-request it's best to fork the project and follow the build instructions to get a working copy. Then fork the repo that you'd like to contribute code to and modify your .gitmodules file to point to your fork. Then you can edit, test and push all you'd like before submitting a pull request.

### Build instructions

The information below is subject to change at any time

#### Linux

All testing and development so far has been done on Ubuntu 16.04 XENIAL

Install the following dependencies:
* GCC (minimum required version. 5.0) -- for C++11/14 support
* CMake
* glfw3
* bullet3
* assimp
* tinyxml2
* freetype
* openal-soft
* Vulkan SDK (For Vulkan Support -- https://vulkan.lunarg.com/doc/sdk/1.0.46.0/windows/getting_started.html)

Then follow these simple directions:
* Clone down the repo with `git clone --recursive http://github.com/thirddegree/Hatchit`
* Make a build dir (e.g. mkdir build)
* cd into build/ and run cmake ..
* Now just run make to build Hatchit

#### Windows

Due to the lack of a package managerment system for Windows. Most dependencies of Hatchit are submodules
and will need to be built from source before you can build Hatchit.

All testing and development has been done on <b>Windows 10</b> with <b>Visual Studio 2015</b>

##### Pre-Build
We recommend using some sort of cmd replacement in Windows such as cmder or some sort of bash shell
* Install CMake and make sure it is in your path
* Make sure that you can run `msbuild.exe` from your shell. If it's not there try running the `vcvarsall.bat` file located at `C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat` for Visual Studio 2015
* Clone down the repo with `git clone --recursive http://github.com/thirddegree/Hatchit`

To build with Vulkan support you MUST have installed:
* Vulkan SDK
* Vulkan supported drivers!

##### Third Party
Next up is building all the dependencies. Included in the repo is a batch script
that will build all necessary dependencies for Hatchit.

* Run the `setup.bat` file. This should configure AND build all your dependencies as well as generate a solution for Hatchit
* If you wish to re-initialize the generated project for just Hatchit. You can also run `setup.bat -hatchit`

##### Hatchit
This is the easy part!

* `cd` into `build`
* Open the Hatchit.sln solution file or execute it with `MSBuild.exe` to build all targets
