@title OLE-PATCHER
@echo off

REM WINDOWS 64 BIT

echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo º OLE CONTROL PATCHER º
echo ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

REM --------------------------------------------------------------------------
REM ------------------------------- Microsoft Visual Basic 6.0 Common Controls

copy MSWINSCK.OCX %systemroot%\System32
copy MSCOMCTL.OCX %systemroot%\System32

REM --------------------------------------------------------------------------
REM ------------- Unregister OLE controls (DLLs + ActiveX) in Windows Registry

regsvr32 /u MSWINSCK.OCX
regsvr32 /u MSCOMCTL.OCX

REM --------------------------------------------------------------------------
REM ------------------------------------------------ Register new OLE controls

regsvr32 %systemroot%\System32\MSWINSCK.OCX
regsvr32 %systemroot%\System32\MSCOMCTL.OCX

REM --------------------------------------------------------------------------
REM ---------------- Update for the Microsoft Visual Basic 6.0 Common Controls

VisualBasic6-KB896559-v1-FRA.exe

REM --------------------------------------------------------------------------
REM ------- Error when registering a 32-bit DLL on a 64-bit version of Windows

copy %systemroot%\System32\MSWINSCK.OCX %systemroot%\SysWoW64\MSWINSCK.OCX
copy %systemroot%\System32\MSCOMCTL.OCX %systemroot%\SysWoW64\MSCOMCTL.OCX

%systemroot%\SysWoW64\regsvr32 %systemroot%\SysWoW64\MSWINSCK.OCX
%systemroot%\SysWoW64\regsvr32 %systemroot%\SysWoW64\MSCOMCTL.OCX
