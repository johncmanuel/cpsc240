; subtraction.asm
; unsigned short num1 = 20000, num2 = 30000;
; signed int dif = 0;
; dif = int(num1 - num2);

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		dw	20000			
num2		dw	30000			
dif		dd	0			

section .text
	global _start
_start:
        ; get difference between num1 and num2
        mov     ax, word[num1] 			
        sub     ax, word[num2]

        ; account for carry and store in dif
	sbb	bx, 0				
        mov     word[dif+0], ax			
        mov     word[dif+2], bx			
						
        mov     rax, SYS_exit			
        mov     rdi, EXIT_SUCCESS		
        syscall					