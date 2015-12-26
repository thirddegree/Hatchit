cd _build
mkdir VS2013
mkdir VS2015
cd VS2013
cmake ../../ -G "Visual Studio 12 2013 Win64"
cd ../VS2015
cmake ../../ -G "Visual Studio 14 2015 Win64"