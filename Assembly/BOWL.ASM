draw_line
; Bowling Scores Helper
; be able to put in individual scores and handy caps and
; make display like what goes on score sheet.
;switch to video mode 6 - 640x200 vidseg=B800
        mov ah,0
        mov al,06
        int 10
        call draw_grid
        call writescores
        jmp exit

draw_grid

;draw top line  (start at e,e go 1e3)
        mov cx, 43
        mov dx, 12
        mov si, C8
        push dx
        call hline
        pop dx
        add dx, hsep      ;20 hexidecimal

        mov cx, 43
        mov si, C8
        push dx
        call hline
        pop dx

        add dx, hsep      ;20 hexidecimal
        mov cx, 43
        mov si, C8
        push dx
        call hline
        pop dx

        add dx, hsep      ;20 hexidecimal
        mov cx, 43
        mov si, C8
        push dx
        call hline
        pop dx

        add dx, hsep      ;20 hexidecimal
        mov cx, 43
        mov si, C8
        push dx
        call hline
        pop dx

        add dx, hsep      ;20 hexidecimal
        mov cx, 43
        mov si, C9
;        push dx
        call hline

;draw left line
        mov cx, 43
        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 1820
        mov cx, offset(title1)
        call printcommand
        mov dx, 1839
        mov cx, offset(title2)
        call printcommand

;        mov dx, 0810
;        mov cx, offset(s1)
;        call printcommand
;        mov dx, 0816
;        mov cx, offset(s1)
;        call printcommand
;        mov dx, 081D
;        mov cx, offset(s1)
;        call printcommand
;        mov dx, 0823
;        mov cx, offset(s1)
;        call printcommand



        mov dx, 0400
        mov cx, offset(b1)
        call printcommand
        mov dx, 0800
        mov cx, offset(b2)
        call printcommand
        mov dx, 0C00
        mov cx, offset(b3)
        call printcommand
        mov dx, 1000
        mov cx, offset(b4)
        call printcommand
        mov dx, 1400
        mov cx, offset(t1)
        call printcommand

        mov dx, 0109
        mov cx, offset(hcp)
        call printcommand
        mov dx, 010D
        mov cx, offset(g1)
        call printcommand
        mov dx, 0114
        mov cx, offset(g2)
        call printcommand
        mov dx, 0119
        mov cx, offset(g3)
        call printcommand
        mov dx, 011D
        mov cx, offset(tot)
        call printcommand

;        mov dx, 1309
;        mov cx, offset(s1)
;        call printcommand
;        mov dx, 1509
;        mov cx, offset(s1)
;        call printcommand

        mov dx, 1802
        mov cx, offset(e2exit)
        call printcommand
;        jmp exit


;draw stuff for team 2
;draw top line  (start at e,e go 1e3)
        mov cx, 183
        mov dx, 12
        mov si, C8
        push dx
        call hline
        pop dx
        add dx, hsep      ;20 hexidecimal

        mov cx, 183
        mov si, C8
        push dx
        call hline
        pop dx

        add dx, hsep      ;20 hexidecimal
        mov cx, 183
        mov si, C8
        push dx
        call hline
        pop dx

        add dx, hsep      ;20 hexidecimal
        mov cx, 183
        mov si, C8
        push dx
        call hline
        pop dx

        add dx, hsep      ;20 hexidecimal
        mov cx, 183
        mov si, C8
        push dx
        call hline
        pop dx

        add dx, hsep      ;20 hexidecimal
        mov cx, 183
        mov si, C9
;        push dx
        call hline

;draw left line
        mov cx, 183
        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

        mov dx, 12
        mov si, 0A0
        push cx
        call vline
        pop cx
        add cx, vsep

;column headers for team 2
        mov dx, 0131
        mov cx, offset(hcp)
        call printcommand
        mov dx, 0135
        mov cx, offset(g1)
        call printcommand
        mov dx, 013C
        mov cx, offset(g2)
        call printcommand
        mov dx, 0141
        mov cx, offset(g3)
        call printcommand
        mov dx, 0145
        mov cx, offset(tot)
        call printcommand

        mov dx, 0428
        mov cx, offset(b1)
        call printcommand
        mov dx, 0828
        mov cx, offset(b2)
        call printcommand
        mov dx, 0C28
        mov cx, offset(b3)
        call printcommand
        mov dx, 1028
        mov cx, offset(b4)
        call printcommand
        mov dx, 1428
        mov cx, offset(t2)
        call printcommand

        ret

