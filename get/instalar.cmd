@echo off
setlocal
title Instalar GET
echo Instalando GET para el usuario actual...
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
 "$dir = [IO.Path]::GetFullPath('%~dp0').TrimEnd('\');" ^
 "$old = [Environment]::GetEnvironmentVariable('Path','User');" ^
 "$parts = @($old -split ';' | Where-Object { $_ });" ^
 "if ($parts -notcontains $dir) { $new = (@($parts) + $dir) -join ';'; [Environment]::SetEnvironmentVariable('Path',$new,'User'); Write-Host 'GET agregado al PATH del usuario.' -ForegroundColor Green } else { Write-Host 'GET ya estaba en el PATH.' -ForegroundColor Green }"
if errorlevel 1 (
  echo No se pudo actualizar el PATH.
  pause
  exit /b 1
)
echo.
echo Cierra esta ventana y abre un CMD NUEVO.
echo Luego ejecuta: get help
echo.
pause
