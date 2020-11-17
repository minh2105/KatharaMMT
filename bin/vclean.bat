@echo off

FOR /F "tokens=*" %%a in ('python %NETKIT_HOME%\python\adapter.py') DO SET ADAPTER_BIN=%%a

IF [%1]==[] GOTO USAGE

FOR %%a in (%*) do SET NETKIT_LASTARG=%%a

SET NETKIT_NET=0
FOR %%p in (%*) DO (
    IF "%%p" == "--network" ( 
        SET NETKIT_NET=1
    )
)

echo "Any network still in use by another machine will not be deleted (and will raise an error instead)"

IF "%NETKIT_NET%" == "0" CALL %NETKIT_HOME%\lclean -d %NETKIT_HOME%\temp/labs/netkit_nt_%NETKIT_LASTARG%
IF "%NETKIT_NET%" == "1" CALL %ADAPTER_BIN% network rm netkit_nt_%NETKIT_LASTARG%

GOTO END

:USAGE
ECHO Usage: %0 machine_name 

:END
