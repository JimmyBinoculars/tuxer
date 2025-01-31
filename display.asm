extern x11init

section .text
    global display

display:
    call x11init