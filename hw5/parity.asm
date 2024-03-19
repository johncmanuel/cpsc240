; parity.asm
; unsigned short array[7] = {12, 1003, 6543, 24680, 789, 30123, 32766};	// use dw for 16-bit array
; unsigned short even[7]; 	// use dw to declare 16-bit variable
; register long rsi = 0, rdi = 0; 	// no need to declare register rsi and rdi
; do {
; 	if(array[rsi] % 2 == 0) {
; 		even[rdi] = array[rsi];
; 		rdi++;
; 	}
; 	rsi++;
; } while(rsi < 7);


section .data
    array dw 12, 1003, 6543, 24680, 789, 30123, 32766

section .bss
    even resw 7 

section .text
    global _start

_start:
    mov rsi, 0
    mov rdi, 0
    mov dx, 0

do_while_loop:
    mov ax, word[array+(rsi*2)]
    mov bx, 2
    div bx
    
    cmp dx, 0
    jne not_even
    
    ; if it is even, add the current array value to even
    mov ax, 0
    mov ax, word[array+(rsi*2)]
    mov [even+(rsi*2)], ax
    inc rdi

not_even:
    inc rsi
    
    cmp rsi, 7
    jb do_while_loop
    
    jmp end_program

end_program:
    mov rax, 60
    mov rdi, 0
    syscall

