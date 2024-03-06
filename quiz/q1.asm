; CPSC 240: Quiz 1
;  
; unsigned short num1 = 50000;			
; unsigned short num2 = 30000;			
; unsigned short num3 = 60000;			
; unsigned int sum = 0;						
; unsigned long product = 0;				
; 
; sum = int(num1 + num2);
; product = int(num3) * sum;


section .data
    num1 dw 50000
    num2 dw 30000
    num3 dw 60000

    sum dd 0
    product dq 0

section .text
    global _start

_start:
    ; sum = int(num1 + num2);
    mov ax, 0
    mov ax, word[num1]
    add ax, word[num2]
    adc bx, 0

    mov word[sum+0], ax
    mov word[sum+2], bx

    ; product = int(num3) * sum;
    mov ax, word[num3]
    movzx eax, ax

    mul dword[sum]
    mov dword[product+0], eax
    mov dword[product+4], edx

    ; end program
    mov rax, 60
    mov rdi, 0
    syscall
