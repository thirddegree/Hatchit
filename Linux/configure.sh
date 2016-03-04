#!/bin/bash

VULKAN=0
OPENGL=0

GRAPHICS="-DALL_GRAPHICS=FALSE -DVK_SUPPORT=FALSE -DGL_SUPPORT=FALSE"

if [ "$1" == "VK" ]; 
then 
	VULKAN=1 
fi
if [ "$2" == "VK" ]; 
then 
	VULKAN=1 
fi
if [ "$1" == "GL" ]; 
then 
	OPENGL=1 
fi
if [ "$2" == "GL" ]; 
then 
	OPENGL=1 
fi

if [ $VULKAN -eq 1 ];
then
	GRAPHICS="$GRAPHICS -DVK_SUPPORT=TRUE"
fi

if [ $OPENGL -eq 1 ];
then
	GRAPHICS="$GRAPHICS -DGL_SUPPORT=TRUE"
fi

if [ $VULKAN -eq 0 ] && [ $OPENGL -eq 0 ];
then
	GRAPHICS="-DALL_GRAPHICS=TRUE"
fi

echo $GRAPHICS

cd _build
mkdir debug
mkdir release
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug $GRAPHICS  ../..
cd ../release
cmake -DCMAKE_BUILD_TYPE=Release $GRAPHICS ../..

