section .data
    window_title db 'Hello World', 0   ; Window title
    
section .bss
    display resq 1
    window  resq 1
    event   resb 128

section .text
    global x11
    extern XOpenDisplay, XCreateSimpleWindow, XStoreName, XMapWindow, XNextEvent, XCloseDisplay

x11:
    ; Open the display (this is equivalent to XOpenDisplay(NULL) in C)
    mov rdi, 0                ; NULL argument for XOpenDisplay
    call XOpenDisplay
    mov [display], rax        ; Store the display pointer
    
    ; Create a simple window (Display, Parent Window, X, Y, Width, Height, Border, Background)
    mov rdi, [display]        ; Display pointer
    mov rsi, 0                ; Parent window (root window)
    mov rdx, 10               ; X position
    mov rcx, 10               ; Y position
    mov r8, 300               ; Width
    mov r9, 200               ; Height
    mov r10, 1                ; Border width
    mov r11, 0xFFFFFF         ; Background color (white)
    call XCreateSimpleWindow
    mov [window], rax         ; Store the window pointer
    
    ; Set the window title (XStoreName)
    mov rdi, [display]        ; Display pointer
    mov rsi, [window]         ; Window pointer
    mov rdx, window_title     ; Title
    call XStoreName
    
    ; Map the window to make it visible (XMapWindow)
    mov rdi, [display]        ; Display pointer
    mov rsi, [window]         ; Window pointer
    call XMapWindow
    
    ; Event loop: wait for events
event_loop:
    mov rdi, [display]        ; Display pointer
    mov rsi, event            ; Event buffer
    call XNextEvent
    
    ; Check for the 'close' event (this is a simplified example)
    ; Normally you would need more sophisticated event handling
    ; to handle window close and other events.
    
    ; For this example, we'll just loop indefinitely.
    jmp event_loop

    ; Close the display (clean up)
    ; This would be done after the event loop ends (on program exit)
    mov rdi, [display]        ; Display pointer
    call XCloseDisplay
