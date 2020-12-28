@echo off
setlocal enabledelayedexpansion
call :init

call :echo_table

pause
exit /b %ec_success%

:init
    set /a "ec_success=0"
    set /a "ec_unknown_error=1"

    cls
    call :set_esc
exit /b %ec_success%

:get_length
    set "stringToGetLength=%~1"
    set /a "i=0"

    :get_char_loop
        call set "char=%%stringToGetLength:~%i%,1%%"
        if defined char (
            set /a "i+=1"
            goto :get_char_loop
        )
    
    set /a "result=%i%"
exit /b %ec_success%

:pad_left
    set "stringToPadLeft=%~1"
    set /a "fieldWidth=%~2"

    call :get_length "%stringToPadLeft%"
    set "length=%result%"

    set /a "difference=%fieldWidth% - %length%"
    for /l %%i in (1 1 %difference%) do set "stringToPadLeft=.!stringToPadLeft!"

    set "result=%stringToPadLeft%"
exit /b %ec_success%

:echo_table
    for /l %%i in (1, 1, 9) do (
        for /l %%j in (1, 1, 9) do (
            set /a "product=%%i*%%j"
            set /a "reminder=!product! %% 2"

            call :pad_left !product! 6
            set "product=!result!"
            
            if !reminder! equ 0 (
                echo echo| set /p "=%ESC%[34m"
            ) else (
                echo echo| set /p "=%ESC%[91m"
            )

            echo| set /p "=!result!%ESC%[0m"
        )
        echo.
    )
exit /b %ec_success%

:set_esc
    for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
        set "esc=%%b"
        exit /b 0
    )
exit /b %ec_success%
