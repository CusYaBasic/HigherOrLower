@echo off
setlocal

rem Set initial variables
set /a cash=1000
set /a min=1
set /a max=100

:main
cls
echo Welcome to Higher or Lower Game
echo You have $%cash%.
echo Rolls are between 1-100
set /p bet="Please choose your bet amount: "
if %bet% gtr %cash% (
    echo Insufficient funds. Please choose a smaller bet.
    pause
    goto main
)

rem Roll a number
set /a roll=%random% %% %max% + %min%

rem Prompt user to guess higher or lower
echo The roll is: %roll%
choice /c HL /m "Guess Higher (H) or Lower (L): "
set guess=%errorlevel%
if %guess%==1 set guess_text=Higher
if %guess%==2 set guess_text=Lower

rem Roll another number
set /a roll2=%random% %% %max% + %min%

echo The roll was: %roll2%
rem Determine if the second roll is higher or lower
if %roll2% gtr %roll% (
    set result=higher
) else (
    set result=lower
)

rem Determine if user wins or loses
if %guess%==1 (
    if %result%==higher (
        echo Congratulations! You guessed %guess_text%. You win $%bet%.
        set /a cash+=%bet%
    ) else (
        echo Sorry! The number was %result%. You lose $%bet%.
        set /a cash-=%bet%
    )
) else (
    if %result%==lower (
        echo Congratulations! You guessed %guess_text%. You win $%bet%.
        set /a cash+=%bet%
    ) else (
        echo Sorry! The number was %result%. You lose $%bet%.
        set /a cash-=%bet%
    )
)

echo Your new balance is $%cash%.
choice /c YN /m "Do you want to play another round? "
if %errorlevel%==1 goto main

endlocal
