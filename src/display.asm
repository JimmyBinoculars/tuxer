extern hello
;extern x11init

section .text
    global display

display:
    call hello
    ;call x11init