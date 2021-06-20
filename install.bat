@echo off
set url=https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/4099-9acc6418ad07262bcd1a5992449c900f87417e68/server.7z
set giturl=https://github.com/git-for-windows/git/releases/download/v2.32.0.windows.1/Git-2.32.0-64-bit.exe
set newdir=nocap_release
set initdir=C:\%newdir%\
mkdir C:\%newdir%\
mkdir C:\%newdir%\resources
cd C:\%initdir%
set command=start-bitstransfer -source %url% -destination %initdir%
::echo %command% > ps.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command %command%

set command=start-bitstransfer -source %giturl% -destination %initdir%

pushd C:\%initdir%
"C:\Program Files\7-Zip\7z.exe" -y e %initdir%\server.7z "-oC:\%newdir%"
pushd  C:\%newdir%\resources
git clone https://github.com/NoCapRP/nocap-release.git

pause
