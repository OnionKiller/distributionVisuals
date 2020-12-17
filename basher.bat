@ECHO OFF
rem ed 'D:\Program Files\MATLAB\R2020a\bin' - already part of PATH
FOR %%I in (.\interactive\*) DO matlab -batch "matlab.internal.liveeditor.openAndConvert('%%I','%%~nI.m');exit"
