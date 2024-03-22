; 2-27-24 SI Session

; unsigned short num1 = 40000;
; unsigned short num2 = 60000;
; unsigned short num3 = 50000;
; unsigned short num4 = 201;
; unsigned int sum    = 0;

; unsigned long product = 0;
; unsigned int quotient = 0;

; sum = int(num1 + num2);
; product = long(sum * int(num3))
; quotient = int(product / int(num4));

section .data
    num1 dw 40000
    num2 dw 60000
    num3 dw 50000
    num4 dw 201
    sum  dd 0

    product  dq 0
    quotient dd 0

section .text
    global _start

_start:
    ; sum = int(num1 + num2)
    add ax, word[num1]
    add ax, word[num2]
    
    adc bx, 0
    mov word[sum+0], ax
    mov word[sum+2], bx 
    
    mov dword[sum], eax

    ; product = long(sum * int(num3))
    mov ax, word[num3]
    movzx eax, ax
    mul dword[sum]

    mov dword[product], eax
    mov dword[product+4], edx
    
    ; quotient = int(product / int(num4));
    mov edx, dword[product+0] 
    mov eax, dword[product+4]

    mov cx, word[num4]
    movzx ecx, cx

    div ecx
    mov dword[quotient], eax 

    ; end program
    mov rax, 60
    mov rdi, 0
    
