extern display

section .text
    global _start

_start:
    call display
    mov rax, 60
    mov rdi, 0
    syscall