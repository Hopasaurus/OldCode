draw_line

;switch to video mode 6
; 640x200 vidseg=B800

        mov ah,0
        mov al,06
        int 10


        mov cx, e
        mov dx, e
        mov si, 1E3
        call hline

        mov cx, e
        mov dx, 51
        mov si, 1E3
        call hline

        mov cx, e
        mov dx, e
        mov si, 43
        call vline

        mov cx, 1F1
        mov dx, e
        mov si, 44
        call vline

        mov dx, 0B02
        call setc
        mov dx, offset(title1)
        call prints

        mov dx, 0C02
        call setc
        mov dx, offset(title2)
        call prints


        mov dx, 0E02
        call setc
        mov dx, offset(command1)
        call prints
        mov dx, 0F02
        call setc
        mov dx, offset(command2)
        call prints
        mov dx, 1002
        call setc
        mov dx, offset(command3)
        call prints
        mov dx, 1102
        call setc
        mov dx, offset(command4)
        call prints
        mov dx, 1202
        call setc
        mov dx, offset(command5)
        call prints

        mov dx, 1402
        call setc
        mov dx, offset(commandexit)
        call prints

        call drawscreen
        jmp exit



drawscreen
        mov dx, offset(drawing)
        call printstatus

        mov si, 40
        mov dx, 10

        mov bx,3
        mov ax, FFFF

 bigloop
        push bx

yloop


        mov cx, 10
        mov bx, 1E
fillloop
;        mov ax, FF0f
        call putword
        dec bx
        jnz fillloop

        inc dx
        dec si
        jnz yloop

        pop bx
        cmp bx, 3
        jne bx2
        mov ax, 3355
        jmp endbx
bx2     mov ax, ccaa

endbx   mov dx, 10
        mov si, 40

;        pop bx
        dec bx
        jnz bigloop

        mov dx, offset(donedrawing)
        call printstatus

        ret



setc    ;set cursor position to row=dh col=dl
        push ax
        push bx
        mov ah, 2
        mov bx, 0
;       mov dx, 0902
        int 10
        pop bx
        pop ax
        ret

prints  push ax
        mov ah, 9
;        mov dx, offset(testing)
        int 21
        pop ax
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



title1 db 'LCD Test Program (sample screen display)$'
title2 db 'David Hoppe 2003$'

command1 db 'R to redraw screen from memory$'
command2 db 'L to put line into memory$'
command3 db 'P to put point in memory$'
command4 db 'B for bell$'
command5 db 'T for timeloop$'

commandexit db 'E to exit$'


;status messages
fni             db 'Function not implimented yet.$'
drawing         db 'Drawing Screen...$'
donedrawing     db 'Finished drawing screen.$'
invalidkey      db 7, 'Invalid key, try again.',7,'$'
bell            db 7 7 7 7 7 7 7, 'Bell!$'
wtime1          db 'Wasting time...$'
wtime2          db 'Wasted Time$'
blank           db '                                              $'


;int 10 function C
;al=dot color
;dx=row
;cx=column

;hline - draw horizontal line
; si=length
; cx=start column
; dx=row
; color is always 1
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

;putword - put bits form word into screen
; cx=start column
; dx=row
; ax=data

putword push ax
        push bx
        push si
        mov si, 10
        mov bx, ax
nextbit mov ax, 0C01
        shl bx, 1
        jc bitset
        mov ax, 0C00

bitset  int 10
        inc cx
        dec si
        jnz nextbit

        pop si
        pop bx
        pop ax
        ret

exit
        mov ah,0
        int 16

        cmp al, 'e'
        je kbexit
        cmp al, 'r'
        je kbredraw
        cmp al, 'l'
        je kbline
        cmp al, 'p'
        je kbpoint
        cmp al, 'b'
        je kbbell
        cmp al, 't'
        je kbtimeloop



        mov dx, offset(invalidkey)
        call printstatus

        jmp exit



;kbexit
kbredraw
        call drawscreen
        jmp exit
kbbell
        mov dx, offset(bell)
        call printstatus
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



kbline
kbpoint

        mov dx, offset(fni)
        call printstatus
        jmp exit


kbexit
        mov ah,0
        mov al,3
        int 10
;should add stuff for dos exit

        ret



;draw_line_loop
;        push ax
;        push bx
;        push cx
;        push dx
;        push si
;        int 10
;        pop si
;        pop dx
;        pop cx
;        pop bx
;        pop ax
;        inc cx
;        inc dx
;        dec si
;        jnz draw_line_loop
;        ret


;makeline

; line algorithm  Bresenham's algorithm
; e=2*deltax-deltay
; for(int i=1;i<=deltax;i++) {
;  plot(x,y)
;   if e > 0 {
;    y=y+1
;    e=e+(2*deltay-2*deltax)
;   } else {
;    e=e+2*deltay
;   }
;  x=x+1
; }



;        ret
