@echo off
setlocal enabledelayedexpansion

set "colors[0]=9"
set "colors[1]=A"
set "colors[2]=B"
set "colors[3]=C"
set "colors[4]=D"
set "colors[5]=E"
set "colors[6]=F"
set /a "length=7"

set /a "sleep=1"

set "text=Hello World"

cls
echo %text%

:while_true
set /a "i=%random% %% %length%"
color !colors[%i%]!F
timeout %sleep% > nul
goto :while_true

setlocal disabledelayedexpansion
@echo on
