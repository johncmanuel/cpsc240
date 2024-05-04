; finalproject.asm

; print(string, numChar)
%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

; scan(buffer, numChar)
%macro scan 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

section .data
    NULL equ 0
    LF equ 10
    lenMsg1 equ 25
    lenInput equ 10

    msg1 db "Enter operations string: ", NULL

section .bss
    buffer resb 100
    result resd 1

section .text
    global _start

_start:
    print msg1, lenMsg1
    scan buffer, 10
    mov rsi, 0

checkChar:
    ; check if index of current char is odd. 
    ; if so, check operators and perform operations
    ; this already assumes there are two numbers available
    mov rax, rsi
    mov rbx, 2
    div rbx
    cmp rdx, 0
    je checkAdd

    mov ah, byte[buffer+rsi]

    ; get the current and next even-indexed num
    ; if next even-index num is out of range or
    ; beyond length of current input, jump to end of
    ; program
    mov rcx, rsi
    add rcx, 2
    cmp rcx, lenInput
    ja print_data
    
    mov al, byte[buffer+rcx]
    jmp prepareNextIteration
    
checkAdd:
    cmp ah, "+"
    jne checkSub

    ; todo: add nums
    mov rax, 0
    

    ; after calculations, jump to prepareNextIteration
    ; and store result there
    jmp prepareNextIteration

checkSub:
    cmp byte[buffer+rsi], "-"
    jne checkMul
    jmp prepareNextIteration

checkMul:
    cmp byte[buffer+rsi], "*"
    jne checkDiv

checkDiv:
    cmp byte[buffer+rsi], "/"
    jne prepareNextIteration

prepareNextIteration:
    inc rsi
    ; cmp rsi, 

print_data:
    print buffer, 100

end:
    mov rax, 60
    mov rdi, 0
    syscall

to_integer:
    mov 