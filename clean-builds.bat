@echo off
echo ============================================
echo Clean build artifacts (safe, non-destructive)
echo ============================================

REM Delete local build and dist folders
if exist "Criminal Mangement\build" (
    echo Removing Criminal Mangement\build
    rmdir /S /Q "Criminal Mangement\build"
)

if exist "Criminal Mangement\dist" (
    echo Removing Criminal Mangement\dist
    rmdir /S /Q "Criminal Mangement\dist"
)

if exist "build" (
    echo Removing root build\
    rmdir /S /Q "build"
)

echo Done. To untrack these in git run the commands shown in README.md.
pause
