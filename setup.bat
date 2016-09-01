mkdir build
cd build
mkdir ThirdParty
cd ThirdParty

cmake ../../ThirdParty -G "Visual Studio 14 2015 Win64" -DDIRECTX=NO -DASSIMP_BUILD_ASSIMP_TOOLS=NO
msbuild.exe ThirdPartyLibs.sln /p:Configuration=Debug
msbuild.exe ThirdPartyLibs.sln /p:Configuration=Release