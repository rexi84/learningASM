%include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)

    N dd 3

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    mov ecx, 10
    
loop:
    PRINT_DEC 4, ecx
    NEWLINE
    dec ecx
    JNZ loop
    
    PRINT_STRING "START!"
    NEWLINE
    xor eax, eax
    xor ecx, ecx
    NEWLINE
    
    
    mov ecx, 0 ;nevím, jaký register mám použít
loop2:
    inc ecx
    add eax, ecx
    cmp ecx, [N]
    JNE loop2
    
    PRINT_DEC 4, eax
        
    NEWLINE
    NEWLINE
    xor ecx, ecx
    NEWLINE
    ;---------------
    
    mov eax, 10
    xor edx, edx
    
loopStart:
    cmp eax, 1
    je loopEnd
    
    inc ecx    
    mov ebx, eax
    mov esi, 2
    xor edx, edx
    div esi
    cmp edx, 0 ;- asi nepotřebné, protože pro update ZF se použije DIV
    jz loopStart
    
    mov eax, ebx
    imul eax, 3
    inc eax
    jmp loopStart
    
loopEnd:
    PRINT_STRING "Pocet pruchodu: "
    PRINT_DEC 4, ecx
    xor eax, eax
    ret