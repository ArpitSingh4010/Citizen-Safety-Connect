@echo off
echo ============================================
echo Criminal Management - Build WAR File
echo ============================================
echo.

set "PROJECT_DIR=%~dp0Criminal Mangement"
set "TOMCAT_HOME=C:\apache-tomcat-10.1.52"

cd /d "%PROJECT_DIR%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to navigate to project directory
    pause
    exit /b 1
)

if not exist "src\main\java" (
    echo ERROR: src\main\java directory not found
    pause
    exit /b 1
)

if not exist "src\main\webapp" (
    echo ERROR: src\main\webapp directory not found
    pause
    exit /b 1
)

echo Cleaning previous build...
if exist "build\classes" rmdir /S /Q "build\classes"
if exist "build\criminal" rmdir /S /Q "build\criminal"
mkdir "build\classes"

setlocal EnableDelayedExpansion
set "JAVA_SOURCES="
for /R "src\main\java" %%F in (*.java) do (
    set "JAVA_SOURCES=!JAVA_SOURCES! "%%F""
)

if "!JAVA_SOURCES!"=="" (
    echo ERROR: No Java source files found under src\main\java
    pause
    exit /b 1
)

echo.
echo Compiling Java source files...
echo.

javac -d "build\classes" ^
    -cp "src\main\webapp\WEB-INF\lib\*;%TOMCAT_HOME%\lib\*" ^
    -encoding UTF-8 ^
    !JAVA_SOURCES!

if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ============================================
    echo Compilation FAILED!
    echo ============================================
    endlocal
    pause
    exit /b 1
)

echo.
echo Compilation successful!
echo.
echo Creating WAR directory structure...
mkdir "build\criminal\WEB-INF\classes"
mkdir "build\criminal\WEB-INF\lib"

echo Copying web resources...
xcopy "src\main\webapp\*" "build\criminal\" /E /I /Y /Q

echo Copying compiled classes...
xcopy "build\classes\*" "build\criminal\WEB-INF\classes\" /E /I /Y /Q

echo Copying libraries...
xcopy "src\main\webapp\WEB-INF\lib\*" "build\criminal\WEB-INF\lib\" /E /I /Y /Q 2>nul

endlocal

echo.
echo ============================================
echo Build successful!
echo ============================================
echo.
echo Output: build\criminal (exploded WAR)
echo.
echo Next step:
echo   Run: deploy.bat
echo.
pause
