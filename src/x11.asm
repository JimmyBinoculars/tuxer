; Just a temporary file while I write the actual lib
bits 64
extern hello
global x11

section .text

x11:
    call hello
    
    ret