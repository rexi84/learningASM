%include "io.inc"

;[x] - promněná
; x  - pointer

section .data ; určené proměné
;dd - číslo (4 bajty)
;db - znaky (1 bajt)

    array db '1','2','3','4','5','6','7','8','9'
    playerTurn dd 1

section .bss ; neurčené proměné
    ;playerTurn resd 1

section .text
global main
main:
    ;write your code here
    
loop:
    call printArray
    call chckWinner
    mov eax, [playerTurn]
    cmp eax, 1
    je player1
    jg player2
    jl end
    
    
    
    
player1:
    PRINT_STRING "NOW PLAYING: player 1"; input
    NEWLINE
    PRINT_STRING "ENTER YOUR field: "
    GET_DEC 4, esi
    sub esi, 1
    
    cmp esi, 0 ; check smaller than 0
    jl player1error
    
    cmp esi, 8 ; check bigger than 8
    jg player1error
    
    mov eax, 'X' ; check for used 'X'
    cmp [array + esi], al
    je player1error
    
    mov eax, 'O' ; check for used '0'
    cmp [array + esi], al
    je player1error
    
    
    mov eax, 'X' ; writte value
    mov [array + esi], al
    
    mov eax, 2 ; change player turn
    mov [playerTurn], eax
    
    jmp loop ; jump back to loop    

    
player1error:
    PRINT_STRING "WRONG VALUE"
    NEWLINE
    jmp player1
    
player2:
    PRINT_STRING "NOW PLAYING: player 2"; input
    NEWLINE
    PRINT_STRING "ENTER YOUR field: "
    GET_DEC 4, esi
    sub esi, 1
    
    cmp esi, 0 ; check smaller than 0
    jl player2error
    
    cmp esi, 8 ; check bigger than 8
    jg player2error
    
    mov eax, 'X' ; check for used 'X'
    cmp [array + esi], al
    je player2error
    
    mov eax, 'O' ; check for used '0'
    cmp [array + esi], al
    je player2error
    
    
    mov eax, 'O' ; writte value
    mov [array + esi], al
    
    mov eax, 1 ; change player turn
    mov [playerTurn], eax
    
    jmp loop ; jump back to loop    

    
player2error:
    PRINT_STRING "WRONG VALUE"
    NEWLINE
    jmp player2

    
    
    
    
    
    
    
    ;jmp loop
    
end:
    xor eax, eax
    ret
    
    
    
printArray:
    PRINT_CHAR [array]
    PRINT_CHAR "|"
    PRINT_CHAR [array + 1]
    PRINT_CHAR "|"
    PRINT_CHAR [array + 2]
    
    NEWLINE
    PRINT_STRING "-+-+-"
    NEWLINE
    
    PRINT_CHAR [array + 3]
    PRINT_CHAR "|"
    PRINT_CHAR [array + 4]
    PRINT_CHAR "|"
    PRINT_CHAR [array + 5]
    
    NEWLINE
    PRINT_STRING "-+-+-"
    NEWLINE
    
    PRINT_CHAR [array + 6]
    PRINT_CHAR "|"
    PRINT_CHAR [array + 7]
    PRINT_CHAR "|"
    PRINT_CHAR [array + 8]
    NEWLINE
    NEWLINE
    ret
    
    
    
chckWinner:
    
    xor esi, esi
chckWinnerLoop1:
    cmp esi, 3
    je chckWinnerLoop1end
    
    xor ecx, ecx
    xor edi, edi
    chckWinnerLoop2:
        cmp edi, 3
        je chckWinnerLoop2end
            mov ebx, esi
            imul ebx, 3
            add ebx, edi
            movzx edx, byte [array + ebx] 
            add ecx, edx
        inc edi
        jmp chckWinnerLoop2
    chckWinnerLoop2end:
    
    cmp ecx, 264
    je player1winner
    cmp ecx, 237
    je player2winner
    
    inc esi
    jmp chckWinnerLoop1
chckWinnerLoop1end:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    xor esi, esi
    chckWinnerLoop3:
    cmp esi, 3
    je chckWinnerLoop3end
    
    xor ecx, ecx
    xor edi, edi
    chckWinnerLoop4:
        cmp edi, 3
        je chckWinnerLoop4end
            mov ebx, edi
            imul ebx, 3
            add ebx, esi
            movzx edx, byte [array + ebx] 
            add ecx, edx
        inc edi
        jmp chckWinnerLoop4
    chckWinnerLoop4end:
    
    cmp ecx, 264
    je player1winner
    cmp ecx, 237
    je player2winner
    
    inc esi
    jmp chckWinnerLoop3
chckWinnerLoop3end:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    
    xor ecx, ecx ;;maybe remade with loop
    movzx edx, byte [array]
    add ecx, edx
    movzx edx, byte [array + 4]
    add ecx, edx
    movzx edx, byte [array + 8]
    add ecx, edx
    cmp ecx, 264
    je player1winner
    cmp ecx, 237
    je player2winner
    
    
    xor ecx, ecx
    movzx edx, byte [array + 2]
    add ecx, edx
    movzx edx, byte [array + 4]
    add ecx, edx
    movzx edx, byte [array + 6]
    add ecx, edx
    cmp ecx, 264
    je player1winner
    cmp ecx, 237
    je player2winner
    
    jmp chckWinnerEnd
    
        
player1winner:
    mov eax, 0
    mov [playerTurn], eax
    PRINT_STRING "PLAYER 1 WINNER"
    GET_CHAR eax
    GET_CHAR eax
    jmp chckWinnerEnd
    
player2winner:
    mov eax, 0
    mov [playerTurn], eax
    PRINT_STRING "PLAYER 2 WINNER"
    GET_CHAR eax
    GET_CHAR eax
    jmp chckWinnerEnd


chckWinnerEnd:
    ret
    