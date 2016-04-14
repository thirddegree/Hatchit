@echo off
setlocal enabledelayedexpansion

echo Making sure FXC is in the path; you must have VS2015 installed
CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
echo.

echo This will compile all .hlsl files in this dir to .cso files
echo Make sure your files are appropriately named:
echo _VS.hlsl files are Vertex Shaders
echo _PS.hlsl files are Pixel Shaders
echo _GS.hlsl files are Geometry Shaders
echo _HS.hlsl files are Hull Shaders
echo _DS.hlsl files are Domain Shaders
echo _CS.hlsl files are Compute Shaders

set callingDir=%cd%
cd %~dp0

break > compileCSO.log

echo.
echo Compiling ...
for /f %%f in ('dir /b .') do (
    set name=%%~nf
    
    if !name:~-3! == _VS if %%~xf == .hlsl fxc /Od /Zi /T vs_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _PS if %%~xf == .hlsl fxc /Od /Zi /T ps_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _GS if %%~xf == .hlsl fxc /Od /Zi /T gs_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _HS if %%~xf == .hlsl fxc /Od /Zi /T hs_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _DS if %%~xf == .hlsl fxc /Od /Zi /T ds_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _CS if %%~xf == .hlsl fxc /Od /Zi /T cs_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
)

echo Done
cd %callingDir%