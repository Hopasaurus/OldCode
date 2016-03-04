draw_line
        mov ah,0
        mov al,06
        int 10

        mov AL,1
        mov DX,10
        mov CX,10
        mov BX,0
        mov SI,50
        mov ah,0c

        push si
        push cx
        push dx
        call draw_line_loop


        mov di, 4f
;        mov di, 1

lloop
        pop dx
        pop cx
        pop si
        add dx, 1
        sub si, 1
        push si
        push cx
        push dx
        call draw_line_loop

        dec di
        jnz lloop


        mov di, 13

        pop dx
        pop dx
        pop dx

        mov si,50
        mov cx,10
        mov dx,10
        push si
        push cx
        push dx


lloop2
        pop dx
        pop cx
        pop si
        add cx, 4
        sub si, 4
        push si
        push cx
        push dx
        call draw_line_loop

        dec di
        jnz lloop2




        pop dx
        pop cx
        pop si






        mov ah,0
        int 16
        mov ah,0
        mov al,3
        int 10
        ret



draw_line_loop
        push ax
        push bx
        push cx
        push dx
        push si
        int 10
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        inc cx
        inc dx
        dec si
        jnz draw_line_loop
        ret

makeline


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



        ret