move_edit
     ;fix this to the program knows what cell it is editing.
     ;cells should be numbered 1-8 across and 1-4 down
     ;only player games and handicaps can be edited
     ;1=up 2=down 3=left 4=right
        push ax
        call undrawedit
        pop ax
        cmp ax, 1
        jne not_1
;move up - limits 0 < celly
;eypos = 14 + (celly-1) * hsep
        mov ax, celly
        sub ax, 1
        cmp ax, 0
        ja upok
        mov ax, 1
upok
        mov celly, ax
        sub ax, 1
        mul hsep
        add ax, 14
        mov eypos, ax

        ;mov dx, hsep
        ;sub eypos, dx
        jmp me_exit

not_1   cmp ax, 2
        jne not_2
;move down - limit celly < 5
;eypos = 14 + (celly-1) * hsep
        mov ax, celly
        add ax, 1
        cmp ax, 5
        jb dnok
        mov ax, 4
dnok
        mov celly, ax
        sub ax, 1
        mul hsep
        add ax, 14
        mov eypos, ax

        ;mov dx, hsep
        ;add eypos, dx
        jmp me_exit

not_2   cmp ax, 3
        jne not_3
;left cellx > 0
        mov ax, cellx
        sub ax, 1
        cmp ax, 0
        ja leftok
        mov ax, 1
leftok
        mov cellx, ax
        jmp me_x
        ;mov dx, vsep
        ;sub expos, dx
        ;jmp me_exit


not_3   cmp ax, 4
        jne me_exit
;right
        mov ax, cellx
        add ax, 1
        cmp ax, 9
        jb rightok
        mov ax, 8
rightok
        mov cellx, ax

        ;mov dx, vsep
        ;add expos, dx

me_x
;draw cell in x axis
;special attention to switching teams
;cell < 5  expos = 45 + (cellx-1) * vsep
; else     expos = 45 + (cellx+5) * vsep
        mov ax, cellx
        sub ax, 1
        cmp ax, 4
        jb noaddeight
        add ax, 4
noaddeight
        mul vsep
        add ax, 45
        mov expos, ax

me_exit
        call drawedit

        ret




drawedit
;floating box to indicate current edit box
        mov cx, expos ; 45      ;x
        mov dx, eypos ; 14      ;y
        mov si, 25      ;length
        call hline

        mov cx, expos ; 45
        mov dx, eypos ; 30
        add dx, elen  ; 30h-14h
        mov si, eheight; 25
        call hline

        mov cx, expos ; 45
        mov dx, eypos ; 14
        mov si, elen  ; 1c
        call vline

        mov cx, expos ; 69
        add cx, eheight ;
        sub cx, 1
        mov dx, eypos ; 14
        mov si, elen ;  1c
        call vline
        ret


undrawedit
;floating box to indicate current edit box
        mov cx, expos ; 45      ;x
        mov dx, eypos ; 14      ;y
        mov si, 25      ;length
        call unhline

        mov cx, expos ; 45
        mov dx, eypos ; 30
        add dx, elen  ; 30h-14h
        mov si, eheight; 25
        call unhline

        mov cx, expos ; 45
        mov dx, eypos ; 14
        mov si, elen  ; 1c
        call unvline

        mov cx, expos ; 69
        add cx, eheight ;
        sub cx, 1
        mov dx, eypos ; 14
        mov si, elen ;  1c
        call unvline
        ret



