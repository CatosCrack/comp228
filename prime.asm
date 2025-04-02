; Group Members
; Camilo Galvis Sierra - 40262950
; Daniel Henao - 40307519

section .data

number db 5
answer db 1 ; 1 means number is prime 0 means number is not prime

prime_msg db "Number is prime", 0x0a ;
lenPrime equ $ - prime_msg ; calculate message lenght

not_prime_msg db "Number is NOT prime", 0x0a ;
lenNoPrime equ $ - not_prime_msg ; calculate message lenght

section .bss

section .text
    global _start

_start:
    mov ebx, 0 ; Clear EBX
    mov bl, 2 ; Sets two as divisor
    mov edx, 0; Clear entire EDX register
    mov dl, [number]; Move number into DL for the sake of comparison

_loopstart:
    cmp dl, bl ; compare if both numbers are equal
    je _primeMsg ; Jump to prime message if equal

    mov eax, 0 ; Clear EAX
    mov al, [number]; Move number into lower half


    div bl ; divide number by 2
    
    cmp ah, 0;
    je _notPrimeMsg ; Display NOT prime message if quotient is zero
    
    cmp dl, bl ; Perform dl - bl
    inc bl ; Increase the divisor
    jg _loopstart 

_notPrimeMsg:
    mov answer, 0 ; Assign answer as zero to indicate number is not prime 
    mov edx, 0 ; Clear EDX
    mov ecx, 0 ; Clear ECX
    mov ebx, 0 ; Clear EBX
    mov eax, 0 ; Clear EAX
    mov edx, lenNoPrime ; Assign message length to EDX
    mov ecx, not_prime_msg ; Load message address to ECX
    mov ebx, 1 ; Define stdout
    mov eax, 4 ; Define sys_write
    int 0x80 ; Call kernel
    jmp _exit ; Quit program

_primeMsg:
    mov edx, 0 ; Clear EDX
    mov ecx, 0 ; Clear ECX
    mov ebx, 0 ; Clear EBX
    mov eax, 0 ; Clear EAX
    mov edx, lenPrime ; Assign message length to EDX 
    mov ecx, prime_msg ; Load message address to ECX
    mov ebx, 1 ; Define stdout
    mov eax, 4 ; Define sys_write
    int 0x80 ; Call kernel
    jmp _exit ; Quit program

_exit:
    mov eax, 1  ; sys_exit
    xor ebx, ebx  ; Exit status 0
    int 0x80  ; Call kernel