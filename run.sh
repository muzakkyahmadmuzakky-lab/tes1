#!/bin/sh
# Compile + jalankan. Letakkan mysql-connector-j-*.jar di folder lib/ terlebih dahulu.
mkdir -p out
javac -d out $(find src -name "*.java") || exit 1
java -cp "out:lib/*" esports.Main
