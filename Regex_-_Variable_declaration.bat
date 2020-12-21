@echo off
setlocal enabledelayedexpansion
set "alpha=abcdefghijklmnopqrstuvwxyz"
set "digit=0123456789"
set "alnum=%alpha%%digit%"

set "baseType=[%alpha%][%alnum%]*[ ][ ]*[%alpha%][%alnum%]*[ ]*=[ ]*[%alnum%][%alnum%]*"

call :test_pattern "%baseType%" "int x=1" "x=1" "=1" "1" "int x=" "x=" "=" "int x" "x" "int"

pause
setlocal disabledelayedexpansion
echo on
@goto eof

:init
    set /a "ec_success=0"
    set /a "ec_unknown_error=1"

    cls
exit /b %ec_success%

:test_pattern
    set /a "ec_matching_failed=10"
    set /a "status=%success%"

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
        echo !value[%%i]!| findstr /I /R /C:"^%pattern%$" > nul
        if errorlevel 1 (
            echo "!value[%%i]!" doesn't match pattern
            set /a "status=%ec_matching_failed%"
        ) else (
            echo "!value[%%i]!" matches pattern
        )
    )
exit /b %status%

:eof
