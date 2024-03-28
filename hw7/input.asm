; input.asm
; 
; char num;
; char buffer;
; char msg1[] = "Input a number (1~9): ";
; char msg2[] = " is multiple of 3.";
; 
; register int r10 = 0;
; do {
; 	cout << msg1;
; 	cin >> buffer;
; 	num = atoi(buffer);
; 	if(num%3 == 0) {
; 		cout << buffer << msg2;
; 	}
; 	r10++;
; } while(r10 < 9);

section .data


section .bss
    num resb 1
    buffer resb 1

section .text
    global _start

_start:



end:
    mov rax, 60
    mov rdi, 0
    syscall