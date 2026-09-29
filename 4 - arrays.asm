q%include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)

    array dd 10, 20, 30, 40, 50
    ceny dd 15, 30, 10, 5, 100
    
    cisla dd 12, 55, 3, 98, 20
    pocet dd 5
    
section .text
global main
main:
    mov ebp, esp; for correct debugging
    mov ESI, 0
loop:
    mov eax, [array + esi * 4]
    PRINT_DEC 4, eax
    NEWLINE
    inc esi
    cmp esi, 5
    JNE loop
    
    NEWLINE
    NEWLINE
    
    xor eax, eax
    mov ESI, 0
loop1:
    add eax, [ceny + esi * 4]
    inc esi
    cmp esi, 5
    JNE loop1
    
    PRINT_DEC 4, eax
    
    NEWLINE
    NEWLINE
    
    xor eax, eax
    mov ESI, 0
    
    
    
loop2:
    cmp esi, [pocet]
    JGE end
    
    cmp eax, [cisla + esi * 4]
    jg next_iter
    mov eax, [cisla + esi * 4]
    
next_iter:
    inc esi
    jmp loop2
    
end:
    PRINT_DEC 4, eax
    
    
    ;write your code here
    xor eax, eax
    ret