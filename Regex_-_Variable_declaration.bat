@echo off
setlocal enabledelayedexpansion
call :init

set "alpha=abcdefghijklmnopqrstuvwxyz"
set "digit=0123456789"
set "alnum=%alpha%%digit%"

set "baseType=[%alpha%][%alnum%]*[ ][ ]*[%alpha%][%alnum%]*[ ]*=[ ]*[%alnum%][%alnum%]*"

call :test_pattern "%baseType%" "int x=1" "x=1" "=1" "1" "int x=" "x=" "=" "int x" "x" "int"
set "testPatternErrorLevel=%ERRORLEVEL%"

pause
exit /b %testPatternErrorLevel%

:init
    set /a "ec_success=0"
    set /a "ec_unknown_error=1"

    call :set_esc

    cls
exit /b %ec_success%

:test_pattern
    set /a "ec_matching_failed=10"
    set /a "status=%ec_success%"

    set "pattern=%~1"

    shift
    set /a "i=1"
    :while_there_are_arguments
    if not "%~1" == "" (
        set "value[%i%]=%~1"
        set /a "i+=1"
        shift
        goto :while_there_are_arguments
    )

    set /a "count=%i% - 1"
    set /a "i=1"

    for /l %%i in (1 1 %count%) do (
        echo !value[%%i]!| findstr /I /R /C:"^%pattern%$" > nul && (
            echo %ESC%[32m"!value[%%i]!" matches pattern%ESC%[0m
        ) || (
            echo %ESC%[31m"!value[%%i]!" doesn't match pattern%ESC%[0m
            set /a "status=%ec_matching_failed%"
        )
    )
exit /b %status%

:set_esc
    for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
        set "esc=%%b"
        exit /b 0
    )
exit /b %ec_success%
