cd ../_build
mkdir dependencies

REM Generate VS2015 Build
mkdir VS2015
cd VS2015
mkdir ThirdParty
cd ThirdParty
cmake ../../../ThirdParty/ -G "Visual Studio 14 2015 Win64" -DDIRECTX=NO -DASSIMP_BUILD_ASSIMP_TOOLS=NO
msbuild.exe ThirdPartyLibs.sln /p:Configuration=Debug
msbuild.exe ThirdPartyLibs.sln /p:Configuration=Release


cd ../../../

REM Build Python libraries
set PYTHONPATH=%PYTHONPATH%;C:\Python34\Lib

mkdir _build\dependencies\Python\bin\Debug
mkdir _build\dependencies\Python\bin\Debug\Lib
mkdir _build\dependencies\Python\bin\Release
mkdir _build\dependencies\Python\bin\Release\Lib
mkdir _build\dependencies\Python\lib\Debug
mkdir _build\dependencies\Python\lib\Release

cd ../ThirdParty/Python/PCbuild
call "build.bat" -p x64 -d

move /Y x64-pgo\python3.lib %~dp0\..\_build\dependencies\Python\lib\Debug\
move /Y amd64\python35_d.lib %~dp0\..\_build\dependencies\Python\lib\Debug\
move /Y x64-pgo\python35stub.lib %~dp0\..\_build\dependencies\Python\lib\Debug\
move /Y x64-pgo\* %~dp0\..\_build\dependencies\Python\bin\Debug\
move /Y amd64\python35_d.dll %~dp0\..\_build\dependencies\Python\bin\Debug\
move /Y amd64\python_d.exe %~dp0\..\_build\dependencies\Python\bin\Debug\
xcopy /Y ..\Lib %~dp0\..\_build\dependencies\Python\bin\Debug\Lib /D /E

call "build.bat" -p x64

move /Y amd64\python3.lib %~dp0\..\_build\dependencies\Python\lib\Release\
move /Y amd64\python35.lib %~dp0\..\_build\dependencies\Python\lib\Release\
move /Y amd64\python35stub.lib %~dp0\..\_build\dependencies\Python\lib\Release\
move /Y amd64\python3.dll %~dp0\..\_build\dependencies\Python\bin\Release\
move /Y amd64\python35.dll %~dp0\..\_build\dependencies\Python\bin\Release\
move /Y amd64\python.exe %~dp0\..\_build\dependencies\Python\bin\Release\
xcopy /Y ..\Lib %~dp0\..\_build\dependencies\Python\bin\Release\Lib /D /E
