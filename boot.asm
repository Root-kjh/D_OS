[org 0]
[bits 16]
    
jmp 0x07c0:start

start:
	mov ax, cs
	mov ds, ax
	mov ax, 0xB800
	mov es, ax
	mov di, 0
	mov ax, word[msgBack]
	mov cx, 0x7FF

paint:
	mov word[es:di],ax
	add di,2
	dec cx

	jnz paint

;하드 섹터 읽기
READ:
    mov     ax, 0x1000     ; ES:BX 에 로드된다
    mov     es, ax         ; 0x0800:0000 =  0x8000번지
    mov     bx, 0
 
    mov     ah, 2          ; 읽기 명령
    mov     al, 1          ; 읽을 섹터 수
    mov     ch, 0          ; 실린더 번호
    mov     cl, 2          ; 섹터 번호
    mov     dh, 0          ; 헤드 번호
    mov     dl, 0       ; 드라이브 번호, 0x00 = A:, 0x80 = C:
 
    int     0x13           ; 명령 실행
    jc      READ           ; 실패시 재시도

jmp 0x8000
msgBack db '.',0x17

times 510-($-$$) db 0x00
dw 0xaa55