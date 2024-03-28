
section .data

section .bss

section .text
    global _start

_start:
    ; something here

end:
    mov rax, 60
    mov rdi, 0
    syscall



; Notes for myself:
; Need to design a 1-digit integer calculator that supports
; the basic arithmetic operations.
; Example input: 3+5*3/5-4
; 
; Since input is a string, will need to loop through each character and check
; if its numerical or an operation
