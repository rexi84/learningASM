%include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)





section .text
global main
main:
    ;write your code here
    
    
    PRINT_STRING "test"
    call novy_radek
    call novy_radek
    PRINT_STRING "test"
    call novy_radek
    call novy_radek
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    mov eax, 10
    call mocnina
    PRINT_DEC 4, EAX
    
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    
    
    xor eax, eax
    ret
    
    
mocnina:
    IMUL eax, eax
    ret
    
    
novy_radek:
    NEWLINE
    ret