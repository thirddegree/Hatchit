cd _build
mkdir bin\Debug
mkdir bin\Release

REM Place all third party libs into the Debug and Release bin folders

copy /Y dependencies\SDL2\bin\Debug\SDL2.dll bin\Debug
copy /Y dependencies\assimp\bin\Debug\assimp.dll bin\Debug
copy /Y dependencies\glew\bin\Debug\glew32.dll bin\Debug
copy /Y dependencies\tinyxml2\bin\Debug\tinyxml2.dll bin\Debug
copy /Y dependencies\Python\bin\Debug\python3.dll bin\Debug
copy /Y dependencies\Python\bin\Debug\python34_d.dll bin\Debug

copy /Y dependencies\SDL2\bin\Release\SDL2.dll bin\Release
copy /Y dependencies\assimp\bin\Release\assimp.dll bin\Release
copy /Y dependencies\glew\bin\Release\glew32.dll bin\Release
copy /Y dependencies\tinyxml2\bin\Release\tinyxml2.dll bin\Release
copy /Y dependencies\Python\bin\Release\python3.dll bin\Release
copy /Y dependencies\Python\bin\Release\python34.dll bin\Release

mkdir VS2013
mkdir VS2015
cd VS2013
cmake ../../ -G "Visual Studio 12 2013 Win64"
cd ../VS2015
cmake ../../ -G "Visual Studio 14 2015 Win64"


