include 'emu8086.inc'
output macro A1,A2,A3,A4
   local formAz,lp,num,ca,cb,cc,cd,ce,cf,nxtn,num1,ca1,cb1,cc1,cd1,ce1,cf1,nxtn1,nl
mov si,0
mov di,0      
formAz:mov cl,A1[si]
        
        mov al, cl
        shr al,4
        mov Azz[di],al 
        inc di
        mov al, cl
        shl al,4
        rol al,4
        mov Azz[di],al
        inc di 
        
        
        mov cl,A2[si]
        
        mov al, cl
        shr al,4
        mov Azz[di],al
        inc di
        mov al, cl
        shl al,4
        rol al,4
        mov Azz[di],al
        inc di
        
        mov cl,A3[si]
        
        mov al, cl
        shr al,4
        mov Azz[di],al
        inc di
        mov al, cl
        shl al,4
        rol al,4
        mov Azz[di],al
        inc di
        
        mov cl,A4[si]
        
        mov al, cl
        shr al,4
        mov Azz[di],al
        inc di
        mov al, cl
        shl al,4
        rol al,4
        mov Azz[di],al
        inc di 
        
        inc si
        cmp si,4
        jnz formAz
             
mov si,0                    
mov ah,2 
lp:
mov al,Azz[si]
cmp al,9
jle num
cmp al,0ah
jz ca
cmp al,0bh
jz cb
cmp al,0ch
jz cc
cmp al,0dh
jz cd
cmp al,0eh
jz ce
cmp al,0fh
jz cf
num:or al,30h
    mov dl, al 
    Int 21h
    jmp nxtn
ca:mov dl,61h
   Int 21h
   jmp nxtn
cb:mov dl,62h
Int 21h
jmp nxtn
cc:mov dl,63h
Int 21h
jmp nxtn
cd:mov dl,64h
Int 21h
jmp nxtn
ce:mov dl,65h
Int 21h
jmp nxtn
cf:mov dl,66h
Int 21h
jmp nxtn
nxtn:inc si
mov al,Azz[si]
cmp al,9
jle num1
cmp al,0ah
jz ca1
cmp al,0bh
jz cb1
cmp al,0ch
jz cc1
cmp al,0dh
jz cd1
cmp al,0eh
jz ce1
cmp al,0fh
jz cf1
num1:or al,30h
    mov dl, al 
    Int 21h
    jmp nxtn1
ca1:mov dl,61h
   Int 21h
   jmp nxtn1
cb1:mov dl,62h
Int 21h
jmp nxtn1
cc1:mov dl,63h
Int 21h
jmp nxtn1
cd1:mov dl,64h
Int 21h
jmp nxtn1
ce1:mov dl,65h
Int 21h
jmp nxtn1
cf1:mov dl,66h
Int 21h
nxtn1:mov dl,20h
int 21h
inc si
cmp si,8
jz nl
cmp si,16
jz nl
cmp si,24
jz nl
cmp si,32
jnz lp
nl:LEA DX,n_line ;lea means least effective address
        MOV AH,9
        INT 21H       ;print new line
        mov ah,2
        cmp si,32
         jnz lp

endm 
subBytes MACRO A1,A2,A3,A4         
        mov ax,0H
        mov bx,0H
        local L1,L2,L3,L4
    mov di,0
    mov al,0
    mov bl,0
    mov cl,0
    L1: mov al,A1[di]
        mov si, ax
        mov bl, S[si]
        mov A1[di],bl
        inc di
        cmp di, 04
        jnz L1
    mov di,0     
    L2: mov al,A2[di]
        mov si, ax
        mov bl, S[si]
        mov A2[di],bl
        inc di
        cmp di, 04
        jnz L2
    mov di,0     
    L3: mov al,A3[di]
        mov si, ax 
        mov bl, S[si]
        mov A3[di],bl
        inc di
        cmp di, 04
        jnz L3
    mov di,0     
    L4:mov al,A4[di]
        mov si, ax 
        mov bl, S[si]
        mov A4[di],bl
        inc di
        cmp di, 04
        jnz L4
        
        
ENDM 


