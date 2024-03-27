; signed short shortArr[10] = {-3012, 623, -1234, 2345, 3456, 1267, -89, 6232, -231, 0};
; signed short evenSum;
; register long rsi = 0	//64-bit register
; register long rdi = 0	//64-bit register
; while (num[rsi] != 0) {
; 	if(shortArr[rsi] < 0 && shortArr[rsi]%2 == 0) {
; 		evenSum += shortArr[rsi];
; 	}
; 	rsi++;
; }


section .data
    shortArr dw -3012, 623, -1234, 2345, 3456, 1267, -89, 6232, -231, 0 

section .bss
    evenSum resw 1    

section .text
    global _start

_start:
    mov rsi, 0
    mov rdi, 0
    mov word[evenSum], 0
    
while_loop:
    cmp word[shortArr+(rsi*2)], 0
    je end

    ; shortArr[rsi] < 0
    ; if shortArr[rsi] is not negative, condition fails
    jg increment_rsi

    ; shortArr[rsi] % 2 == 0
    mov dx, 0
    mov ax, word[shortArr+(rsi*2)]
    mov bx, 2
    div bx

    ; if shortArr[rsi] is not even, condition fails
    cmp dx, 0
    jne increment_rsi

    mov dx, 0
    mov ax, 0

    ; complete if block    
    mov ax, word[shortArr+(rsi*2)]
    add word[evenSum], ax
    jmp increment_rsi    

increment_rsi:
    inc rsi
    jmp while_loop

end:
    mov rax, 60
    mov rdi, 0
    syscall