writescores
        push ax
        mov ax, 0
        add ax, p1g1
        add ax, p1g2
        add ax, p1g3
        mov p1tot, ax

        mov ax, 0
        add ax, p2g1
        add ax, p2g2
        add ax, p2g3
        mov p2tot, ax

        mov ax, 0
        add ax, p3g1
        add ax, p3g2
        add ax, p3g3
        mov p3tot, ax

        mov ax, 0
        add ax, p4g1
        add ax, p4g2
        add ax, p4g3
        mov p4tot, ax

        mov ax, 0
        add ax, p5g1
        add ax, p5g2
        add ax, p5g3
        mov p5tot, ax

        mov ax, 0
        add ax, p6g1
        add ax, p6g2
        add ax, p6g3
        mov p6tot, ax

        mov ax, 0
        add ax, p7g1
        add ax, p7g2
        add ax, p7g3
        mov p7tot, ax

        mov ax, 0
        add ax, p8g1
        add ax, p8g2
        add ax, p8g3
        mov p8tot, ax

        mov ax, 0
        add ax, p1h
        add ax, p2h
        add ax, p3h
        add ax, p4h
        mov t1h, ax

        mov ax, 0
        add ax, p5h
        add ax, p6h
        add ax, p7h
        add ax, p8h
        mov t2h, ax

        mov ax, 0
        add ax, p1g1
        add ax, p2g1
        add ax, p3g1
        add ax, p4g1
        mov t1g1a, ax
        add ax, t1h
        mov t1g1b, ax

        mov ax, 0
        add ax, p5g1
        add ax, p6g1
        add ax, p7g1
        add ax, p8g1
        mov t2g1a, ax
        add ax, t2h
        mov t2g1b, ax

        mov ax, 0
        add ax, p1g2
        add ax, p2g2
        add ax, p3g2
        add ax, p4g2
        mov t1g2a, ax
        add ax, t1h
        mov t1g2b, ax

        mov ax, 0
        add ax, p5g2
        add ax, p6g2
        add ax, p7g2
        add ax, p8g2
        mov t2g2a, ax
        add ax, t2h
        mov t2g2b, ax

        mov ax, 0
        add ax, p1g3
        add ax, p2g3
        add ax, p3g3
        add ax, p4g3
        mov t1g3a, ax
        add ax, t1h
        mov t1g3b, ax

        mov ax, 0
        add ax, p5g3
        add ax, p6g3
        add ax, p7g3
        add ax, p8g3
        mov t2g3a, ax
        add ax, t2h
        mov t2g3b, ax

        mov ax, 0
        add ax, t1g1a
        add ax, t1g2a
        add ax, t1g3a
        mov t1tota, ax
        add ax, t1h
        add ax, t1h
        add ax, t1h
        mov t1totb, ax

        mov ax, 0
        add ax, t2g1a
        add ax, t2g2a
        add ax, t2g3a
        mov t2tota, ax
        add ax, t2h
        add ax, t2h
        add ax, t2h
        mov t2totb, ax

        pop ax

        call drawedit
        mov dx, 0409
        mov cx, p1h
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p1g1
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p1g2
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p1g3
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p1tot
        call printscore

;player 2
        mov dx, 0809
        mov cx, p2h
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p2g1
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p2g2
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p2g3
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p2tot
        call printscore

;player 3
        mov dx, 0C09
        mov cx, p3h
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p3g1
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p3g2
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p3g3
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p3tot
        call printscore
;player 4
        mov dx, 1009
        mov cx, p4h
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p4g1
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p4g2
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p4g3
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p4tot
        call printscore
;Team 1
        mov dx, 1409
        mov cx, t1h
        call printscore
        add dx, 19
        mov cx, t1h
        add cx, t1h
        add cx, t1h
        call printscore
        sub dx, 19


        add dx, 5
        sub dx, 100
        mov cx, t1g1a
        push dx
        call printscore
        pop dx
        add dx, 200
        mov cx, t1g1b
        call printscore

        add dx, 5
        mov cx, t1g2b
        call printscore
        sub dx, 200
        mov cx, t1g2a
        call printscore

        add dx, 5
        mov cx, t1g3a
        call printscore
        add dx, 200
        mov cx, t1g3b
        call printscore

        add dx, 5
        mov cx, t1totb
        call printscore
        sub dx, 200
        mov cx, t1tota
        call printscore



;player 5 (team2 player 1)
        mov dx, 0431
        mov cx, p5h
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p5g1
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p5g2
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p5g3
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p5tot
        call printscore
;player 6
        mov dx, 0831
        mov cx, p6h
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p6g1
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p6g2
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p6g3
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p6tot
        call printscore
;player 7
        mov dx, 0C31
        mov cx, p7h
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p7g1
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p7g2
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p7g3
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p7tot
        call printscore
;player 8
        mov dx, 1031
        mov cx, p8h
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p8g1
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p8g2
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p8g3
        push dx
        call printscore
        pop dx
        add dx, 5
        mov cx, p8tot
        call printscore

;Team 2
        mov dx, 1431
        mov cx, t2h
        call printscore
        add dx, 19
        mov cx, t2h
        add cx, t2h
        add cx, t2h
        call printscore
        sub dx, 19

        add dx, 5
        sub dx, 100
        mov cx, t2g1a
        push dx
        call printscore
        pop dx
        add dx, 200
        mov cx, t2g1b
        call printscore

        add dx, 5
        mov cx, t2g2b
        call printscore
        sub dx, 200
        mov cx, t2g2a
        call printscore

        add dx, 5
        mov cx, t2g3a
        call printscore
        add dx, 200
        mov cx, t2g3b
        call printscore

        add dx, 5
        mov cx, t2totb
        call printscore
        sub dx, 200
        mov cx, t2tota
        call printscore

        ret