shiftRows MACRO A1,A2,A3,A4
    mov al,A1[1]
    mov cl,A2[1]
    mov A1[1],cl
    mov cl, A3[1]
    mov A2[1],cl
    mov cl, A4[1]
    mov A3[1],cl
    mov A4[1],al
    mov al,A1[2]
    mov bl,A2[2]
    mov cl,A3[2]
    mov A1[2],cl
    mov cl,A4[2]
    mov A2[2],cl
    mov A3[2],al
    mov A4[2],bl
    mov al,A1[3]
    mov bl,A2[3]
    mov dl,A3[3]
    mov cl,A4[3]
    mov A1[3],cl
    mov A2[3],al
    mov A3[3],bl
    mov A4[3],dl
ENDM 
mixcolumns macro A1,A2,A3,A4
    local bigloop,caser1,caser2,caser3,caser4,main,Aloop,caseA1,caseA2,caseA3,caseA4,A1loop,A2loop,A3loop,A4loop,case1,case2,case3,n,n3,nxtcase3,outp,nxt,case1A2,case2A2,case3A2,nA2,n3A2,nxtcase3A2,outpA2,case1A3,case2A3,case3A3,nA3,n3A3,nxtcase3A3,outpA3A4,case1A4,case2A4,case3A4,nA4,n3A4,nxtcase3A4,outpA4,form1,form2,form3,form4,p1,p2,p3,p4,reform 
      mov dh,0                ;which row in r matrix
 bigloop:cmp dh,0
      jz caser1
      cmp dh,1
      jz caser2
      cmp dh,2
      jz caser3
      cmp dh,3
      jz caser4     

caser1:MOV AL , R1[0]    
       MOV r[0], AL
       MOV AL , R1[1]    
       MOV r[1], AL
       MOV AL , R1[2]    
       MOV r[2], AL
       MOV AL , R1[3]    
       MOV r[3], AL
       jmp main 
       
caser2:MOV AL , R2[0]    
       MOV r[0], AL
       MOV AL , R2[1]    
       MOV r[1], AL
       MOV AL , R2[2]    
       MOV r[2], AL
       MOV AL , R2[3]    
       MOV r[3], AL
       jmp main
     
caser3:MOV AL , R3[0]    
       MOV r[0], AL
       MOV AL , R3[1]    
       MOV r[1], AL
       MOV AL , R3[2]    
       MOV r[2], AL
       MOV AL , R3[3]    
       MOV r[3], AL
       jmp main
          
caser4:MOV AL , R4[0]    
       MOV r[0], AL
       MOV AL , R4[1]    
       MOV r[1], AL
       MOV AL , R4[2]    
       MOV r[2], AL
       MOV AL , R4[3]    
       MOV r[3], AL 
       jmp main
       
