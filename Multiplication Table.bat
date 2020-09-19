@echo off
call :init
setlocal enabledelayedexpansion
call :echo_table
call :blinking
setlocal disabledelayedexpansion
@echo on
@goto :eof

:init
    set "ec_success=0"
    set "ec_unknown_error=1"

    set "colors[0]=9" && set "colors[1]=A" && set "colors[2]=B"
    set "colors[3]=C" && set "colors[4]=D" && set "colors[5]=E"
    set "colors[6]=F" && set /a "length=7"

    set /a "sleep=1"

    cls
exit /b %ec_success%

:echo_table
    for /l %%i in (1, 1, 9) do (
        for /l %%j in (1, 1, 9) do (
            set /a "product=%%i*%%j"
            set "result=!product! "
            if !product! lss 10 set "result=!result! "
            echo | set /p="!result!"
        )
        echo.
    )
exit /b %ec_success%

:blinking
    :while_true
    set /a "i=%random% %% %length%"
    color !colors[%i%]!
    timeout %sleep% > nul
    goto :while_true
exit /b %ec_success%

:eof