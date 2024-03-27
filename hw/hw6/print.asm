; print.asm
; 
; char str1[] = "1+2+3+...+99=";	// use db to declare 8-bit string array
; short sum = 0; 	// use dw to declare 16-bit variable
; char ascii[5] = "0000\n";	// use db to declare 8-bit string array
; register char cx = 1; 	// no need to declare register cx
; for(cx=1; cx<=99; cx++)
;     sum += cx;
; ascii = itoa(sum);
; cout << str1 << ascii;

section .data
    NULL equ 0
    LF equ 10
    SYS_write equ 1

    sum dw 0
    str1 db "1+2+3+...+99=", NULL
    ascii db "0000", LF, NULL  

section .text
    global _start

_start:
    mov cx, 1
    jmp sum_loop

sum_loop:
    add word[sum], cx
    inc cx

    ; if 99 <= cx, iterate the loop
    cmp cx, 99
    jbe sum_loop

    ; 4 digits to convert in ascii
    mov rcx, 3
    mov ax, word[sum]
    jmp print

print:
    mov dx, 0
    mov bx, 10
    div bx
    add byte[ascii+rcx], dl

    dec rcx
    cmp rcx, 0
    jge print

    ; print str1
    mov rax, SYS_write
    mov rdi, 1
    mov rsi, str1
    mov rdx, 13  ; len(str1) = 13
    syscall

    ; print ascii
    mov rax, SYS_write
    mov rdi, 1
    mov rsi, ascii
    mov rdx, 5  ; len(ascii) + NULL = 5
    syscall

    jmp end

end:
    mov rax, 60
    mov rdi, 0
    syscall
    