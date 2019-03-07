[org 0]
[bits 16]
    jmp 0x7c0:start

start:
    mov ax, cs
    mov ds, ax
    mov es, ax
    
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov ax, word[msg]
    mov cx,0x7FF

paint:
    mov word[es:di], ax
    add di, 2
    dec cx
    jnz paint

 read:
    mov ax,0x1000
    mov es, ax
    mov bx, 0

    mov ah, 2
    mov dl, 0
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov al, 1

    int 0x13

    jc read
    jmp 0x1000:0000

msg db '.',0x17

times 510-($-$$) db 0

dw 0xAA55