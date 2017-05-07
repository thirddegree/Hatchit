@echo off

IF NOT EXIST  build mkdir build

cd build

IF NOT EXIST ThirdParty mkdir ThirdParty

IF "%1" == "-hatchit" (
    cmake ..\\ -G "Visual Studio 14 2015 Win64" -DCMAKE_SYSTEM_VERSION=10.0 -DBUILD_SHARED_LIBS=ON
)

IF NOT "%1" == "-hatchit" (

    cd ThirdParty

    if "%1" == "-winrt" (
        cmake ..\\..\\ThirdParty -G "Visual Studio 14 2015 Win64" -DCMAKE_SYSTEM_NAME:STRING=WindowsStore -DCMAKE_SYSTEM_VERSION:STRING=10.0 -DBUILD_SHARED_LIBS=ON -DBUILD_WINRT=ON
        msbuild.exe ThirdPartyLibs.sln /p:Configuration=Debug
        msbuild.exe ThirdPartyLibs.sln /p:Configuration=Release

        cd ..

        cmake ..\\ -G "Visual Studio 14 2015 Win64" -DCMAKE_SYSTEM_NAME:STRING=WindowsStore -DCMAKE_SYSTEM_VERSION:STRING=10.0 -DBUILD_SHARED_LIBS=ON -DBUILD_WINRT=ON
    )

    REM cmake ..\\..\\ThirdParty -G "Visual Studio 14 2015 Win64" -DBUILD_REQUIRED=OFF -DASSIMP_BUILD_ASSIMP_TOOLS=NO -DASSIMP_BUILD_TESTS=NO  -DBUILD_SHARED_LIBS=ON
    REM msbuild.exe ThirdPartyLibs.sln /p:Configuration=Debug
    REM msbuild.exe ThirdPartyLibs.sln /p:Configuration=Release
    
    REM cd ..

    REM cmake ..\\ -G "Visual Studio 14 2015 Win64" -DCMAKE_SYSTEM_VERSION=10.0 -DBUILD_SHARED_LIBS=ON
    
)
