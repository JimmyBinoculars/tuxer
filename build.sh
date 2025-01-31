#!/bin/bash
# Assemble everythin in 64 bit and make sure it returns error when compilation failed

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

# Link the object files to create the final executable
ld -o build/main build/main.o build/display.o build/hello.o
if [ $? -ne 0 ]; then
    echo "Error linking object files"
    exit 1
fi

echo "Build successful!"