change_cell
        ;change cell contents only takes numbers or 'c'
        ; as input.
        ; number multiplies cell by 10 and adds to cell
        ; 'c' clears cell
        ; no input checking should be needed.
        ; start by getting address of current cell
        ; then perform modifications.
        push di
        push si
        mov ah, 0       ; now interesting number is in ax
        push ax

        lea di, p1h
        ;bx = bx + (celly-1)*16 + (cellx-1)*2
        mov ax, celly
        sub ax, 1
        mul sixteen  ;16d
        add di, ax
        mov ax, cellx
        sub ax, 1
        mul two
        add di, ax
        mov bx, di

        lea si, celldata
        ; cx should now contain offset of the correct cell
        pop ax
        cmp ax, 'c'
        je clear_cell

        sub ax, '0'
        mov cx, ax
        mov ax, [bx]
        cmp ax, %d999
        ja too_big
        mul ten
        add ax, cx
too_big
        mov celldata, ax
        jmp end_change_cell

clear_cell
        ;make cell equal zero
        mov ax, 0
        mov celldata, ax

end_change_cell

        movsw
        pop si
        pop di
        ret



setc    ;set cursor position to row=dh col=dl
        push ax
        push bx
        mov ah, 2
        mov bx, 0
        int 10
        pop bx
        pop ax
        ret

prints  push ax
        mov ah, 9
        int 21
        pop ax
        ret

printcommand    ;cx = string    dx = position
        push cx
        call setc
        pop dx
        call prints
        ret

printscore              ;cx has score, dx has position
        push dx
        push cx
        mov cx, offset(fourblank)
        call printcommand
        pop cx
        pop dx

        push dx
        push cx         ;want to print score 0-9999 at cx
        call setc       ;set cursor position
        pop cx          ;get score back
                        ;divide by 1000 and print first digit
                        ;then subtract and divide by 100....



        mov ax, 0
        mov printing, al



        cmp cx, %d1000
        jl nothousands
        mov al, 1
        mov printing, al
        ;print thousands
        mov ax, cx

        mov bx, %d1000
        mov dx, 0
        div bx
        push ax
        push cx
        add al, '0'
        mov ah, 0E      ;function 14d
        mov bx, 1       ;color
        int 10
        pop cx
        pop ax
        mov bx, %d1000
        mul bx
        sub cx, ax

        ;print hundreds

nothousands
        mov al, printing
        cmp al, 0
        jne printhundreds
        cmp cx, %d100
        jl nohundreds
        mov al, 1
        mov printing, al
printhundreds
        mov ax, cx
        mov bl, %d100
        div bl
        push ax
        push cx
        add al, '0'
        mov ah, 0E      ;function 14d
        mov bx, 1       ;color
        int 10
        pop cx
        pop ax
        mov bl, %d100
        mul bl
        sub cx, ax

nohundreds
        mov al, printing
        cmp al, 0
        jne printtens
        cmp cx, %d10
        jl notens
        ;print tens
printtens
        mov ax, cx
        mov bl, %d10
        div bl
        push ax

        add al, '0'
        mov ah, 0E
        mov bx, 1
        int 10
        pop ax
        mov bl, %d10
        mul bl
        sub cx, ax
notens
        add cx, '0'
        mov ah, 0E
        mov al, cl
        mov bx, 1
        int 10
;print chr,  int 10 ah=14 al=char bl=fgcolor
        pop dx
        ret

blanktop
        push ax
        push dx
        mov dx, 0002
        call setc
        mov dx, offset(blank)
        call prints
        pop dx
        pop ax
        ret

printstatus
        push ax
        push dx
        call blanktop
        mov dx, 0002
        call setc
        pop dx
        call prints
        pop ax
        ret

title1 db 'Bowler Calculator$'
title2 db 'David Hoppe 2004$'

s1 db '123$'
b1 db 'Bowler1$'
b2 db 'Bowler2$'
b3 db 'Bowler3$'
b4 db 'Bowler4$'
t1 db 'Team 1$'
t2 db 'Team 2$'
g1 db 'Game1$'
g2 db '2$'
g3 db '3$'
hcp db 'hcp$'
tot db 'total$'

e2exit db 'E to exit$'
uparrow         db 'Up Arrow$'
dnarrow         db 'Down Arrow$'
rarrow          db 'Right Arrow$'
larrow          db 'Left Arrow$'
fni             db 'Function not implimented yet.$'
drawing         db 'Drawing Screen...$'
donedrawing     db 'Finished drawing screen.$'
invalidkey      db 7, 'Invalid key, try again.',7,'$'
bell            db 7, 'Bell!$'
wtime1          db 'Wasting time...$'
wtime2          db 'Wasted Time$'
blank           db '                                              $'
fourblank       db '    $'
printing        db 0
celldata        dw 0
expos           dw 45
eypos           dw 14
eheight         dw 25
elen            dw 1C
hsep            dw 20
vsep            dw 28
cellx           dw 1
celly           dw 1
ten             dw %d10
two             dw 2
sixteen         dw %d16

