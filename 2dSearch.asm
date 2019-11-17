.model small

.data
    arr1 db 1,2,3
         db 4,5,6
         db 7,8,9
         
    len1 = ($-arr1) 
    
    success db "Found$"
    fail db "Not found$" 
    
    ele db 9 
    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov bl, ele 

    mov cl, len1
    mov si, 0
    
    store:
        mov al, arr1[si] 
        
        cmp al, bl
        je found
      
        inc si
        loop store
        
    notFound: 
        lea dx, fail
        mov ah, 9h
        int 21h
        jmp endProc
        
    found:
        lea dx, success 
        mov ah, 9h
        int 21h
        
    endProc:     
        mov ah, 4ch
        int 21h
    
    main endp
end