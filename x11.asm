section .data
    titleString db 'My X11 Browser', 0   ; Window title
    textString db 'Hello, World!', 0      ; Text to display

section .bss
    display resq 1                        ; Store the display pointer
    windowID resq 1                       ; Store window ID

section .text
    global x11init

x11init:
    ; Open X11 Display
    mov rdi, 0                 ; NULL for default display
    syscall                    ; mmap or dlsym to get XOpenDisplay address
    mov [display], rdi         ; Store the display pointer

    ; Create Window
    mov rdi, [display]         ; Display pointer
    mov rsi, windowAttributes  ; Set up window attributes (size, etc.)
    mov rdx, windowSize        ; Size (width, height)
    syscall                    ; Call XCreateWindow
    mov [windowID], rdi        ; Store window ID

    ; Map Window
    mov rdi, [display]         ; Display pointer
    mov rsi, [windowID]        ; Window ID
    syscall                    ; Call XMapWindow

    ; Set Window Title
    mov rdi, [display]         ; Display pointer
    mov rsi, [windowID]        ; Window ID
    mov rdx, titleString       ; Title
    syscall                    ; Call XStoreName

    ; Draw Text
    mov rdi, [display]         ; Display pointer
    mov rsi, [windowID]        ; Window ID
    mov rdx, fontSize          ; Font size
    mov rcx, textString        ; Text to draw
    syscall                    ; Call XDrawString

    ; Event loop (basic)
event_loop:
    mov rdi, [display]         ; Display pointer
    mov rsi, eventStruct       ; Event structure
    syscall                    ; Call XNextEvent (wait for input)
    ; Process event here...

    ; Close Display (optional at the end)
    mov rdi, [display]         ; Display pointer
    syscall                    ; Call XCloseDisplay
