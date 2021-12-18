;CAESAR CIPHER ENCRYPTION
.STACK
.MODEL SMALL
.DATA

MSG1 DB 'enter a plain text max 10 per row char  : $';;; 0ah and 0dh is endl;
MSG2 DB 'chipher text: $'

MSG3 DB 'first number between 0-4: $'
MSG4 DB 'second number between 0-4: $'

ARR1 DB 50 DUP (' ') ;;;input
ARR2 DB 50 DUP (' '),'$' ;;; output

NUM1 DB ?
NUM2 DB ?
index db 0
rownumber db 0
counter db 0
counter2 db 0  
.CODE

main MACRO AL   ;;; a macro  like a procedures
    

    CMP AL,'z'  ;;al=='z'
    JA exit  ;;;; jump unsigned >
    CMP AL,'A';; al=='A'
    JB exit   ;;;; jump unsigned <
    CMP AL,'Z'    ;;;  al=='Z'                                     
    JE decrease    ;;  jump signed ==
    CMP AL,'z'    ;;;; cmp al=='z'
    JE decrease  ;;;; singned ==
    CMP AL,'Y'    ;;; al=='Y'
    JE decrease   ;;; 
    CMP AL,'y'     ;; al==='Y'
    JE decrease
    CMP AL,'X'   ;;; al=='X'
    JE decrease
    CMP AL,'x'  ;;;;; al=='x'
    JE decrease
    
    add al,3     ;;; left shift 3 bit
    JMP exit
    
    decrease:
    SUB AL,23   ;;; al=al-23
    JMP exit
    
    exit:
endm
    mov ah,6
    mov al,0 
    mov cl ,0 
    mov ch,0 
    mov dl,4fh
    mov dh ,18h
    mov bh ,15 
    int 10h  
    INT 21H
            
     MOV AX,@DATA
     MOV DS,AX 
     
     LEA SI,ARR1   ;;;;si=arr1
     LEA DI,ARR2     ;;;di=arr2

     
     ;PRINT MSG1
     LEA DX,MSG1
     MOV AH,09
     INT 21h  
     
     INPUT:
     cmp index,10
     je newline 
     MOV AH,01 ;;;;read a charcter
     INT 21H
     MOV SI[index+10*rownumber],AL  ;;; content of si=al 
     
     CMP AL,0DH
     je newline
     jmp notnewline
     
     
     newline:
     inc rownumber
     mov index,0
     
    mov ah,6
    mov al,0 
    mov cl ,0 
    mov ch,0 
    mov dl,4fh
    mov dh ,18h
    mov bh ,15 
    int 10h  
    INT 21H
     
     
     
     mov ah,rownumber
     mov al,4
     cmp ah,al
     je getnumbers 
     jmp input
     
     notnewline:
     
     INC index
     mov ah,rownumber
     mov al,4
     cmp ah,al
     je doneinput 
     je input
     
     LOOP INPUT
     doneinput:
     MOV DX,0000 ;;dx=0000
     MOV CX,100    ;;;cs=1
     LEA SI,ARR1   ;;;si=arr1
     

    getnumbers:
    LEA DX,MSG3 ;third massage
    MOV AH,09
    INT 21H

    MOV AH,01 ;;;;read a charcter
    INT 21H
    sub al,48
    mov NUM1,al
    
    mov ah,6
    mov al,0 
    mov cl ,0 
    mov ch,0 
    mov dl,4fh
    mov dh ,18h
    mov bh ,15 
    int 10h  
    INT 21H

    LEA DX,MSG4 ;third massage
    MOV AH,09
    INT 21H

    MOV AH,01 ;;;;read a charcter
    INT 21H
    sub al,48
    mov NUM2,al
    
    
            mov ah,6
    mov al,0 
    mov cl ,0 
    mov ch,0 
    mov dl,4fh
    mov dh ,18h
    mov bh ,15 
    int 10h  
    INT 21H

    rowswap:
    mov ah,si[10*NUM1+counter]
    mov al,si[10*NUM2+counter]
    mov si[10*num1+counter],al
    mov si[10*num2+counter],ah
    mov al,counter
    mov ah,19
    cmp al,ah
    je colswap
    inc counter
    jmp rowswap
    
    
    colswap:
    mov ah,si[NUM1+10*counter2]
    mov al,si[NUM2+10*counter2]
    mov si[NUM1+10*counter2],al
    mov si[NUM2+10*counter2],ah
    mov al,counter2
    mov ah,4
    cmp al,ah
    je output
    inc counter2
    jmp colswap



     OUTPUT:
     mov index,0  ;;; output label
     MOV AL,SI[index]   ;;; al=content si
     main AL   ;;;;call subroutine 
     MOV [DI],AL    ;;; content di=al
     INC index    ;;;si++ 
     cmp index,49
     je clear
     INC DI    ;;; di++
     LOOP OUTPUT

    clear:    
    ;------clear screen ------------ 
    mov ah,6
    mov al,0 
    mov cl ,0 
    mov ch,0 
    mov dl,4fh
    mov dh ,18h
    mov bh ,15 
    int 10h     
    LEA DX,MSG2
    MOV AH,09  
    INT 21H

    ;---------center screean output---------
      mov ah,2
      mov bh,0 
      mov dl,27h;mid-point of colums 
      mov dh,0ch;mid-poin of rows
      int 10h
    ;------------------


     LEA DX,ARR2  ;;dx=arr2
     MOV AH,09
     INT 21H 
     MOV AH,4CH
     INT 21H 
     
     end   ;;end a program