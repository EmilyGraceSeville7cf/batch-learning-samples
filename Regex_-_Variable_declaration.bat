@echo off
set "alpha=abcdefghijklmnopqrstuvwxyz"
set "digit=0123456789"
set "alnum=%alpha%%digit%"

set "baseType=[%alpha%][%alnum%]*[ ][ ]*[%alpha%][%alnum%]*[ ]*=[ ]*[%alnum%][%alnum%]*"

call :test_pattern "%baseType%" "int x=1" "x=1" "=1" "1" "int x=" "x=" "=" "int x" "x" "int"

pause
echo on
@goto eof

:test_pattern
    set /a "success=0"
    set /a "failure=1"
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

    setlocal enabledelayedexpansion
    for /l %%i in (1 1 %count%) do (
        echo !value[%%i]!| findstr /I /R /C:"^%pattern%$" > nul
        if errorlevel 1 (
            echo "!value[%%i]!" doesn't match pattern
            set /a "status=%failure%"
        ) else (
            echo "!value[%%i]!" matches pattern
        )
    )
    setlocal disabledelayedexpansion
exit /b %status%

:eof