main:mov dl,0                 ;which column
   Aloop:cmp dl,0
         jz caseA1
         cmp dl,1
         jz caseA2
         cmp dl,2
         jz caseA3
         cmp dl,3
         jz caseA4
   caseA1:mov si,0
            A1loop:mov bl,r[si]  
            cmp bl,01H
            jz case1
             cmp bl,02H
            jz case2
            cmp bl,03H
            jz case3
            case1:mov cl,A1[si]
                  jmp outp
            case2:mov cl,A1[si]
                  CMP CL,0
                  js n
                  shl cl,1
                  jmp outp          
             n:   shl cl,1
                  xor cl,1bh
                  jmp outp
            case3:mov ch,A1[si]
               mov cl,A1[si]
               CMP CL,0
               js n3
              shl cl,1
               jmp nxtcase3          
              n3:shl cl,1
               xor cl,1bh
               jmp nxtcase3
            nxtcase3:xor cl,ch
                   jmp outp
             outp:mov f[si],cl
                  inc si
                  cmp si ,4
                  jnz A1loop
            mov cl,f[0]      
            xor cl,f[1]
            xor cl,f[2]
            xor cl,f[3]
            mov f5[0],cl
            jmp nxt      
                  
          
            
   caseA2:mov si,0
   A2loop:mov bl,r[si]  
            cmp bl,01H
            jz case1A2
             cmp bl,02H
            jz case2A2
            cmp bl,03H
            jz case3A2
            case1A2:mov cl,A2[si]
                  jmp outpA2
            case2A2:mov cl,A2[si]
                  CMP CL,0
                  js nA2
                  shl cl,1
                  jmp outpA2          
             nA2: shl cl,1
                  xor cl,1bh
                  jmp outpA2
            case3A2:mov ch,A2[si]
               mov cl,A2[si]
               CMP CL,0
               js n3A2
              shl cl,1
               jmp nxtcase3A2          
              n3A2:shl cl,1
               xor cl,1bh
               jmp nxtcase3A2
            nxtcase3A2:xor cl,ch
                   jmp outpA2
             outpA2:mov f[si],cl
                  inc si
                  cmp si ,4
                  jnz A2loop
            mov cl,f[0]      
            xor cl,f[1]
            xor cl,f[2]
            xor cl,f[3]
            mov f5[1],cl
            jmp nxt
   caseA3:mov si,0
   A3loop:mov bl,r[si]  
            cmp bl,01H
            jz case1A3
             cmp bl,02H
            jz case2A3
            cmp bl,03H
            jz case3A3
            case1A3:mov cl,A3[si]
                  jmp outpA3
            case2A3:mov cl,A3[si]
                  CMP CL,0
                  js nA3
                  shl cl,1
                  jmp outpA3          
             nA3: shl cl,1
                  xor cl,1bh
                  jmp outpA3
            case3A3:mov ch,A3[si]
               mov cl,A3[si]
               CMP CL,0
               js n3A3
              shl cl,1
               jmp nxtcase3A3          
              n3A3:shl cl,1
               xor cl,1bh
               jmp nxtcase3A3
            nxtcase3A3:xor cl,ch
                   jmp outpA3
             outpA3:mov f[si],cl
                  inc si
                  cmp si ,4
                  jnz A3loop
            mov cl,f[0]      
            xor cl,f[1]
            xor cl,f[2]
            xor cl,f[3]
            mov f5[2],cl
            jmp nxt
            
   caseA4:mov si,0
    A4loop:mov bl,r[si]  
            cmp bl,01H
            jz case1A4
             cmp bl,02H
            jz case2A4
            cmp bl,03H
            jz case3A4
            case1A4:mov cl,A4[si]
                  jmp outpA4
            case2A4:mov cl,A4[si]
                  CMP CL,0
                  js nA4
                  shl cl,1
                  jmp outpA4          
             nA4: shl cl,1
                  xor cl,1bh
                  jmp outpA4
            case3A4:mov ch,A4[si]
               mov cl,A4[si]
               CMP CL,0
               js n3A4
              shl cl,1
               jmp nxtcase3A4          
              n3A4:shl cl,1
               xor cl,1bh
               jmp nxtcase3A4
            nxtcase3A4:xor cl,ch
                   jmp outpA4
             outpA4:mov f[si],cl
                  inc si
                  cmp si ,4
                  jnz A4loop
            mov cl,f[0]      
            xor cl,f[1]
            xor cl,f[2]
            xor cl,f[3]
            mov f5[3],cl
            jmp nxt
   
   nxt:inc dl
       cmp dl,4     
       jnz Aloop
       cmp dh,0
       jz form1
       cmp dh,1
       jz form2
       cmp dh,2
       jz form3
       cmp dh,3
       jz form4
  form1:mov cx,0004h            ;coping all the first elements of each column of A from f5 to another temp A1
        mov di,0
     p1:MOV AL , f5[di]    
        MOV f1[di], AL 
        inc di
        loop p1    
        inc dh              ;indicats the number of multiplications of rows by the 4 columns 
        cmp dh,4             ;if reaches 4 this means the last row r4 is multiplyed by all columns
        jnz bigloop           ;then all the 1st ,2nd ,3rd,4th elements of each column are present in f1,f2,f3,f4  respectivly
        jmp reform 
  form2:mov cx,0004h
        mov di,0
     p2:MOV AL , f5[di]    
        MOV f2[di], AL 
        inc di
        loop p2    
        inc dh
        cmp dh,4
        jnz bigloop
        jmp reform 
  form3:mov cx,0004h
        mov di,0
     p3:MOV AL , f5[di]    
        MOV f3[di], AL 
        inc di
        loop p3    
        inc dh
        cmp dh,4
        jnz bigloop
        jmp reform 
  form4:mov cx,0004h
        mov di,0
     p4:MOV AL , f5[di]    
        MOV f4[di], AL 
        inc di
        loop p4    
        inc dh
        cmp dh,4
        jnz bigloop
        jmp reform         
            
 reform:MOV AL , f1[0]    
       MOV A1[0], AL
       MOV AL , f1[1]    
       MOV A2[0], AL
       MOV AL , f1[2]    
       MOV A3[0], AL
       MOV AL , f1[3]    
       MOV A4[0], AL 
       
       MOV AL , f2[0]    
       MOV A1[1], AL
       MOV AL , f2[1]    
       MOV A2[1], AL
       MOV AL , f2[2]    
       MOV A3[1], AL
       MOV AL , f2[3]    
       MOV A4[1], AL 
       
       MOV AL , f3[0]    
       MOV A1[2], AL
       MOV AL , f3[1]    
       MOV A2[2], AL
       MOV AL , f3[2]    
       MOV A3[2], AL
       MOV AL , f3[3]    
       MOV A4[2], AL 
       
       MOV AL , f4[0]    
       MOV A1[3], AL
       MOV AL , f4[1]    
       MOV A2[3], AL
       MOV AL , f4[2]    
       MOV A3[3], AL
       MOV AL , f4[3]    
       MOV A4[3], AL
                    
