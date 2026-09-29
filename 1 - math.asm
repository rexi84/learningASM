 %include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)

    strana_a dd 5
    strana_b dd 8

    cas dd 125

    rano dd -5
    obed dd 10
    vecer dd -2
section .bss ; neurčené proměné

section .text ; kod
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    mov eax, [strana_a]
    add eax, [strana_b]
    imul eax, 2
    PRINT_DEC 4, eax
    NEWLINE
    ;--------------------------
    
    mov eax, [cas]
    xor edx, edx
    mov ebx, 60
    div ebx
    
    PRINT_STRING "Minuty: "
    PRINT_DEC 4, eax
    PRINT_STRING " Sekundy: "
    PRINT_DEC 4, edx
    NEWLINE
    ;------------------
    
    mov eax, [rano]
    add eax, [obed]
    add eax, [vecer]
    mov ebx, 3
    cdq
    IDIV ebx
    
    PRINT_STRING "Teplota: "
    PRINT_DEC 4, eax
    
    
    
    
    xor eax, eax
    ret