; these are in special order to make cell operations easier.
p1h             dw 0
p1g1            dw 0
p1g2            dw 0
p1g3            dw 0

p5h             dw 0
p5g1            dw 0
p5g2            dw 0
p5g3            dw 0

p2h             dw 0
p2g1            dw 0
p2g2            dw 0
p2g3            dw 0

p6h             dw 0
p6g1            dw 0
p6g2            dw 0
p6g3            dw 0

p3h             dw 0
p3g1            dw 0
p3g2            dw 0
p3g3            dw 0

p7h             dw 0
p7g1            dw 0
p7g2            dw 0
p7g3            dw 0

p4h             dw 0
p4g1            dw 0
p4g2            dw 0
p4g3            dw 0

p8h             dw 0
p8g1            dw 0
p8g2            dw 0
p8g3            dw 0

t1h             dw 0
t1hb            dw 0
t1g1a           dw 0
t1g1b           dw 0
t1g2a           dw 0
t1g2b           dw 0
t1g3a           dw 0
t1g3b           dw 0
t1tota          dw 0
t1totb          dw 0

t2h             dw 0
t2hb            dw 0
t2g1a           dw 0
t2g1b           dw 0
t2g2a           dw 0
t2g2b           dw 0
t2g3a           dw 0
t2g3b           dw 0
t2tota          dw 0
t2totb          dw 0

p1tot           dw 0
p2tot           dw 0
p3tot           dw 0
p4tot           dw 0
p5tot           dw 0
p6tot           dw 0
p7tot           dw 0
p8tot           dw 0

;hline - draw horizontal line
; si=length     cx=start column  dx=row  color is always 1
unhline mov ax,0C00
unhloop int 10
        inc cx
        dec si
        jnz unhloop
        ret
unvline mov ax, 0C00
unvloop int 10
        inc dx
        dec si
        jnz unvloop
        ret

hline   mov ax,0C01
hloop   int 10
        inc cx
        dec si
        jnz hloop
        ret
;vline - draw vertical line
vline   mov ax, 0C01
vloop   int 10
        inc dx
        dec si
        jnz vloop
        ret

kbexit
        mov ah,0
        mov al,3
        int 10
;should add stuff for dos exit
        ret
;look for numbers and multiply current cell by
; 10 and add number (unless cell is greater than 999)
; look for c to clear cell

exit    ;call writescores
        mov ah,0
        int 16
        cmp al, 'e'
        je kbexit
        cmp al, 'b'
        je kbbell
        cmp al, 't'
        je kbtimeloop
        cmp ah, 48
        je kbup
        cmp ah, 50
        je kbdn
        cmp ah, 4D
        je kbra
        cmp ah, 4B
        je kbla
        call check_change
        ;mov dx, offset(invalidkey)
        ;call printstatus
        jmp exit

kbbell  mov dx, offset(bell)
        call printstatus
        jmp exit
kbup    mov dx, offset(uparrow)
        call printstatus
        mov ax, 1
        call move_edit
        jmp exit
kbdn    mov dx, offset(dnarrow)
        call printstatus
        mov ax, 2
        call move_edit
        jmp exit
kbra    mov dx, offset(rarrow)
        call printstatus
        mov ax, 4
        call move_edit
        jmp exit
kbla    mov dx, offset(larrow)
        call printstatus
        mov ax, 3
        call move_edit
        jmp exit
kbtimeloop
        mov dx, offset(wtime1)
        call printstatus
        mov ax, ffff
wastetime
        dec ax
        jnz wastetime
        mov dx, offset(wtime2)
        call printstatus
        jmp exit

cls     push ax
        mov ax, 0003
        int 10
        pop ax
        ret

check_change
        cmp al, 'c'
        je change_cella
        cmp al, '0'
        je change_cella
        cmp al, '1'
        je change_cella
        cmp al, '2'
        je change_cella
        cmp al, '3'
        je change_cella
        cmp al, '4'
        je change_cella
        cmp al, '5'
        je change_cella
        cmp al, '6'
        je change_cella
        cmp al, '7'
        je change_cella
        cmp al, '8'
        je change_cella
        cmp al, '9'
        je change_cella
        ret
change_cella
        call change_cell
        call writescores
        ret

