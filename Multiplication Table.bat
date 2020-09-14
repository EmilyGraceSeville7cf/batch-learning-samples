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
set /a "width=4"

cls
for /l %%i in (1, 1, 9) do (
    for /l %%j in (1, 1, 9) do (
        set /a "product=%%i*%%j"
        set "result=!product! "
        if !product! lss 10 set "result=!result! "
        echo | set /p="!result!"
    )
    echo.
)

:while_true
set /a "i=%random% %% %length%"
color !colors[%i%]!
timeout %sleep% > nul
goto :while_true

setlocal disabledelayedexpansion
@echo on