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
    mov eax, [playerTurn] ; checks for game state
    cmp eax, 1
    jge player
    jl end
    
    
player:
    je player1text
    jg player2text
    
player1text:
    PRINT_STRING "NOW PLAYING: player 1"; input
    jmp playerInput

player2text:
    PRINT_STRING "NOW PLAYING: player 2"; input
    jmp playerInput
    
    
playerInput:
    NEWLINE
    PRINT_STRING "ENTER YOUR field: "
    GET_DEC 4, esi 
    sub esi, 1 ; decrement by 1 to convert for indexes in array
    
    cmp esi, 0 ; check smaller than 0
    jl playerError
    
    cmp esi, 8 ; check bigger than 8
    jg playerError
    
    mov edx, 'X' ; check for used 'X'
    cmp [array + esi], dl
    je playerError
    
    mov edx, 'O' ; check for used '0'
    cmp [array + esi], dl
    je playerError
    
    cmp eax, 1
    je player1turn
    jg player2turn
    
player1turn:
    mov edx, 'X'
    mov eax, 2
    jmp playerEnd
    
player2turn:
    mov edx, 'O'
    mov eax, 1
    jmp playerEnd 
    
playerEnd:
    mov [array + esi], dl
    mov [playerTurn], eax
    jmp loop ; jump back to loop    

    
playerError:
    PRINT_STRING "WRONG VALUE" ; another try on input
    NEWLINE
    
    jmp player
        
end:
    xor eax, eax
    ret
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
printArray: ; printing array
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
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
chckWinner:

    ;checks for winning combinations by row & columns
    xor esi, esi ; resets loop counter
chckWinnerLoop1:
    cmp esi, 3 ; check for ending of loop
    je chckWinnerLoop1end
    
    xor eax, eax ; resets register for SUM
    xor ecx, ecx ; resets register for SUM
    xor edi, edi ; resets loop counter
    chckWinnerLoop2:
        cmp edi, 3 ; check for ending of loop
        je chckWinnerLoop2end
        
            mov ebx, esi ; copy counter
            imul ebx, 3 ; multiply column
            add ebx, edi ; adds row
            movzx edx, byte [array + ebx] ; reads data from array on row; column
            add ecx, edx ; adds data to sum
            ;;;;;;;;;;;;;;;;;;;;;;;;;;
            mov ebx, edi ; copy counter
            imul ebx, 3 ; multiply row
            add ebx, esi ; adds column 
            movzx edx, byte [array + ebx] ; reads data from array on row; column
            add eax, edx ; adds data to sum
            
        inc edi ; increment loop counter
        jmp chckWinnerLoop2 ; starts loop again
    chckWinnerLoop2end:
    
    cmp ecx, 264 ; check for winner by rows
    je player1winner
    cmp ecx, 237
    je player2winner
    
    cmp eax, 264 ; check for winner by columns
    je player1winner
    cmp eax, 237
    je player2winner
    
    inc esi ; increment loop counter
    jmp chckWinnerLoop1 ; starts loop again
chckWinnerLoop1end:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;maybe remade with loop
    
    ;checks for winning combinations digonaly
    xor ecx, ecx ; resets register for SUM
    add cl, byte [array] ; adds data to SUM from array
    add cl, byte [array + 4] ; adds data to SUM from array
    add cl, byte [array + 8] ; adds data to SUM from array
    cmp ecx, 8  ; check for winner ; 8 because of 8-bit int limit
    je player1winner
    cmp ecx, 237
    je player2winner
    
    ;checks for winning combinations digonaly
    ;comments same as upper, only change in indexs
    xor ecx, ecx
    add cl, byte [array + 2] ; different index
    add cl, byte [array + 4] ; different index
    add cl, byte [array + 6] ; different index
    cmp cl, 8 ; 8 because of 8-bit int limit
    je player1winner
    cmp cl, 237
    je player2winner
    
    jmp chckWinnerEnd ; jumps to end of chckWinner
    
        
player1winner:
    mov eax, 0
    mov [playerTurn], eax ; sets playerTurn to 0 -> ends game
    PRINT_STRING "PLAYER 1 WINNER" ; win message
    GET_CHAR eax ; cleans buffer
    GET_CHAR eax ; waits for ENTER
    jmp chckWinnerEnd ; jumps to end of chckWinner
    
player2winner:
    mov eax, 0
    mov [playerTurn], eax ; sets playerTurn to 0 -> ends game
    PRINT_STRING "PLAYER 2 WINNER" ; win message
    GET_CHAR eax ; cleans buffer
    GET_CHAR eax ; waits for ENTER
    jmp chckWinnerEnd ; jumps to end of chckWinner


chckWinnerEnd:
    ret
    