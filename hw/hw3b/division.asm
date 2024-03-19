; division.asm
; unsigned long num1 = 50000000000; 
; unsigned int num2 = 3333333;
; unsigned int quotient = 0, remainder = 0; 
; quotient = num1 / num2;
; remainder = num1 % num2;

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		dq	50000000000			
num2		dd	3333333			
quot		dd	0			
remd		dd	0			

section .text
    global _start
_start:
    mov     edx, dword[num1+4]	    
    mov     eax, dword[num1+0]
    div     dword[num2]

    mov     dword[quot], eax
    mov     dword[remd], edx

    mov     rax, SYS_exit			
    mov     rdi, EXIT_SUCCESS		
    syscall					        