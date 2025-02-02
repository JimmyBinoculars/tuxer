bits 64
extern x11
global display

section .text

display:
    call x11
    ret