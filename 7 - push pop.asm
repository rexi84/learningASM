%include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)

zprava db "Hello", 0


section .text
global main
main:
    ;write your code here
    
    
    xor esi, esi
    
load:
    movzx eax, byte [zprava + esi]
    cmp eax, 0
    je endLoad
    
    push eax
    
    inc esi
    jmp load
    
endLoad:
    
    xor ecx, ecx
    
save:
    cmp ecx, esi
    je endPop
    
    pop eax
    PRINT_CHAR eax
    
    inc ecx
    jmp save
endPop:
    
    xor eax, eax
    ret