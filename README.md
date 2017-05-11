# Hatchit

[![Join the chat at https://gitter.im/thirddegree/Hatchit](https://badges.gitter.im/thirddegree/Hatchit.svg)](https://gitter.im/thirddegree/Hatchit?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


A Free and Open Source 3D Game Engine written in C++

---

### Contributing

Any issues not related to the build system should go onto the page of the repo best suited for that issue. Graphics code goes onto the HatchitGraphics page for instance.

If you would like to submit a pull-request it's best to fork the project and follow the build instructions to get a working copy. Then fork the repo that you'd like to contribute code to and modify your .gitmodules file to point to your fork. Then you can edit, test and push all you'd like before submitting a pull request.

### Build instructions

The information below is subject to change at any time

#### Windows

Due to the lack of a package management system for Windows. Most dependencies of Hatchit are submodules
and will need to be built from source before you can build Hatchit.

All testing and development has been done on <b>Windows 10</b> with <b>Visual Studio 2017</b>

##### Pre-Build
We recommend using some sort of cmd replacement in Windows such as cmder or some sort of bash shell
* Install CMake and make sure it is in your path
* Make sure that you have access to `vswhere.exe` a new utility supported by Microsoft for Visual Studio 2017 and its subsequent releases. [https://github.com/Microsoft/vswhere](https://github.com/Microsoft/vswhere)

* Clone down the repo with `git clone --recursive http://github.com/thirddegree/Hatchit`


##### Third Party
Next up is building all the dependencies. Included in the repo is a batch script
that will build all necessary dependencies for Hatchit.

* Run the `setup.bat` file. This should configure AND build all your dependencies as well as generate a solution for Hatchit
* If you wish to re-initialize the generated project for just Hatchit. You can also run `setup.bat -hatchit`

##### Hatchit
This is the easy part!

* `cd` into `build`
* Open the `Hatchit.sln` solution file
