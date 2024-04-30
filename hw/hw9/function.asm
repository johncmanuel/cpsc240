; function.asm
; 
; #begin define print(addr, n)
; 	rax = 1;
; 	rdi = 1;
; 	rsi = addr of string;
; 	rdx = n;
; 	syscall;
; #end
; #begin define scan(addr, n)
; 	rax = 1;
; 	rdi = 1;
; 	rsi = addr of buffer;
; 	rdx = n;
; 	syscall;
; #end
; void main() {
; 	char buffer[4];
; 	int n;
; 	int sumN;
; 	char ascii[10];
; 	char msg1[26] = "Input a number (004~999): ";
; 	char msg2[16] = "1 + 2 + 3 +...+ ";
; 	char msg3[4] = " = ";

; 	print(msg1, 26);
; 	scan(buffer, 4);
; 	call to_integer(n, buffer);
; 	call calculate(n, sumN);
; 	call to_string(n, ascii);
; 	print(msg2, 16);
; 	print(buffer, 3);
; 	print(msg3, 3);
; 	print(ascii, 6);
; }
; void to_integer(n, buffer) {
; 	n = atoi(buffer);
; }
; void calculate(n, sumN) {
; 	for(ecx=0; ecx<=n; ecx++) {
; 		sumN += ecx;
; 	}
; }
; void to_string(sumN, ascii) {
; 	ascii = itoa(sumN);
; }

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

    ; call to_integer(n, buffer);
    mov rbx, buffer
    call to_integer

    ; call calculate(n, sumN);
    mov ecx, 0
    mov edi, dword[n]
    call calculate

    ; call to_string(n, ascii);
    mov rcx, 3
    mov edi, dword[sumN]
    call to_string

    print msg2, 16
	print buffer, 3
	print msg3, 3
	print ascii, 7

    mov rax, 60
    mov rdi, 0
    syscall

to_integer:
    mov rax, 0
    mov rdi, 10
    mov rsi, 0
next0:
    mov cl, byte[rbx+rsi]
    and cl, 0fh
    add al, cl
    adc ah, 0

    cmp rsi, 2
    je skip0
    
    mul edi
skip0:
    inc rsi
    cmp rsi, 3
    jl next0

    mov dword[n], eax

    ret

calculate:
next1:
    add dword[sumN], ecx
    inc ecx
    cmp ecx, edi
    jbe next1  ; if (ecx <= n) jump back to next1
    ret

to_string:
    mov eax, dword[sumN]
    mov rcx, 0
    mov ebx, 10
divide_loop:
    mov edx, 0
    div ebx
    push rdx
    inc rcx

    ; if eax > 0, continue loop 
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

    ret
