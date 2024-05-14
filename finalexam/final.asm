;finalExam_01.asm
; #begin define print(addr, n)
; 	rax = 1;
; 	rdi = 1;
; 	rsi = addr of string;
; 	rdx = n;
; 	syscall;
; #end
; #begin define scan(&addr, n)
; 	rax = 1;
; 	rdi = 1;
; 	rsi = &addr;
; 	rdx = n;
; 	syscall;
; #end

; char num1, num2, num3, sum, quotient;
; char buffer[2];
; char ascii[10];
; char msg1[24] = "Input 1st number (0~9): ";
; char msg2[24] = "Input 2nd number (0~9): ";
; char msg3[24] = "Input 3rd number (0~9): ";
; char msg4[6]  = "sum = ";
; char msg5[11] = "quotient = ";
; void main() {
; 	print msg1, 24;
; 	scan buffer, 2
; 	num1 = atoi(buf);
; 	print msg2, 24;
; 	scan buffer, 2
; 	num2 = atoi(buf)
; 	print msg3, 24;
; 	scan buffer, 2
; 	num3 = atoi(buf)

; 	call calculate(num1, num2, num3, &sum, &quotient);
; 	call toString(&sum, &ascii)
; 	print msg4, 6;
; 	print ascii, 4;
; 	call toString(&quotient, &ascii)
; 	print msg5, 11;
; 	print ascii, 4;
; }
; void calculate(num1, num2, num3, &sum, &quotient) {
; 	sum = num1 + num2;
; 	if(num3 != 0)
; 		quotient = sum / num3;
; 	else
; 		quitient = 0;
; }
; void toString(&argument, &ascii) {
;  	ascii = itoa(argument);
; }


%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro scan 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

section .data
    LF equ 10
    NULL equ 0

    msg1 db "Input 1st number (0~9): ", NULL
    msg2 db "Input 2nd number (0~9): ", NULL
    msg3 db "Input 3rd number (0~9): ", NULL
    msg4 db "sum = ", NULL
    msg5 db "quotient = ", NULL

section .bss
    num1 resb 1
    num2 resb 1
    num3 resb 1
    sum resb 1
    quotient resb 1

    buffer resb 2
    ascii resb 10

section .text
    global _start

_start:
    print msg1, 24
    scan buffer, 2
    mov al, byte[buffer]
    and al, 0fh
    mov byte[num1], al

    print msg2, 24
    scan buffer, 2
    mov al, byte[buffer]
    and al, 0fh
    mov byte[num2], al

    print msg3, 24
    scan buffer, 2
    mov al, byte[buffer]
    and al, 0fh
    mov byte[num3], al

    mov dil, byte[num1]
    mov sil, byte[num2]
    mov dl, byte[num3]
    call calculate
    mov byte[sum], r8b
    mov byte[quotient], r9b

    mov rdi, sum
    mov rsi, ascii
    call toString
    print msg4, 6
	print ascii, 4

    mov rdi, quotient
    mov rsi, ascii
    call toString
    print msg5, 11
	print ascii, 4

end:
    mov rax, 60
    mov rdi, 0
    syscall

; dil = num1
; sil = num2
; dl = num3
; r8b = sum
; r9b = quotient
calculate:
    mov al, dil
    add al, sil
    mov r8b, al
    cmp dl, 0
    je elseState ; if num3 is 0, jump to elseState
    ; else, calculate quotient
    mov al, r8b
    mov ah, 0
    div dl
    mov r9b, al
    jmp endHere
elseState:
    mov r9b, 0
    jmp endHere
endHere:
    ret

; Convert integer to ASCII
; rdi = argument
; rsi = ascii
toString:
    movzx eax, byte[rdi]
    mov rcx, 0
    mov ebx, 10
pushLoop:
    mov edx, 0
    div ebx
    push rdx
    inc rcx

    cmp eax, 0
    jne pushLoop

    mov rbx, rsi
    mov rdi, 0
popLoop:
    pop rax
    add al, "0"
    mov byte[rbx+rdi], al
    inc rdi
    loop popLoop
    mov byte[rbx+rdi], LF 
    ret