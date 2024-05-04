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
    result dw 0

    msg1 db "Enter operations string: ", NULL

section .bss
    buffer resb 100
    ; todo: rather than using curr and next,
    ; just use result and a register to hold current value
    ; curr resd 1

section .text
    global _start

_start:
    print msg1, lenMsg1
    scan buffer, 10

    ; store 1st elem (expected to be a number)
    ; in result 
    mov rsi, 0
    mov bl, byte[buffer+rsi]
    call toInteger
    mov dword[result], edi

    ; start at 2nd element of buffer arr,
    ; which should be an operator
    inc rsi

    ; get next elem after operator, which will be
    ; a num
    mov bl, byte[buffer+(rsi+1)]
    call toInteger
    mov r8d, edi

checkChar:
    ; check if index of current char is odd. 
    ; if so, check operators and perform operations
    mov rdx, 0
    mov rax, rsi
    mov rbx, 2
    div rbx
    cmp rdx, 0
    jne checkAdd
    mov rbx, 0

    ; if counter pointing to 
    ; next elem after current elem is out of range,
    ; end loop
    mov rbx, rsi
    add rbx, 1
    cmp rbx, lenInput
    jb printData

    ; use r8d to store next number and continue to
    ; next element (which should be an operator)
    mov bl, byte[buffer+rbx]
    call toInteger
    mov r8d, edi

    jmp prepareNextIteration
    
checkAdd:
    cmp byte[buffer+rsi], "+"
    jne checkSub
    add dword[result], r8d
    jmp prepareNextIteration

checkSub:
    cmp byte[buffer+rsi], "-"
    jne checkMul
    sub dword[result], r8d    
    jmp prepareNextIteration

checkMul:
    cmp byte[buffer+rsi], "*"
    mov rbx, 0
    mov eax, dword[result]
    ; mul r8d
    ; mov dword[]

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
; in edi. bl represents the ascii value
toInteger:
convert:
    mov dil, bl
    and dil, 0fh
    ; adc ah, 0
    movzx edi, dil
    ret    