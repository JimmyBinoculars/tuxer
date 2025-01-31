global hello

section .text

hello:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msglen
    syscall

    ret

    ; How tf did I not notice that the program exits here
    ;mov rax, 60
    ;mov rdi, 0
    ;syscall

section .rodata
    msg: db "Hello, World!", 0x0A,0
    msglen: equ $ - msg