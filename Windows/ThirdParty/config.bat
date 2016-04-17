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
mkdir _build\dependencies\Python\bin\
mkdir _build\dependencies\Python\DLLs\
mkdir _build\dependencies\Python\Lib\
mkdir _build\dependencies\Python\libs\

cd ../ThirdParty/Python/PCbuild

REM Python Debug build
call "get_externals.bat"
call "build.bat" -p x64 -d -e
move /Y .\amd64\python_d.exe %~dp0..\_build\dependencies\Python\bin
move /Y .\amd64\*.dll %~dp0..\_build\dependencies\Python\bin
move /Y .\amd64\*.lib %~dp0..\_build\dependencies\Python\libs
move /Y .\amd64\*.pyd %~dp0..\_build\dependencies\Python\DLLs
xcopy /Y /D /E ..\Lib %~dp0..\_build\dependencies\Python\Lib

cd ..\..\virtualenv

REM Create virtualenv
setlocal
set PYTHONPATH=%~dp0..\_build\dependencies\Python\Lib:%~dp0..\_build\dependencies\Python\DLLs
%~dp0..\_build\dependencies\Python\bin\python_d.exe .\virtualenv.py %~dp0..\_build\dependencies\Python\env
endlocal

REM Install libraries
cd %~dp0..\_build\dependencies\Python\env\Scripts\
call "activate.bat"
pip install -I cogapp==2.5
call "deactivate.bat"

REM TODO: Python Release build
