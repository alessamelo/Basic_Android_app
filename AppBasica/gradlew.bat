@echo off
setlocal enabledelayedexpansion

set ROOT_DIR=%~dp0
set PROPS_FILE=%ROOT_DIR%gradle\wrapper\gradle-wrapper.properties

if not exist "%PROPS_FILE%" (
  echo ERROR: Missing %PROPS_FILE%
  exit /b 1
)

for /f "tokens=1,* delims==" %%A in (%PROPS_FILE%) do (
  if "%%A"=="distributionUrl" set DIST_URL=%%B
)

if "%DIST_URL%"=="" (
  echo ERROR: distributionUrl not found in gradle-wrapper.properties
  exit /b 1
)

if "%GRADLE_USER_HOME%"=="" set GRADLE_USER_HOME=%USERPROFILE%\.gradle
set DIST_DIR=%GRADLE_USER_HOME%\wrapper\dists

if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"

for %%F in ("%DIST_URL%") do set ZIP_NAME=%%~nxF
set ZIP_BASE=%ZIP_NAME:.zip=%

set TARGET_DIR=%DIST_DIR%\%ZIP_BASE%\manual
set GRADLE_HOME=%TARGET_DIR%\%ZIP_BASE%

if not exist "%GRADLE_HOME%" (
  echo Gradle distribution not found locally. Please download:
  echo   %DIST_URL%
  echo and unzip it into:
  echo   %TARGET_DIR%
  exit /b 1
)

"%GRADLE_HOME%\bin\gradle.bat" %*
endlocal
