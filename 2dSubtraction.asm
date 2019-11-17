.model small

.data
    arr1 db 1,2,3
         db 4,5,6
         db 7,8,9
         
    len1 = ($-arr1)
    
    arr2 db 1,2,3
         db 4,5,6
         db 7,8,9
         
    len2 = ($-arr2)  
    
    diff db ? 
    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov al, len1
    mov bl, len2 
    
    cmp al, bl
    jne endProc
    
    mov cl, al
    mov si, 0
    
    store:
        mov al, arr1[si]
        mov bl, arr2[si] 
        
        sub al, bl
        
        mov diff[si], al
        inc si
        loop store
        
    endProc:     
        mov ah, 4ch
        int 21h
    
    main endp
end