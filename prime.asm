; Group Members
; Camilo Galvis Sierra - 40262950
; Daniel Henao - 40307519

section .data

number db 5
answer db 1 ; 1 means number is prime 0 means number is not prime
prime_msg db "Number is prime", 0x0a ; ASCII 0x0a = LINE FEED (for new line)
not_prime_msg db "Number is NOT prime", 0x0a ;

section .bss

section .text
    global _start

_start:
    mov ebx, 0 ; Clear EBX
    mov bl, 2 ; Sets two as divisor
    mov edx, 0; Clear entire EDX register
    mov dl, number; Move number into DL for the sake of comparison

_loopstart:
    mov eax, 0 ; Clear EAX
    mov al, number; Move number into lower half
    div bl ; divide number by 2
    and ax, 1111111100000000b ; Masks ax to only see the remainder

    jz _notPrimeMsg ; Display NOT prime message

    inc bl ; Increase the divisor
    cmp dl, bl ; Perform dl - bl
    jg _loopstart
    
    jmp _primeMsg ; Jump to prime message 

_primeMsg:
; This displays the message prime

_notPrimeMsg:
; This displays the message NOT prime

_exit:
    mov eax, 1  ; sys_exit
    xor ebx, ebx  ; Exit status 0
    int 0x80  ; Call kernel