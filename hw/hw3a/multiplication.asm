; unsigned int num1 = 300000, num2 = 400000;
; unsigned long product = 0;
; product = long(num1 * num2);

section .data
SYS_exit	    equ	60
EXIT_SUCCESS	equ	0
num1		    dd	300000			;num1 = 300000
num2		    dd	400000			;num2 = 400000
product		    dq	0			    ;product = 0

section .text
    global _start
_start:
    mov     eax, dword[num1]			
    mul     dword[num2]			     ; result in edx:eax
    mov     dword[product], eax
    mov     dword[product+4], edx			

    mov     rax, SYS_exit			
    mov     rdi, EXIT_SUCCESS		
    syscall					
