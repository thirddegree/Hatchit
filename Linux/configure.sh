
cd _build
mkdir debug
mkdir release
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug ../..
cd ../release
cmake -DCMAKE_BUILD_TYPE=Release ../..
