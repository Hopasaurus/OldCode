;draw_line
; CRC 16 calculation tool
; leave in text mode
; get seed, calculate output
; q=keep getting more input until we get 'quit'
; s=seed command lets us enter new seed

;set video mode
        mov ax,6
        int 10

        mov dx, 0202
        mov cx, offset(title1)
        call printcommand
        mov dx, 0302
        mov cx, offset(title2)
        call printcommand
        mov dx, 0502
        mov cx, offset(title3)
        call printcommand
        mov dx, 0607
        mov cx, offset(title4)
        call printcommand
        mov dx, 0707
        mov cx, offset(title5)
        call printcommand

        mov dx, 0A05
        mov cx, offset(sseed)
        call printcommand

        ;mov dx, 0A1A
        ;call setc
        ;mov ax, seed
        ;call printax

        mov dx, 0C05
        mov cx, offset(scurrent)
        call printcommand



        mov dx, 0E05
        mov cx, offset(scalcval)
        call printcommand


        mov dx, 1802
        mov cx, offset(q2quit)
        call printcommand

        ;mov dx, 1005
        ;call setc
        ;mov ax, dcba
        ;call printax
        call update

        jmp exit


update
      call calc_crc
      mov dx, 0A1A
      call setc
      mov ax, seed
      call printax
      mov dx, 0C1A
      call setc
      mov ax, current
      call printax
      mov dx, 0E1A
      call setc
      mov ax, calcval
      call printax
      ret



setc    push ax
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

printcommand
        push cx
        call setc
        pop dx
        call prints
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

convertbl
        and bl, f
        cmp bl, 9
        ja blalpha
        add bl, '0'
        ret

blalpha
        add bl, 'A'
        sub bl, a
        ret

shrblfour
        shr bl, 1
        shr bl, 1
        shr bl, 1
        shr bl, 1
        ret

printax
        push ax
        push bx
        push cx
        ;byte d
        mov bx, ax
        call convertbl
        mov byte_d, bl
        ;byte c
        mov bx, ax
        call shrblfour
        call convertbl
        mov byte_c, bl
        ;byte b
        mov bl, ah
        call convertbl
        mov byte_b, bl
        ;byte a
        mov bx, 0
        mov bl, ah
        call shrblfour
        call convertbl
        mov byte_a, bl

        ;print it
        mov dx, offset(bytes)
        mov ah, 9
        int 21

        pop dx
        pop bx
        pop ax
        ret


calc_crc   ; current  calcval seed thing
        mov ax, seed
        mov bx, current
        mov cx, 8
        xor al, bl
crc_loop
        shr ax, 1
        jnc crc_nocarry
        xor ax, thing
crc_nocarry
        dec cx
        jnz crc_loop

        mov calcval, ax
        ret




title1 db 'CRC 16 Calculator for MODBUS testing$'
title2 db 'David Hoppe 2005$'
title3 db 'Enter a number to calculate$'
title4 db 'or enter s to change seed$'
title5 db 'enter x to transfer calculated value to seed$'


sseed    db 'Seed:$'
scurrent db 'Current:$'
scalcval db 'Calculated Value:$'


q2quit          db 'Q to quit$'
numhit          db 'Number Hit$'
fni             db 'Function not implimented yet.$'
invalidkey      db 7, 'Invalid key, try again.',7,'$'
bell            db 7, 'Bell!$'
wtime1          db 'Wasting time...$'
wtime2          db 'Wasted Time$'
blank           db '                                              $'
fourblank       db '    $'
printing        db 0
celldata        dw 0
ten             dw %d10
two             dw 2
sixteen         dw %d16

bytes           db '0x'
byte_a          db 'x'
byte_b          db 'x'
byte_c          db 'x'
byte_d          db 'x$'

current         dw 0000
calcval         dw 0000
seed            dw FFFF
thing           dw A001


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
        cmp al, 'q'
        je kbexit
        cmp al, 'z'
        je kbbell
        cmp al, 't'
        je kbtimeloop
        cmp al, 'x'
        je xferseed
        cmp al, 's'
        je enterseed
        call check_change
        ;mov dx, offset(invalidkey)
        ;call printstatus
        jmp exit

kbbell  mov dx, offset(bell)
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
xferseed
        mov ax, calcval
        mov seed, ax
        call update
        jmp exit
enterseed
        mov ax, seed
        call shlaxeight
        add ax, current
        mov seed, ax
        call update
        jmp exit

cls     push ax
        mov ax, 0003
        int 10
        pop ax
        ret

check_change
        cmp al, '0'
        jb check_a_f
        cmp al, '9'
        jbe numberhit
        ;ret

check_a_f
        cmp al, 'a'
        jae check_f
        ret

check_f
        cmp al, 'f'
        jbe numberhit
        ret

numberhit
        ;call change_cell
        mov dx, offset(numhit)
        call printstatus

        cmp al, '9'
        ja itsaletter
        add al,27

itsaletter
        sub al,57
        and ax, ff

        shl current,1
        shl current,1
        shl current,1
        shl current,1
        add current,ax
        and current,ff
        call update

        ret

shlaxeight
        push cx
        mov cx, 8
shlaxloop
        shl ax, 1
        dec cx
        jnz shlaxloop
        pop cx
        ret