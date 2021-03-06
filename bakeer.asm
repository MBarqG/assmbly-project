;CAESAR CIPHER ENCRYPTION
.STACK
.MODEL SMALL
.DATA

MSG1 DB 0ah,0dh ,'enter a plain text : $';;; 0ah and 0dh is endl;
MSG2 DB 0ah,0dh,'chipher text after 3 shif left : $'
   NEWLINE DB 10,13,"$"
ARR1 DB 50 DUP (' ') ;;;input
ARR2 DB 50 DUP (' '),'$' ;;; output 
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

    
     MOV AX,@DATA
     MOV DS,AX 
     
     LEA SI,ARR1   ;;;;si=arr1
     LEA DI,ARR2     ;;;di=arr2

     
     ;PRINT MSG1
     LEA DX,MSG1
     MOV AH,09
     INT 21H     
     
     MOV CX,50   ;NUMBER OF CHARACTER TO input    
     
     INPUT:
      
     MOV AH,01 ;;;;read a charcter
     INT 21H
     MOV [SI],AL  ;;; content of si=al 
     
     CMP AL,0DH
     JE  INPUTE
     
     INC SI      ;; si++ 
     LOOP INPUT
     INPUTE:
     MOV DX,0000 ;;dx=0000
     MOV CX,50     ;;;cs=1
     LEA SI,ARR1   ;;;si=arr1
     
     OUTPUT:  ;;; output label
     MOV AL,[SI]   ;;; al=content si
     CMP AL,0DH
     JE OUTPUTE
     main AL   ;;;;call subroutine 
     MOV [DI],AL    ;;; content di=al
     INC SI    ;;;si++
     INC DI    ;;; di++
     LOOP OUTPUT
     OUTPUTE:            
     LEA DX,MSG2
     MOV AH,09  
     INT 21H
     LEA DX,ARR2  ;;dx=arr2
     MOV AH,09
     INT 21H 
     MOV AH,4CH
     INT 21H 
     
     end   ;;end a program
