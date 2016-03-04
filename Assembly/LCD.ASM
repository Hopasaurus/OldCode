; lcd driver for 64x480 lcd
; 1) get memory block 30720 bytes for display memory
;       (64*480=30720 32k=32768)
; 2) write some basic routines to clear memory and make points and lines
; 3) write rudimentry thing to display graphics on pc screen
; 4) create timing control structure
; 5) make parallel port interface hardware
; 6) make test program for interface
; 7) write program to control lcd from memory map
; 8) test with test setup then with lcd
; 9) make more complicated graphics routines: line from two points,
;       bitmap fonts(bitmap copy), circles and rectangles
;
; functions: getmem, freemem, clearmem, memtoscreen, drawline, drawpoint
;       memtoport, driveport, drawmenu.

        mov ax, 0003
        int 10
; to move from specific address mov ax, [2]
; alocate and free some memory
        ;intro message
        mov ah,9
        mov dx,offset(pname)
        int 21

;make this into a subroutine
        call printax
; first let the program shrink itself because dos uses all available
; memory for com files
        mov ah,04a
        mov bx,2000
        int 021
        jc freeerror

        mov ah, 9
        mov dx, offset(freemem)
        int 21
        jmp endfree
freeerror
        mov ah,9
        mov dx,offset(freeerr)
        int 21
endfree
;now lets take some memory back
        mov al, 0
        mov memflag,al
        mov ah, 48
        mov bx,1000
        int 021
        jc memgeterror

        mov es, ax
        call printax
        mov ah,9
        mov dx, offset(getmem)
        int 21

        mov ax, bx
        call printax
        mov ah, 9
        mov dx, offset(memgot)
        int 21
        mov al,1
        mov memflag,al
        jmp endmget

memgeterror
        cmp ax, 8
        jne othermerr
        push bx
        call printax

        mov ah,9
        mov dx,offset(msmall)
        int 21
        pop ax  ; preserve bx and move at same time
        call printax
        mov ah,9
        mov dx, offset(mavail)
        int 21
        jmp endmget

othermerr
        mov ah,9
        mov dx,offset(mgerror)
        int 21

endmget
;        call endl
        mov ah, memflag
        cmp ah,1
        jne skip
        mov ah, 49      ;other parametr (ES) already in place
        int 21
        jc fmerr

        mov dx, offset(freemem2)
        mov ah,9
        int 21
        jmp skip
fmerr
        mov ah,9
        mov dx,offset(freemem3)
        int 21
skip
        call endl
        call dosegs
        call endl
        mov ah,9
        mov dx, offset(pak)
        int 21

;wait for key press
        mov ah,0
        int 16
        call endl

;end program
        mov ah, 04c
        mov al, 00
        int 021
        ret

endl
        push ax
        push dx
        mov dx, offset(crnl)
        mov ah,9
        int 21
        pop dx
        pop ax
        ret

printreg
        call printax
        mov ah,9
        int 21
        call endl
        ret

dosegs
        push ax
        push dx
        mov ah,9
        mov dx,offset(regp)
        int 21
        call endl

        mov ax, cs
        mov dx, offset(pcs)
        call printreg
        mov ax, ds
        mov dx, offset(pds)
        call printreg
        mov ax, ss
        mov dx, offset(pss)
        call printreg
        mov ax, es
        mov dx, offset(pes)
        call printreg

        pop dx
        pop ax
        ret

dobl
        and bl,f
        cmp bl, 9
        ja blhex
        add bl, '0'
        ret

blhex
        add bl, 'a'
        sub bl, a
        ret

shblfour
        shr bl,1
        shr bl,1
        shr bl,1
        shr bl,1
        ret

printax
        push ax
        push bx
        push dx

        mov bx, ax

        ;and bl, f
        call dobl
        mov axdatad, bl

        mov bx, ax
        call shblfour
        ;and bl, f
        call dobl
        mov axdatac, bl

        mov bl, ah
        call dobl
        mov axdatab, bl

        mov bl, ah
        call shblfour
        call dobl

        mov axdataa, bl
        mov dx, offset(axdataa)
        mov ah, 9
        int 21
    pop dx
    pop bx
    pop ax
    ret

memflag db 0
pcs db ' cs$'
pss db ' ss$'
pds db ' ds$'
pes db ' es$'
pname           db '******************************************',d,a
pname2          db '* LCD Test Program'd,a,'David Hoppe 2003 *',d,a
pname3          db '******************************************',d,a,a,'$'
freemem         db ' AX register (paragraph address of program??)',d,a
fm2             db '     Freed extra memory claimed by DOS for COM file',d,a,'$'
freeerr         db ' error freeing memory with int 21 function 4A',d,a,'$'
getmem          db ' Return value of memory allocation',d,a,'$'
memgot          db ' Paragraphs of memory alocated',d,a,'$'
mgerror         db ' Error Allocating memory with int 21 function 48',d,a,'$'
msmall          db ' Not enough memory for int 21 function 48',d,a,'$'
mavail          db ' Paragraphs available',d,a,'$'
freemem2        db ' deallocated memory with int 21 function 49',d,a,'$'
freemem3        db ' ERROR deallocating memory',d,a,'$'
pak             db 'Press any key to continue...$'
crnl db d, a, '$'
regp    db 'Segment Registers$'
axdataa db 'x'
axdatab db 'x'
axdatac db 'x'
axdatad db 'x$'
