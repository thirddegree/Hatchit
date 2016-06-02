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

REM Create virtualenv
set PYTHONENV=%~dp0..\\_build\\dependencies\\Python\\
cd ..\..\..\..\ThirdParty\virtualenv
call python.exe .\virtualenv.py "%PYTHONENV%"
if NOT %ERRORLEVEL% == 0 goto :Error

REM Install libraries
cd %PYTHONENV%Scripts\
call "activate.bat"
pip install -I cogapp==2.5
call "deactivate.bat"
goto :Done

:Error
echo "Error invoking Python. Is Python3.5 installed? Is Python3.5 accessible on the PATH?"
goto :EndOfScript

:Done
echo "Script complete."

:EndOfScript
cd %~dp0
