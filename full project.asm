;CAESAR CIPHER ENCRYPTION
.STACK
.MODEL SMALL
.DATA

MSG1 DB 0ah,0dh ,'enter a plain text : $';;; 0ah and 0dh is endl;
MSG2 DB 0ah,0dh,'chipher text after 3 shif left : $'
MSG3 DB 'first number between 0-7: $'
MSG4 DB 'second number between 0-7: $'
ARR1 Dw 50 DUP (' ') ;;;input
ARR2 DB 50 DUP (' '),'$' ;;; output
NUM1 DW 0
NUM2 DW 0
i dw ?
j dw ? 
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
     INC SI      ;; si++ 
     LOOP INPUT
     MOV DX,0000 ;;dx=0000
     MOV CX,50     ;;;cs=1
     LEA SI,ARR1   ;;;si=arr1
     
     OUTPUT:  ;;; output label
     MOV AL,[SI]   ;;; al=content si
     main AL   ;;;;call subroutine 
     MOV [DI],AL    ;;; content di=al
     INC SI    ;;;si++
     INC DI    ;;; di++
     LOOP OUTPUT
      
      
      
      
      
    LEA DX,MSG3 ;third massage
    MOV AH,09
    INT 21H  
     
    MOV AH,01 ;;;;read a charcter
    INT 21H
    sub ax,48
    mov NUM1,ax

    LEA DX,MSG4 ;third massage
    MOV AH,09
    INT 21H

    MOV AH,01 ;;;;read a charcter
    INT 21H
    sub ax,48
    mov NUM2,ax
     
    
lea si,arr2
lea di,arr2
    mov i,0
     next_i:
       mov ax,NUM1
       mov bx,NUM2
       add si,ax
       add di,bx
       mov dl,[si]
       mov dh,[di]
       mov [di],dl
       mov [si],dh

inc i                      
jbe next_i


lea si,arr2
lea di,arr2
    mul NUM1,7
    mul NUM2,7     
    mov ax,NUM1
    mov bx,NUM2
    add si,ax
    add di,bx
    mov j,0
    next_j:
    mov cx,j
    mov dl,[si]
    mov dh,[di]
    mov [di],dl
    mov [si],dh
    inc j
    cmp j,8
    jne next_j
    
    
    
     ;------clear screen ------------
    mov ah,6
    mov al,0 
    mov cl ,0 
    mov ch,0 
    mov dl,4fh 
    mov dh ,18h 
    mov bh ,2 
    int 10h 
  
    
    ;---------center screean output---------
      mov ah,2
      mov bh,0 
      mov dl,27h;mid-point of colums 
      mov dh,0ch;mid-poin of rows
      int 10h
       ;------------------ 
      
     
                
     LEA DX,MSG2
     MOV AH,09  
     INT 21H
     LEA DX,ARR2  ;;dx=arr2
     MOV AH,09
     INT 21H 
     MOV AH,4CH
     INT 21H 
     
     end   ;;end a program
