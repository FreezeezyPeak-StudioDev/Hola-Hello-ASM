@echo off
setlocal
rem Compila todo en un solo paso: NASM + LINK -> .exe
rem Uso: compilar.bat [archivo.asm]  (por defecto hello.asm)

set NASM=D:\Software\NASM\nasm.exe
set LINKEXE=D:\Software\Microsoft Visual Studio\2022\Professional\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64\link.exe
set LINK=
set LIB=D:\Software\Microsoft Visual Studio\2022\Professional\VC\Tools\MSVC\14.44.35207\lib\x64;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.26100.0\um\x64;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64

if "%~1"=="" (
  set SRC=hello.asm
) else (
  set SRC=%~1
)

for %%F in ("%SRC%") do set NAME=%%~nF

echo [1/2] NASM %SRC% -^> %NAME%.obj
"%NASM%" -f win64 "%SRC%" -o "%NAME%.obj"
if errorlevel 1 (
  echo ERROR en NASM
  pause
  exit /b 1
)

echo [2/2] LINK %NAME%.obj -^> %NAME%.exe
"%LINKEXE%" "%NAME%.obj" /OUT:"%NAME%.exe" /SUBSYSTEM:CONSOLE /MACHINE:X64 libcmt.lib libucrt.lib kernel32.lib user32.lib
if errorlevel 1 (
  echo ERROR en LINK
  pause
  exit /b 1
)

echo.
echo OK: %NAME%.exe generado correctamente
