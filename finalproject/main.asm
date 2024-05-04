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
    num1 resd 1
    num2 resd 1

section .text
    global _start

_start:
    print msg1, lenMsg1
    scan buffer, 10
    mov rsi, 0

checkChar:
    ; check if index of current char is odd. 
    ; if so, check operators and perform operations
    ; this  assumes there are two numbers available
    mov rdx, 0
    mov rax, rsi
    mov rbx, 2
    div rbx
    cmp rdx, 0
    jne checkAdd
    mov rbx, 0

    ; get the current and next even-indexed nums
    ; if next even-index num is out of range or
    ; beyond length of current input, jump to end of
    ; program
    mov rcx, rsi
    add rcx, 2
    cmp rcx, lenInput
    ja printData
    
    ; todo: convert digit into integer
    mov bl, byte[buffer+rsi]
    call toInteger
    mov dword[num1], edi
    
    mov bl, byte[buffer+rcx]
    call toInteger
    mov dword[num2], edi

    jmp prepareNextIteration
    
checkAdd:
    cmp byte[buffer+rsi], "+"
    jne checkSub

    mov ecx, dword[num1]
    mov edx, dword[num2]
    add ecx, edx
    add dword[result], ecx

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
    cmp rsi, lenInput
    jb checkChar

printData:
    print buffer, 100

end:
    mov rax, 60
    mov rdi, 0
    syscall

; converts ascii to integer and stores
; in edi
toInteger:
convert:
    mov dil, bl
    and dil, 0fh
    ; adc ah, 0
    movzx edi, dil
    ret    