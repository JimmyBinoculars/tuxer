#!/bin/bash
# Assemble everything in 64-bit and make sure it returns error when compilation failed

# Ensure libX11.so is in the ./lib directory
if [ ! -f ./lib/libX11.so ]; then
    echo "libX11.so not found in ./lib directory."
    echo "Please ensure you have placed libX11.so in the ./lib directory."
    exit 1
fi

# Assemble helloWorld.asm to hello.o
nasm -f elf64 -o build/hello.o src/helloWorld.asm
if [ $? -ne 0 ]; then
    echo "Error assembling helloWorld.asm"
    exit 1
fi

# Assemble x11.asm to x11.o
nasm -f elf64 -o build/x11.o src/x11.asm
if [ $? -ne 0 ]; then
    echo "Error assembling x11.asm"
    exit 1
fi

# Assemble display.asm to display.o
nasm -f elf64 -o build/display.o src/display.asm
if [ $? -ne 0 ]; then
    echo "Error assembling display.asm"
    exit 1
fi

# Assemble main.asm to main.o
nasm -f elf64 -o build/main.o src/main.asm
if [ $? -ne 0 ]; then
    echo "Error assembling main.asm"
    exit 1
fi

# Link the object files to create the final executable using the local libX11.so
ld -o build/main build/main.o build/display.o build/hello.o build/x11.o -L./lib -lX11 -dynamic-linker /lib64/ld-linux-x86-64.so.2
if [ $? -ne 0 ]; then
    echo "Error linking object files"
    exit 1
fi

echo "Build successful!"
