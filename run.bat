@echo off
rem Compile + jalankan. Letakkan mysql-connector-j-*.jar di folder lib\ terlebih dahulu.
if not exist out mkdir out
dir /s /b src\*.java > sources.txt
javac -d out @sources.txt
if errorlevel 1 exit /b 1
java -cp "out;lib\*" esports.Main
