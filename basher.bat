@ECHO OFF
rem ed 'D:\Program Files\MATLAB\R2020a\bin' - alreadi part of PATH
copy ..\Pretty_visuals.mlx .\PrettyVisuals.mlx
matlab -batch "matlab.internal.liveeditor.openAndConvert('PrettyVisuals.mlx','PrettyPrinted.m');exit"
