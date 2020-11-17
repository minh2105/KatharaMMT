@echo off

FOR /F "tokens=*" %%a in ('python %NETKIT_HOME%\python\adapter.py') DO SET ADAPTER_BIN=%%a

SET NETKIT_LASTARG=""
FOR %%a in (%*) do SET NETKIT_LASTARG=%%a
FOR %%a in (%*) do (
    IF "%%a"=="%NETKIT_LASTARG%" SHIFT
)

FOR /F "tokens=*" %%a in ('python %NETKIT_HOME%\python\vstart.py "%cd%/" %NETKIT_LASTARG% %*') do CALL %NETKIT_HOME%\lstart -d %%a
%ADAPTER_BIN% start netkit_nt_%NETKIT_LASTARG%

RMDIR %NETKIT_HOME%\temp\labs\netkit_nt_%NETKIT_LASTARG% /S /Q
