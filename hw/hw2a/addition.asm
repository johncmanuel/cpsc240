; addition.asm
; unsigned short num1 = 50000, num2 = 40000;
; unsigned int sum = 0;
; sum = int(num1 + num2);

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		dw	50000			; num1 = 50000
num2		dw	40000			; num2 = 40000
sum		dd	0			; sum = 0

section .text
        global _start
_start:

        ; add num1 and num2
        mov     ax, 0			
        mov     ax, word[num1]			
        add     ax, word[num2]
        adc     bx, 0                        

        ; add numbers and carry into sum
        mov     word[sum+0], ax
        mov     word[sum+2], bx

        mov     rax, SYS_exit			; terminate excuting process
        mov     rdi, EXIT_SUCCESS		; exit status
        syscall					; calling system services
