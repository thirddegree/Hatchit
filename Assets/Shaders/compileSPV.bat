@echo off

::Get the GLSLang compiler
set glslang=%VK_SDK_PATH%\Bin\glslangValidator.exe

echo Using SDK Path: %VK_SDK_PATH%
echo Using glslang Path: %glslang%
echo.

echo This will compile all .vert, .frag, .geom, .tesc, .tese and .comp files in this dir to .spv files
echo.

::Record the directory that this was called from
set callingDir=%cd%
::Go to the directory that this script is in
cd %~dp0

::Open a log
break > compileSPV.log

echo Compiling ...
echo.

::Call GLSLang based on file extension
for /f %%f in ('dir /b .') do (
    if %%~xf == .vert %glslang% -V -o %%~nf_VS.spv ./%%f >> compileSPV.log
    if %%~xf == .frag %glslang% -V -o %%~nf_FS.spv ./%%f >> compileSPV.log
    if %%~xf == .geom %glslang% -V -o %%~nf_GS.spv ./%%f >> compileSPV.log
    if %%~xf == .tesc %glslang% -V -o %%~nf_TCS.spv ./%%f >> compileSPV.log
    if %%~xf == .tese %glslang% -V -o %%~nf_TES.spv ./%%f >> compileSPV.log
    if %%~xf == .comp %glslang% -V -o %%~nf_CS.spv ./%%f >> compileSPV.log
)

::Print log to console
type compileSPV.log

echo Done

::Go back to the directory this was called from
cd %callingDir%