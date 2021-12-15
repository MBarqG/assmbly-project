
;org 100h 

data segment  
msg db arr 
arr db 100 dup('$')
  ends
stack segment 
    dw 128 dup(0)
    ends

.code
main proc far
    mov ax ,@data 
    mov ds ,ax
    ;------------------
    mov ah,10 
    lea dx ,arr
    mov arr,80
    int 21h 
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

   
               
    ;LEA dx ,msg
     ; mov ah ,09h 
      ;int 21h   
                
                    
    LEA dx ,arr+2
    mov ah ,09h 
    int 21h           
                
                
      end main 
    
    
    ret