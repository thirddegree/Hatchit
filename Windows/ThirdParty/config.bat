cd ../_build
mkdir dependencies
mkdir VS2013
mkdir VS2015
cd VS2013
mkdir ThirdParty
cd ThirdParty
cmake ../../../ThirdParty/ -G "Visual Studio 12 2013 Win64"
cd ../VS2015
mkdir ThirdParty
cd ThirdParty
cmake ../../../ThirdParty/ -G "Visual Studio 14 2015 Win64"