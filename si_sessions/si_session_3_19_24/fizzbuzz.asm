; 3-19-24 SI Session

section .data
    arr dw 12, 35, 95, 300, 4, 273, 15, 988, 33, 100    

section .bss
    fizz resw 10
    buzz resw 10
    fizzbuzz resw 10

section .text
    global _start

_start:
    mov rcx, 10
    mov rsi, 0
    mov rdi, 0
    mov r11, 0
    mov r12, 0

do_while_loop:
    ; arr[rsi] % 3 == 0
    mov ax, 0
    mov ax, word[arr+(rsi*2)]
    mov bx, 3
    div bx
    
    cmp dx, 0
    jne else_if_block_1

    ; arr[rsi] % 5 != 0
    mov dx, 0
    mov ax, word[arr+(rsi*2)]
    mov bx, 5
    div bx

    cmp dx, 0
    je else_if_block_1

    ; perform if block code
    mov dx, 0
    mov ax, 0
    mov ax, word[arr+(rsi*2)]
    mov [fizz+(rdi*2)], ax
    
    inc rdi
    inc rsi
    
    jmp check_loop_cond

else_if_block_1:
    ; arr[rsi] % 5 == 0
    mov ax, 0
    mov dx, 0
    mov ax, word[arr+(rsi*2)]
    mov bx, 5
    div bx

    cmp dx, 0
    jne else_if_block_2
    
    ; arr[rsi] % 3 != 0 
    mov ax, 0
    mov dx, 0
    
    cmp dx, 0
    je else_if_block_2

    mov dx, 0
    mov ax, 0
    mov ax, word[arr+(rsi*2)]
    mov [fizzbuzz+(r12*2)], ax

    inc r12
    inc rsi 

else_if_block_2:
    ; arr[rsi] % 3 == 0
    mov ax, 0
    mov dx, 0
    mov ax, word[arr+(rsi*2)]
    mov bx, 3
    div bx
    
    cmp dx, 0
    jne else

    ; arr[rsi] % 5 == 0
    mov ax, 0
    mov dx, 0
    mov ax, word[arr+(rsi*2)]
    mov bx, 5
    div bx

    cmp dx, 0
    jne else

    mov ax, 0
    mov dx, 0
    
    inc r12
    inc rsi

else:
    inc rsi
    jmp check_loop_cond

check_loop_cond:
    loop do_while_loop

end:

; div_by_3:
;     mov ax, 0
;     mov dx, 0
;     mov ax, word[arr+(rsi*2)]
;     mov bx, 3
;     div bx

; div_by_5: