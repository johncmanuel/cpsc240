; input.asm
; 
; char num;
; char buffer;
; char msg1[] = "Input a number (1~9): ";
; char msg2[] = " is multiple of 3.";
; 
; register int r10 = 0;
; do {
; 	cout << msg1;
; 	cin >> buffer;
; 	num = atoi(buffer);
; 	if(num%3 == 0) {
; 		cout << buffer << msg2;
; 	}
; 	r10++;
; } while(r10 < 9);

section .data
    NULL equ 0

    SYS_write equ 1
    SYS_read equ 0

    len_msg1 equ 22
    len_msg2 equ 18

    msg1 db "Input a number (1~9): ", NULL
    msg2 db " is multiple of 3.", NULL

section .bss
    num resb 1
    buffer resb 1

section .text
    global _start

_start:
    mov r10, 0
    jmp while_loop

while_loop:
    ; print msg1
    mov rax, SYS_write
    mov rdi, 1
    mov rsi, msg1
    mov rdx, len_msg1
    syscall

    ; get input
    mov rax, SYS_read
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 2
    syscall

    mov al, byte[buffer]
    and al, 0fh
    mov byte[num], al

    ; check if num is divisible by 3
    mov ah, 0
    mov al, byte[num]
    mov bl, 3
    div bl
    cmp ah, 0

    jnz increment_loop

    ; print buffer value and msg2
    mov rax, SYS_write
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 1
    syscall

    mov rax, SYS_write
    mov rdi, 1
    mov rsi, msg2
    mov rdx, len_msg2
    syscall

    jmp increment_loop

increment_loop:
    inc r10

    cmp r10, 9
    jb while_loop

    jmp end_program

end_program:
    mov rax, 60
    mov rdi, 0
    syscall