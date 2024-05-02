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
    lenInput equ 100

    msg1 db "Enter operations string: ", NULL

section .bss
    buffer resb 100
    result resd 1

section .text
    global _start

_start:
    print msg1, lenMsg1
    scan buffer, 100
    mov rsi, 0

beginLoop:
    jmp checkChar 

checkChar:
    ; check if index of current char is odd. 
    ; if so, check operators
    mov rax, rsi
    mov rbx, 2
    div rbx
    cmp rdx, 0
    je checkAdd

    ; checks if current char is num 
    mov al, byte[buffer+rsi]
    cmp al, "0"
    jb prepareNextIteration
    cmp al, "9"
    ja prepareNextIteration

    mov rcx, rsi
    add rcx, 2
    
    ; checks next digit
    mov ah, byte[buffer+rcx]
    cmp ah, "0"
    jb prepareNextIteration
    cmp ah, "9"
    ja prepareNextIteration

checkAdd:
    cmp al, "+"
    jne checkSub

    ; todo: add nums

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

addition:
    ret

to_integer:
    mov 