%include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)

    vek dd 18


section .text
global main
main:;
;    ;write your code here
    
    mov eax, [vek]
    cmp eax, 18
    JGE more
    PRINT_STRING "Bez domu"
    jmp konec1
    
more:
    PRINT_STRING "Vstup povolen"
    
konec1:
    NEWLINE 
    NEWLINE
    
    mov eax, -20
    cmp eax, 0
    jg greater
    imul eax, -1 ; nebo: neg eax
    
greater:
    PRINT_DEC 4, eax
    
    NEWLINE
    NEWLINE
    mov eax, 10
    mov ebx, 20
    mov ecx, 50
    cmp eax, ebx
    jl editEAX
    jmp cont

editEAX:
    mov eax, ebx
    
cont:
    cmp eax, ecx
    jl editEAX2
    jmp end

editEAX2:
    mov eax, ecx
    
end:
    PRINT_DEC 4, eax
    
    
    
    
    
    xor eax, eax
    ret