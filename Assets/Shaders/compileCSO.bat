@echo off
::Enable redirection so that we can use the temp name variable in the loop
setlocal enabledelayedexpansion

::Put FXC in the path
echo Making sure FXC is in the path; you must have VS2015 installed
CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
echo.

::Make sure that the user know what to name their .hlsl files
echo This will compile all .hlsl files in this dir to .cso files
echo Make sure your files are appropriately named:
echo _VS.hlsl files are Vertex Shaders
echo _PS.hlsl files are Pixel Shaders
echo _GS.hlsl files are Geometry Shaders
echo _HS.hlsl files are Hull Shaders
echo _DS.hlsl files are Domain Shaders
echo _CS.hlsl files are Compute Shaders

::Record the directory that this was called from
set callingDir=%cd%
::Go to the directory that this script is in
cd %~dp0

::Open a log
break > compileCSO.log

echo.
echo Compiling ...

::Compile scripts in debug mode based off their suffix (_VS, _PS etc.) and their extension (.hlsl)
for /f %%f in ('dir /b .') do (
    set name=%%~nf
    
    if !name:~-3! == _VS if %%~xf == .hlsl fxc /Od /Zi /T vs_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _PS if %%~xf == .hlsl fxc /Od /Zi /T ps_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _GS if %%~xf == .hlsl fxc /Od /Zi /T gs_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _HS if %%~xf == .hlsl fxc /Od /Zi /T hs_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _DS if %%~xf == .hlsl fxc /Od /Zi /T ds_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
    
    if !name:~-3! == _CS if %%~xf == .hlsl fxc /Od /Zi /T cs_5_1 /Fo %%~nf.cso ./%%f >> compileCSO.log
)

::Print log to console
type compileCSO.log

echo Done

::Go back to the directory this was called from
cd %callingDir%