ENDM

addRoundKey MACRO A1,A2,A3,A4
    local Lx,Ly,Lz,Lm
    mov si,0
    Lx: mov al,k1[si]
    mov bl, A1[si]
    xor bl,al
    mov A1[si],bl
    inc si
    cmp si,04
    jnz Lx
    mov si,0
    Ly: mov al,k2[si]
    mov bl, A2[si]
    xor bl,al
    mov A2[si],bl
    inc si
    cmp si,04
    jnz Ly
    mov si,0
    Lz:mov al,k3[si]
    mov bl, A3[si]
    xor bl,al
    mov A3[si],bl
    inc si
    cmp si,04
    jnz Lz
    mov si,0
    Lm:mov al,k4[si]
    mov bl, A4[si]
    xor bl,al
    mov A4[si],bl
    inc si
    cmp si,04
    jnz Lm
    
ENDM                                                                                                
.code
    call start
    output A1,A2,A3,A4
    PRINTN
    addRoundKey A1,A2,A3,A4
    ;call disp
    ;PRINTN
    mov si,0
    loadrcon: mov al,rcon1[si]
              mov r[si],al
              inc si
              cmp si,04
              jnz loadrcon
    call keySchedual                    
    mov dl,1
    project: push dx
             subBytes A1,A2,A3,A4
             ;call disp
             ;PRINTN
             shiftRows A1,A2,A3,A4
             ;call disp
             ;PRINTN
             mixcolumns A1,A2,A3,A4 
             ;call disp
             ;PRINTN
             addRoundKey A1,A2,A3,A4
             ;call disp
             ;PRINTN
             pop dx
             mov si,0
             cmp dl,1
             jz use2
             cmp dl,2
             jz use3
             cmp dl,3
             jz use4
             cmp dl,4
             jz use5
             cmp dl,5
             jz use6
             cmp dl,6
             jz use7
             cmp dl,7
             jz use8
             cmp dl,8
             jz use9
             cmp dl,9
             jz use10
    use2:
         mov al,rcon2[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use2
         jmp Lin
    use3:
         mov al,rcon3[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use3
         jmp Lin    
    use4:
         mov al,rcon4[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use4
         jmp Lin                  
    use5:
         mov al,rcon5[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use5
         jmp Lin         
    use6:
         mov al,rcon6[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use6
         jmp Lin         
    use7:
         mov al,rcon7[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use7
         jmp Lin
    use8:
         mov al,rcon8[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use8
         jmp Lin
    use9:
         mov al,rcon9[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use9
         jmp Lin
    use10:
         mov al,rcon10[si]
         mov r[si],al
         inc si
         cmp si,04
         jnz use10
         jmp Lin
    Lin: push dx
         call keySchedual
         pop dx
         inc dl
         cmp dl,0AH
         jnz project
    subBytes A1,A2,A3,A4
    shiftRows A1,A2,A3,A4
    addRoundKey A1,A2,A3,A4                                            
    output A1,A2,A3,A4
    
             
    RET ; return to operating system.
keySchedual PROC 
    mov si,0
    load: mov al,k4[si]
          mov f4[si],al
          inc si
          cmp si,04
          jnz load
    mov al,f4[0]
    mov cl,f4[1]
    mov f4[0],cl
    mov cl,f4[2]
    mov f4[1],cl
    mov cl,f4[3]
    mov f4[2],cl
    mov f4[3],al
    subBytes f1,f2,f3,f4
    mov si,0
    replace1: mov al,f4[si]
              mov bl,r[si]
              xor bl,al
              xor k1[si],bl
              inc si
              cmp si,04
              jnz replace1
    mov si,0          
    replace2:mov al,k1[si]
             xor k2[si],al
             inc si
             cmp si,04
             jnz replace2
    mov si,0
    replace3:mov al,k2[si]
             xor k3[si],al
             inc si
             cmp si,04
             jnz replace3
    mov si,0
    replace4:mov al,k3[si]
             xor k4[si],al
             inc si
             cmp si,04
             jnz replace4
             
RET
keySchedual ENDP

start PROC
      MOV AH,1
        mov cl,32
        MOV SI,0
       
        PRINTN "Enter values(without press enter or space): "
        INPUT:
           INT 21H 
           cmp AL,3AH
           jc ch1
           cmp Al,61H
           jz a
           cmp Al,62H
           jz b
           cmp Al,63H
           jz c
           cmp Al,64H
           jz d
           cmp Al,65H
           jz e
           cmp Al,66H
           jz ff
        ch1:    
           and Al,0FH
           jmp fin1
        a:
           mov al,0aH 
           jmp fin1
        b:
           mov al,0bH
           jmp fin1       
        c:
           mov al,0cH
           jmp fin1 
        d:
           mov al,0dH
           jmp fin1 
        e:
           mov al,0eH
           jmp fin1 
        ff:
           mov al,0fH
           jmp fin1
        fin1:
        mov ARR[si],al
        inc si
        LOOP INPUT
 mov si,0
      mov di,0
      put:
        mov al,ARR[si]
        shl al,4
        inc si
        add al,ARR[si]
        mov Az[di],al
        inc si
        inc di
        cmp di,16
        jnz put  
      mov si,0
      mov di,0
      mov cl,0
      loadz:
        mov al,Az[di]
        cmp cl,0h
        jz toA1
        cmp cl,01h
        jz toA2
        cmp cl,02h
        jz toA3
        cmp cl,03h
        jz toA4
      toA1:
        mov A1[si],al
        inc di
        inc cl
        jmp loadz
      toA2:
        mov A2[si],al
        inc di
        inc cl
        jmp loadz
      toA3:
        mov A3[si],al
        inc di
        inc cl
        jmp loadz
      toA4:
      mov A4[si],al
      inc si
      mov cl,0
      inc di
      cmp di,16
      jnz loadz
      jmp bara
     bara:
        PRINTN      
  ret               
  start ENDP

;A1 db 0d4H,0bfH,5dH,30H
;A2 db 0e0H,0b4H,52H,0aeH
;A3 db 0b8H,41H,11H,0f1H
;A4 db 1eH,27H,98H,0e5H 

;A1 db 32H,43H,0f6H,0a8H
;A2 db 88H,5AH,30H,8DH
;A3 db 31H,31H,98H,0A2H
;A4 db 0E0H,37H,07H,34H
ARR DB 32 DUP(?)
Az DB 16 DUP(?)
;Az DB 32h,88h,31h,0e0h,43h,5ah,31h,37h,0f6h,30h,98h,07h,0a8h,8dh,0a2h,34h
A1 db 4 DUP(?)
A2 db 4 DUP(?)
A3 db 4 DUP(?)
A4 db 4 DUP(?)

k1 db 2bH,7EH,15H,16H
k2 db 28H,0AEH,0D2H,0A6H
k3 db 0ABH,0F7H,15H,88H
k4 db 09H,0CFH,4FH,3CH


R1 db 02H,03H,01H,01H
R2 db 01H,02H,03H,01H
R3 db 01H,01H,02H,03H
R4 db 03H,01H,01H,02H 

r db 0H,0H,0H,0H
f db 0H,0H,0H,0H 


f1 db 0,0,0,0
f2 db 0,0,0,0
f3 db 0,0,0,0
f4 db 0,0,0,0
f5 db 0,0,0,0

rcon1 db 1H,0H,0H,0H
rcon2 db 2H,0H,0H,0H
rcon3 db 4H,0H,0H,0H
rcon4 db 8H,0H,0H,0H
rcon5 db 10H,0H,0H,0H
rcon6 db 20H,0H,0H,0H
rcon7 db 40H,0H,0H,0H
rcon8 db 80H,0H,0H,0H
rcon9 db 1BH,0H,0H,0H
rcon10 db 36H,0H,0H,0H


S db 0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76
 db 0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0
 db 0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15     
 db 0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75
 db 0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84
 db 0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF
 db 0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8
 db 0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2
 db 0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73
 db 0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB
 db 0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79
 db 0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08
 db 0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A
 db 0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E
 db 0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF
 db 0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16

Azz db 32 DUP(?) 
n_line DB 0AH,0DH,"$"
 ; required for print_num. '
END ; directive to stop the compiler