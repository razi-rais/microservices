@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set arg1=%1

FOR /F "tokens=* USEBACKQ" %%F IN (`wmic cpu get NumberOfCores`) DO (
  SET str=%%F
 )
set str=%str:NumberOfCores =%
FOR /L %%n IN (1,1, %str% ) DO ( start %arg1% )
