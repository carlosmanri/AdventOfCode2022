#!/bin/bash

echo  "Compiling..."
nasm -f  elf32 -g -F dwarf main.asm -o main.o

echo "Linking..."
gcc -no-pie -g -m32 main.o -o main

echo "Cleaning..."
rm main.o

echo "Done."

echo "Executing..."
./main