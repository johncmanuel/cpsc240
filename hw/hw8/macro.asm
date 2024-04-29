; macro.asm
; 
; #begin define print(string, numOfChar)
; 	rax = 1;
; 	rdi = 1;
; 	rsi = &string;
; 	rdx = numOfChar;
; 	syscall;
; #end
; #begin define scan(buffer, numOfChar)
; 	rax = 0;
; 	rdi = 0;
; 	rsi = &buffer;
; 	rdx = numOfChar;
; 	syscall;
; #end

; char buffer[4];
; int n;
; int sumN;
; char msg1[26] = "Input a number (004~999): ";
; char msg2[16] = "1 + 2 + 3 +...+ ";
; char msg3[4] = " = ";
; char ascii[10];

; print(msg1, 26);
; scan(buffer, 4);
; n = atoi(buffer);
; rsi = 0;
; do {
;     sumN += rsi;
; } while(rsi >= 0);
; ascii = itoa(sumN);
; print(msg2, 16);
; print(buffer, 3);
; print(msg3, 3);
; print(ascii, 7);


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

    msg1 db "Input a number (004~999): ", NULL
    msg2 db "1 + 2 + 3 +...+ ", NULL
    msg3 db " = ", NULL

section .bss
    buffer resb 4
    n resd 1
    sumN resd 1
    ascii resb 10

section .text
    global _start

_start:
    print msg1, 26
    scan buffer, 4

    mov eax, 0
    mov ebx, 10
    mov rsi, 0

convert_loop:
    ; convert ascii to integer and
    ; store buffer in cl
    mov cl, byte[buffer+rsi]
    and cl, 0fh
    add al, cl
    adc ah, 0
    
    cmp rsi, 2
    je skip_mul

    mul ebx 

skip_mul:
    inc rsi
    cmp rsi, 3
    jl convert_loop

    mov dword[n], eax
    
    mov rsi, 0

sum_loop:
    add dword[sumN], esi
    inc rsi

    ; move n into rbx for comparison
    mov eax, dword[n]
    mov rbx, 0 
    mov ebx, eax

    cmp rsi, rbx
    jbe sum_loop  ; if rsi <= n, iterate loop

    ; convert sum to ascii
    mov eax, dword[sumN]
    mov rcx, 0
    mov ebx, 10

divide_loop:
    mov edx, 0
    div ebx
    push rdx

    inc rcx
    cmp eax, 0
    jne divide_loop

    mov rbx, ascii
    mov rdi, 0

pop_loop:
    pop rax
    add al, "0"
    mov byte[rbx+rdi], al
    
    inc rdi
    loop pop_loop
    
    mov byte[rbx+rdi], 10  ; LF (newline) = 10

print_data:
    print msg2, 16
    print buffer, 3
    print msg3, 3
    print ascii, 7

end_program:
    mov rax, 60
    mov rdi, 0
    syscall