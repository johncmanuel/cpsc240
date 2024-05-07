; main.asm
; Final project for CPSC 240
; John Carlo Manuel
; 5-10-24

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
    lenMsg2 equ 3

    result dw 0
    msg1 db "Enter operations string: ", NULL
    msg2 db " = ", NULL

section .bss
    buffer resb 10
    ascii resb 10

section .text
    global _start

_start:
    print msg1, lenMsg1
    scan buffer, lenInput

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

    ; if counter pointing to the next number after the 
    ; current elem is out of range, end loop
    mov rbx, rsi
    add rbx, 2
    cmp rbx, lenInput
    ja printData

    ; use r8d to store next number and continue to
    ; next element (which should be an operator)
    mov bl, byte[buffer+rbx]
    call toInteger
    mov r8d, edi

    jmp prepareNextIteration

; Perform addition operation if current character is "+" 
checkAdd:
    cmp byte[buffer+rsi], "+"
    jne checkSub
    add dword[result], r8d
    jmp prepareNextIteration

; Perform subtraction operation if current character is "-"
checkSub:
    cmp byte[buffer+rsi], "-"
    jne checkMul
    sub dword[result], r8d    
    jmp prepareNextIteration

; Perform multiplication operation if current character is "*" 
checkMul:
    cmp byte[buffer+rsi], "*"
    jne checkDiv
    mov eax, dword[result]
    mul r8d
    mov dword[result], eax
    jmp prepareNextIteration

; Perform division operation if current character is "/" 
checkDiv:
    cmp byte[buffer+rsi], "/"
    jne prepareNextIteration
    mov eax, dword[result]
    mov edx, 0
    div r8d
    mov dword[result], eax

; Perform the next iteration of the loop
prepareNextIteration:
    inc rsi
    cmp rsi, lenInput
    jb checkChar

; Print the data to the console
printData:
    mov rbx, 0
    mov edi, dword[result]
    call toString

    print buffer, lenInput
    print msg2, lenMsg2
    print ascii, 10

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
    movzx edi, dil
    ret    

; converts integer to ascii
; and stores pop 
toString:
    mov eax, dword[result]
    mov rcx, 0
    mov ebx, 10
pushLoop:
    mov edx, 0
    div ebx
    push rdx
    inc rcx
    
    cmp eax, 0
    jne pushLoop

    mov rbx, ascii
    mov rdi, 0
popLoop:
    pop rax
    add al, "0"
    mov byte[rbx+rdi], al
    inc rdi
    loop popLoop
    mov byte[rbx+rdi], LF
    ret  
