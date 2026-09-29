%include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)
    
    zprava db "ahoj", 0

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    xor ecx, ecx
loop:
    cmp ecx, 24
    je end
    PRINT_STRING [zprava]
    NEWLINE
    call sifruj
    
    inc ecx
    jmp loop
end:
    
    xor eax, eax
    ret
    
    
sifruj:

    xor esi, esi
loopS:
    movzx eax, byte [zprava + esi]
    cmp eax, 0
    je endS

    inc eax
    mov [zprava + esi], al

    inc esi
    jmp loopS
    
endS:

    ret