; Code and data segments has 64KB space each.
.model small
; Set size of stack to 256 bytes
.stack 100h
; Data segment
.data
    ; Main Menu byte array
    mainMenu db 10,10,10, "------------------------"
        ; db - define byte
        ; 10 is line feed (newline)
        db 10, "--- Inventory System ---" 
        db 10, "------------------------"
        db 10, " 1. Show all inventory"
        db 10, " 2. Categorize"
        db 10, " 3. Add position"
        db 10, " 4. Modify position"
        db 10, " 5. Delete position"
        db 10, " 6. Buy item"
        db 10, " 7. Exit"
        db 10, "------------------------"
        db 10, "Please Select Your Choice: $"
    
    ; Invalid input message
    invalidInputMessage db 10,10, "------------------ Error -------------------"
        db 10, "Please, enter a valid number"
        db 10, "--------------------------------------------$"


; Code Segment
.code

Exit proc
    ; Terminate Program with 4ch function
    mov ah, 4ch
    int 21h
Exit endp

InvalidInput proc
    ; Print Invalid Input message
    mov ah, 09h
    mov dx, offset invalidInputMessage
    int 21h

    ; Jump back to main
    jmp Main
InvalidInput endp

; Definition of Main procedure
Main proc
    ; Initialize data segment with its address
    mov ax, @data
    ; Copy the addess of data segment from ax register
    mov ds, ax

    ; Display main menu with 
    ; 09h function of DOS interrupt to print string
    mov ah, 09h
    ; Get address of Main Menu
    mov dx, offset mainMenu
    ; DOS interrupt
    int 21h

    ; Receive character Input
    mov ah, 01h
    int 21h

    ; Conditions
    cmp al, '1'
    ; Check if input less than '1'
    jb InvalidInput
    cmp al, '7'
    ; Check if input greater than '7'
    ja InvalidInput


    ; Exit if input is 7
    cmp al, '7'
    je exit

    ; Terminate Program
    call exit

; End of Main procedure
main endp
; End of the prgoram
; Specified entry point with Main procedure
end main
