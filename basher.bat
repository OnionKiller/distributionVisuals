ECHO OFF
rem ed 'D:\Program Files\MATLAB\R2020a\bin' - alreadi part of PATH
matlab -batch "matlab.internal.liveeditor.openAndConvert('..\Pretty_visuals.mlx','PrettyPrinted.m');exit"
