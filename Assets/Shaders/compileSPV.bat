@echo off

set glslang=%VK_SDK_PATH%\Bin\glslangValidator.exe

echo Using SDK Path: %VK_SDK_PATH%
echo Using glslang Path: %glslang%

echo This will compile all .vert, .frag, .geom, .tesc, .tese and .comp files in this dir to .spv files

set callingDir=%cd%
cd %~dp0

break > compileSPV.log

echo Compiling ...
for /f %%f in ('dir /b .') do (
    if %%~xf == .vert %glslang% -V -o %%~nf_VS.spv ./%%f >> compileSPV.log
    if %%~xf == .frag %glslang% -V -o %%~nf_FS.spv ./%%f >> compileSPV.log
    if %%~xf == .geom %glslang% -V -o %%~nf_GS.spv ./%%f >> compileSPV.log
    if %%~xf == .tesc %glslang% -V -o %%~nf_TCS.spv ./%%f >> compileSPV.log
    if %%~xf == .tese %glslang% -V -o %%~nf_TES.spv ./%%f >> compileSPV.log
    if %%~xf == .comp %glslang% -V -o %%~nf_CS.spv ./%%f >> compileSPV.log
)

echo Done
cd %callingDir%