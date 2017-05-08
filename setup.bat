@echo off


@echo off

for /f "usebackq tokens=1* delims=: " %%i in (`vswhere -latest -requires Microsoft.Component.MSBuild`) do (
  if /i "%%i"=="installationPath" set InstallDir=%%j
)

IF NOT EXIST  build mkdir build

cd build

IF NOT EXIST ThirdParty mkdir ThirdParty

IF "%1" == "-hatchit" (
    cmake ..\\ -G "Visual Studio 15 2017 Win64" -DCMAKE_SYSTEM_VERSION=10.0 -DBUILD_SHARED_LIBS=ON
)

IF NOT "%1" == "-hatchit" (

    cd ThirdParty

    if "%1" == "-winrt" (
        cmake ..\\..\\ThirdParty -G "Visual Studio 15 2017 Win64" -DCMAKE_SYSTEM_NAME:STRING=WindowsStore -DCMAKE_SYSTEM_VERSION:STRING=10.0 -DBUILD_SHARED_LIBS=ON -DBUILD_WINRT=ON
        
        if exist "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" (
            "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" ThirdPartyLibs.sln /p:Configuration=Debug
            "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" ThirdPartyLibs.sln /p:Configuration=Release
        )

        cd ..

        cmake ..\\ -G "Visual Studio 15 2017 Win64" -DCMAKE_SYSTEM_NAME:STRING=WindowsStore -DCMAKE_SYSTEM_VERSION:STRING=10.0 -DBUILD_SHARED_LIBS=ON -DBUILD_WINRT=ON
    )

    if NOT "%1" == "-winrt" (

        cmake ..\\..\\ThirdParty -G "Visual Studio 15 2017 Win64" -DCMAKE_SYSTEM_VERSION:STRING=10.0 -DBUILD_SHARED_LIBS=ON -DBUILD_WINRT=OFF
        
        if exist "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" (
            "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" ThirdPartyLibs.sln /p:Configuration=Debug
            "%InstallDir%\MSBuild\15.0\Bin\MSBuild.exe" ThirdPartyLibs.sln /p:Configuration=Release
        )
        
        cd ..

        cmake ..\\ -G "Visual Studio 15 2017 Win64" -DCMAKE_SYSTEM_VERSION:STRING=10.0 -DBUILD_SHARED_LIBS=ON -DBUILD_WINRT=OFF
    )
    
)
