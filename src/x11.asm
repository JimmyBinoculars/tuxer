extern hello
global x11init

section .data
    display_name db ":0", 0               ; Display name (":0" refers to the default display)
    window_title db "Hello", 0             ; Title of the window

section .bss
    display resq 1                         ; To store the display pointer
    window resq 1                          ; To store the window pointer
    event resb 256                         ; Buffer for the event

section .text
    extern XOpenDisplay, XCreateSimpleWindow, XStoreName, XMapWindow, XNextEvent, XCloseDisplay

x11init:
    ;call hello                           ;Only use for tests
    ; Open the display
    mov rdi, display_name                 ; Display name
    call XOpenDisplay                     ; Call XOpenDisplay

    ; Store the display pointer
    mov [display], rax

    ; Create the window
    mov rdi, [display]                    ; Display pointer
    mov rsi, 0                             ; Window parent (None, 0)
    mov rdx, 200                           ; Window width
    mov rcx, 200                           ; Window height
    call XCreateSimpleWindow              ; Call XCreateSimpleWindow

    ; Store the window pointer
    mov [window], rax

    ; Set the window title
    mov rdi, [display]                    ; Display pointer
    mov rsi, [window]                     ; Window pointer
    mov rdx, window_title                 ; Title
    call XStoreName                       ; Call XStoreName

    ; Map the window (show it)
    mov rdi, [display]                    ; Display pointer
    mov rsi, [window]                     ; Window pointer
    call XMapWindow                       ; Call XMapWindow

wait_event:
    ; Wait for an event (like window close)
    mov rdi, [display]                    ; Display pointer
    mov rsi, event                        ; Event buffer
    call XNextEvent                        ; Call XNextEvent

    ; Check for close event (for simplicity, assume event type 33 is close)
    movzx rax, byte [event]
    cmp rax, 33
    je cleanup

    ; Repeat waiting for events
    jmp wait_event

cleanup:
    ; Clean up and close the display
    mov rdi, [display]                    ; Display pointer
    call XCloseDisplay                    ; Call XCloseDisplay
    ret
