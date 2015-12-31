cd ../_build
mkdir dependencies
mkdir VS2013
mkdir VS2015
cd VS2013
mkdir ThirdParty
cd ThirdParty
cmake ../../../ThirdParty/ -G "Visual Studio 12 2013 Win64"
cd ../../VS2015
mkdir ThirdParty
cd ThirdParty
cmake ../../../ThirdParty/ -G "Visual Studio 14 2015 Win64"
cd ../../../

REM Build Python libraries

mkdir _build\dependencies\Python\bin\Debug
mkdir _build\dependencies\Python\bin\Release
mkdir _build\dependencies\Python\lib\Debug
mkdir _build\dependencies\Python\lib\Release

cd ../ThirdParty/Python/PCbuild
call "build.bat" -p x64 -d

move /Y x64-pgo\python3.lib %~dp0\..\_build\dependencies\Python\lib\Debug\
move /Y amd64\python34_d.lib %~dp0\..\_build\dependencies\Python\lib\Debug\
move /Y x64-pgo\python34stub.lib %~dp0\..\_build\dependencies\Python\lib\Debug\
move /Y x64-pgo\* %~dp0\..\_build\dependencies\Python\bin\Debug\
move /Y amd64\python34_d.dll %~dp0\..\_build\dependencies\Python\bin\Debug\

call "build.bat" -p x64

move /Y amd64\python3.lib %~dp0\..\_build\dependencies\Python\lib\Release\
move /Y amd64\python34.lib %~dp0\..\_build\dependencies\Python\lib\Release\
move /Y amd64\python34stub.lib %~dp0\..\_build\dependencies\Python\lib\Release\
move /Y amd64\python3.dll %~dp0\..\_build\dependencies\Python\bin\Release\
move /Y amd64\python34.dll %~dp0\..\_build\dependencies\Python\bin\Release\