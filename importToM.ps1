%experimental
$matlab = 'D:\Program Files\MATLAB\R2020a\bin\matlab.exe' -batch 
$file = ..\PrettyVisuals.mlx
$outPath = .\PrettyVisuals.mlx
$matlab "matlab.internal.liveeditor.openAndConvert($file,$outPath)"
