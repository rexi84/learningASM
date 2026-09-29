%include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)
    text db "Ahoj", 0
    veta db "assembler je fakt masakr", 0

section .text
global main
main:
    ;write your code here
    
    xor esi, esi
    xor ecx, ecx
    
loop:
    movzx eax, byte [veta + esi]
    
    cmp eax, 0
    je end
    
    cmp eax, 'a'
    jne skip
    inc ecx
    
skip:
    inc esi
    jmp loop
    
end:
    PRINT_DEC 4, ecx

    xor eax, eax
    ret