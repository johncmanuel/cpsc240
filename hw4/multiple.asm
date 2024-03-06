; multiple.asm
; unsigned short num = 225; 	
; unsigned short mul_3 = 0, other = 0; 
; if (num % 3 == 0 && num % 5 != 0) {
;     mul_3++;
; } else {
;     other++;
; }


section .data
    num    dw 225
    mul_3  dw 0
    other  dw 0

section .text
    global _start

_start:
    ; num % 3
    mov dx, 0
    mov ax, word[num]
    mov bx, 3   
    div bx

    ; if remainder != 0, jump to else block
    cmp dx, 0
    jne else

    ; num % 5
    mov bx, 5
    mov ax, word[num]
    div bx
    
    ; if remainder == 0, jump to else block
    cmp dx, 0
    je else

    ; mul_3++
    inc word[mul_3]

    jmp end_program

else:
    ; other++
    inc word[other]
    jmp end_program

end_program:
    mov rax, 60
    mov rdi, 0
    syscall
    