@echo off
cd _build
mkdir bin\Debug
mkdir bin\Release

SET VK=0
SET GL=0
SET DX11=0
SET DX12=0

::Check command line arguments for which graphics langs to support
if "%1" == "GL" SET GL=1
if "%2" == "GL" SET GL=1
if "%3" == "GL" SET GL=1
if "%4" == "GL" SET GL=1

if "%1" == "VK" SET VK=1
if "%2" == "VK" SET VK=1
if "%3" == "VK" SET VK=1
if "%4" == "VK" SET VK=1

if "%1" == "DX11" SET DX11=1
if "%2" == "DX11" SET DX11=1
if "%3" == "DX11" SET DX11=1
if "%4" == "DX11" SET DX11=1

if "%1" == "DX12" SET DX12=1
if "%2" == "DX12" SET DX12=1
if "%3" == "DX12" SET DX12=1
if "%4" == "DX12" SET DX12=1

@echo %VK%
@echo %GL%
@echo %DX11%
@echo %DX12%


:copying

@echo on

REM Place all third party libs into the Debug and Release bin folders

copy /Y dependencies\SDL2\bin\Debug\SDL2d.dll bin\Debug
copy /Y dependencies\assimp\bin\Debug\assimpd.dll bin\Debug
copy /Y dependencies\glew\bin\Debug\glew32d.dll bin\Debug
copy /Y dependencies\tinyxml2\bin\Debug\tinyxml2d.dll bin\Debug
copy /Y dependencies\Python\bin\Debug\python3.dll bin\Debug
copy /Y dependencies\Python\bin\Debug\python34_d.dll bin\Debug
copy /Y %VK_SDK_PATH%\Source\lib\vulkan-1.dll bin\Debug

copy /Y dependencies\SDL2\bin\Release\SDL2.dll bin\Release
copy /Y dependencies\assimp\bin\Release\assimp.dll bin\Release
copy /Y dependencies\glew\bin\Release\glew32.dll bin\Release
copy /Y dependencies\tinyxml2\bin\Release\tinyxml2.dll bin\Release
copy /Y dependencies\Python\bin\Release\python3.dll bin\Release
copy /Y dependencies\Python\bin\Release\python34.dll bin\Release
copy /Y %VK_SDK_PATH%\Source\lib\vulkan-1.dll bin\Release

mkdir VS2015
cd VS2015

@echo off
set languageString = ""

if %VK% == 1 set "languageString=-DVK_SUPPORT=TRUE"

if %GL% == 1 set "languageString=-DGL_SUPPORT=TRUE"

if %DX12% == 1 set "languageString=-DDX12_SUPPORT=TRUE"

if %DX11% == 1 set "languageString=-DDX11_SUPPORT=TRUE"

::if %VK% == 0 if %GL% == 0 if %DX11% == 0 if %DX12% == 0 set languageString=-DALL_GRAPHICS=TRUE

echo %languageString%
@echo on
cmake ../../ %languageString% -DCMAKE_SYSTEM_VERSION=10.0 -G "Visual Studio 14 2015 Win64"




