.MODEL SMALL
 .STACK 100H

 .DATA
    PROMPT  DB  'The contents of the 2D array are : \',0DH,0AH,'$\'

    ARRAY   DW  1,2,3,4,5
            DW  6,7,8,9,10
            DW  11,12,13,14,15
            DW  16,17,18,19,20
            DW  21,22,23,24,25

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     LEA DX, PROMPT               ; load and display the string PROMPT
     MOV AH, 9
     INT 21H

     LEA SI, ARRAY                ; set SI=offset address of ARRAY
     MOV BH, 5                    ; set BH=5
     MOV BL, 5                    ; set BL=5

     CALL PRINT_2D_ARRAY          ; call the procedure PRINT_2D_ARRAY

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
   MAIN ENDP



 ;-------------------------  Procedure Definitions  ------------------------;




 ;-----------------------------  PRINT_2D_ARRAY  ---------------------------;


  PRINT_2D_ARRAY PROC
    ; this procedure will print the given 2D array
    ; input : SI=offset address of the 2D array
    ;       : BH=number of rows
    ;       : BL=number of columns 
    ; output : none

   PUSH AX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK
   PUSH SI                        ; push SI onto the STACK

   MOV CX, BX                     ; set CX=BX

   @OUTER_LOOP:                   ; loop label
     MOV CL, BL                   ; set CL=BL

     @INNER_LOOP:                 ; loop label
       MOV AH, 2                  ; set output function
       MOV DL, 20H                ; set DL=20H
       INT 21H                    ; print a character

       MOV AX, [SI]               ; set AX=[SI]

       CALL OUTDEC                ; call the procedure OUTDEC

       ADD SI, 2                  ; set SI=SI+2
       DEC CL                     ; set CL=CL-1
     JNZ @INNER_LOOP              ; jump to label @INNER_LOOP if CL!=0

     MOV AH, 2                    ; set output function
     MOV DL, 0DH                  ; set DL=0DH
     INT 21H                      ; print a character

     MOV DL, 0AH                  ; set DL=0AH
     INT 21H                      ; print a character

     DEC CH                       ; set CH=CH-1
   JNZ @OUTER_LOOP                ; jump to label @OUTER_LOOP if CX!=0

   POP SI                         ; pop a value from STACK into SI
   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP AX                         ; pop a value from STACK into AX

   RET
 PRINT_2D_ARRAY ENDP


 ;--------------------------------  OUTDEC  --------------------------------;


 OUTDEC PROC
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none

   PUSH BX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     ; set BX=10

   @OUTPUT:                       ; loop label
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                      ; push DX onto the STACK
     INC CX                       ; increment CX
     OR AX, AX                    ; take OR of Ax with AX
   JNE @OUTPUT                    ; jump to label @OUTPUT if ZF=0

   MOV AH, 2                      ; set output function

   @DISPLAY:                      ; loop label
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP @DISPLAY                  ; jump to label @DISPLAY if CX!=0

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX

   RET                            ; return control to the calling procedure
 OUTDEC ENDP





 END MAIN
