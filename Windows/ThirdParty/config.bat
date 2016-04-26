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

cd ../../../ThirdParty

REM Download libsndfile installer

pip install wget

python.exe libsndfile_install.py


