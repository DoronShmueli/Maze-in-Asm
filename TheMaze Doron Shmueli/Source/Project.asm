;------------------------------------------
; File   :  Base.asm
; Author :  Doron Shmueli
; Date   :  5/31/2019
; Class  :  Yod-3
;------------------------------------------

comment/*
. . . .


*/
p386
ideal
MODEL small

STACK 100h
;-------------------------------------------------------------
; DrawMImage - drawing of a moving object
;-------------------------------------------------------------
; Input:
; ObjY - coordinate Y
;   ObjX - coordinate X
;   ObjW - width of object
; ObjH - height of object
;   Obj -  address of object
; Output:
; none
; Registers
; AX
;----------------------------------------------------------

MACRO DrawMImage ObjX,ObjY,ObjW,ObjH,Obj
;turns the obj to the img you want
        mov     AX, [ObjX]
        mov     [ImageX],AX

        mov     AX, [ObjY]
        mov     [ImageY],AX

mov     AX, ObjW
mov     [ImageW], AX

mov     AX, ObjH
mov     [ImageH], AX
mov     [ImageMaskOffset], offset Obj

        call    DrawMovingImage
ENDM
; scancode for Arrow
UP_KEY      equ 72
DOWN_KEY    equ 80
RIGHT_KEY   equ 77
LEFT_KEY    equ 75



DATASEG



MenuMain db "",13,10	
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "  _______ _            __  __               _ ",13,10
	 db " |__   __| |          |  \/  |             | |",13,10
	 db "    | |  | |__   ___  | \  / | __ _ _______| |",13,10
	 db "    | |  | '_ \ / _ \ | |\/| |/ _` |_  / _ \ |",13,10
	 db "    | |  | | | |  __/ | |  | | (_| |/ /  __/_|",13,10
	 db "    |_|  |_| |_|\___| |_|  |_|\__,_/___\___(_)",13,10
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "                  1. Start to play!",13,10
	 db "",13,10
	 db "                  2. Rules + How to play",13,10
	 db "",13,10
	 db "                  3. About the creator",13,10
	 db "",13,10
	 db "                  4. Exit",13,10
	 db "",13,10
	 db "",13,10
	 db "",13,10
	 db "$",13,10
	
MyGame  db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "This will be the game screen",13,10
		db "Press esc to go back",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "",13,10
		db "$",13,10
;The Rule screen in text mode		
RulesScreen db "",13,10
            db "",13,10
            db "",13,10
            db "          Rules:",13,10
            db "",13,10
            db "          1) You cant touch the walls   ",13,10
            db "",13,10
            db "          2) You need to get to the end of the maze as fast as you can",13,10
            db "",13,10
            db "",13,10
			db "          How to play?",13,10
            db "",13,10
            db "          Use the arrow keys to move",13,10
            db "",13,10
            db "          Your goal is to finish the maze without lose!",13,10
            db "",13,10
            db "",13,10
			db "",13,10
			db "          Good luck!",13,10
			db "",13,10
			db "          Press esc to go back",13,10
			db "",13,10
			db "",13,10
			db "",13,10
			db "",13,10
			db "",13,10
			db "",13,10
			db "$",13,10
;The about the creator screen in text mode			
AboutScreen db "",13,10
			db "",13,10
			db "",13,10
			db "         About the creator:",13,10
			db "",13,10
			db "         - My name is Doron Shmueli",13,10
			db "",13,10
			db "         - I'm in 10th grade",13,10
			db "",13,10
			db "         - This game has been made in Assembly language in the year of 2020",13,10
			db "",13,10
			db "",13,10
			db "",13,10
			db "  _    _                   ______           _  ",13,10
			db " |_|  |_|                 |______|         |_| ",13,10
			db " | |__| | __ ___   _____  | |__ _   _ _ __ | | ",13,10
			db " |  __  |/ _` \ \ / / _ \ |  __| | | | '_ \| | ",13,10
			db " | |  | | (_| |\ V /  __/ | |  | |_| | | | |_| ",13,10
			db " |_|  |_|\__,_| \_/ \___| |_|   \__,_|_| |_(_) ",13,10
			db "",13,10
			db "     press esc to go back",13,10
			db "",13,10
			db "",13,10
			db "",13,10
			db "",13,10
			db "$",13,10
			
			
WinScreen 	db "",13,10 
			db "",13,10
			db "",13,10
			db "__     __           _                                           _ ",13,10
			db "\ \   / /          | |                                         | |",13,10
			db " \ \_/ /__  _   _  | |__   __ ___   _____  __      _____  _ __ | |",13,10
			db "  \   / _ \| | | | | '_ \ / _` \ \ / / _ \ \ \ /\ / / _ \| '_ \| |",13,10 
			db "   | | (_) | |_| | | | | | (_| |\ V /  __/  \ V  V / (_) | | | |_|",13,10
			db "   |_|\___/ \__,_| |_| |_|\__,_| \_/ \___|   \_/\_/ \___/|_| |_(_)",13,10
			db "",13,10
			db "",13,10
			db "I hope you had fun playing in my game!",13,10
			db "If you found a problem, pls contact me at s04035@nomishemer.ort.org.il",13,10
			db "$",13,10
			
			include "BitMap.inc"
			include "player.inc"
			ImageX dw ?
        ImageY dw ?
        ImageW dw ?
        ImageH dw ?
        ImageMaskOffset dw ?
		Xmap dw 0
		Ymap dw 0
		Xplayer dw 176
        Yplayer dw 98	

CODESEG

start:
        mov ax,@data
        mov ds,ax
		lop2:
		;Prints the menu string
        mov ah, 09h
        mov dx, offset MenuMain
        int 21h
		;Gets the user input
		mov ah, 07h
        int 21h
        cmp al, 31h
        je StartGame
		cmp al, 32h
		je RulesL 
		cmp al, 33h 
		je CreatorL
		cmp al, 34h
		je exit
		jmp lop2
;Labels		
StartGame:
		call Game
		jmp lop2
RulesL:
		call RulesHow
		jmp lop2
CreatorL:
		call AboutMe
		jmp lop2
		
		
       
exit:

        mov ax,4C00h
        int 21h
		
		
		
;----------------------------------------------
; Showing to the user the rules and how      
; to play screen.
;----------------------------------------------------------
; Input: None
; Output: Showes the Rules and How to play screen
; Registers 
;             ah, al, dx
;----------------------------------------------------------
proc  RulesHow
RulesHowL:
		;Prints the Rules screen
        mov ah, 9h
        mov dx, offset RulesScreen
        int 21h
		mov ah,07h
        int 21h
		cmp al,01Bh
		je returnMenu
        jmp RulesHowL
		returnMenu:
		ret
		endp
		
		
		
;----------------------------------------------------------
;  Showes to the user the about the creator screen.    
;----------------------------------------------------------
; Input: None
; Output: Showes the About the creator screen
; Registers 
;             ah, al, dx
;----------------------------------------------------------
proc  AboutMe
AboutMeL:
		;Printing the About the creator screen
        mov ah, 9h
        mov dx, offset AboutScreen
        int 21h
		;puts user input in al
		mov ah,07h
        int 21h
		cmp al,01Bh
        je returnMenu2
        jmp AboutMeL
		returnMenu2:
		ret
		endp
		
		
		
;----------------------------------------------------------
; Show and run the game for the user
;----------------------------------------------------------
; Input:Xplayer , Yplayer , Wplayer , Hplayer , player , Xmap ,Ymap, Wmap , Hmap , Map. 
; Output: Playable game.
; Registers
;             cx, si, al, dx, bh
;----------------------------------------------------------
PROC Game near
@@Start:  ;flowchart 1
	mov [Xplayer], 3
    mov [Yplayer], 3
;changes to graphic
mov ax, 0013h
int 10h
	;DrawMImage ObjX,ObjY,ObjW,ObjH,Obj
	DrawMImage Xmap,Ymap,Wmap,Hmap,Map
	Redraw:   ;flowchart 2
		
		add [Xplayer], 3
		add [Yplayer], 3
		call ReadPixle
		sub [Xplayer], 3
		sub [Yplayer], 3
		cmp al, 1 ;if it hit the blue color it goes back to the starts of the maze.
		je @@Start
		
		cmp al, 5
		je Win ;if it hit the pink so it goes to the win screen.
		call ReadPixle
		cmp al, 1 ;if it hit the blue color it goes back to the starts of the maze.
		je @@Start
		
		DrawMImage Xplayer,Yplayer,Wplayer,Hplayer,player	
	lop: ;flowchart 5
	; put the scancode in the ah
	mov ah , 00h
	int 16h
	cmp ah, UP_KEY
	je MoveUp
	cmp ah, DOWN_KEY  
    je MoveDown	
	cmp ah, RIGHT_KEY
    je MoveRight	
	cmp ah, LEFT_KEY
    je MoveLeft  
	cmp ah,1 ;PRESS ESC
	je returnMenu3

		
		MoveUp:  ;flowchart 6
		dec [Yplayer]
		jmp Redraw
		
		MoveDown: ;flowchart 7
		inc [Yplayer]
		jmp Redraw
		
		MoveRight: ;flowchart 8
		inc [Xplayer]
		jmp Redraw
		
		MoveLeft: ;flowchart 9
		dec [Xplayer]
		jmp Redraw
		win:  ;flowchart 3
		call Show_Win
		returnMenu3: ;flowchart 10
		;changes back to text mode
		mov ax, 03h
        int 10h
		ret
        endp Game



;----------------------------------------------------------
; Checks the pixle's color by his x,y
;----------------------------------------------------------
; Input: Xplayer, Yplayer
; Output: al (The hit color)
; Registers
;             cx, si, al, dx, bh
;----------------------------------------------------------
PROC ReadPixle
;if ah is 0dh so it reads a pixle from the screen by his x,y 
mov ah, 0dh
mov bh, 0
mov cx, [Xplayer]
mov dx, [Yplayer]
;puts the color of the pixle in al
int 10h
ret
endp



;----------------------------------------------------------
; This proc is drawing the player and the map in the game
; and showing it to the user
;----------------------------------------------------------
; Input: ImageW , ImageMaskOffset , ImageX , ImageY,
;ImageH.
; Output:Draw the player on the user screen
; Registers
;             cx, si, al, dx, bh
;----------------------------------------------------------
PROC DrawMovingImage near
        mov cx, [ImageW]
       ; moving into si the first image offset (first byte)
        mov si, [ImageMaskOffset]
	   ;loop to go over each pixle and draw each line
cycle1:
;si points at a pixle and al gets the value of the color
mov al, [byte si]
pusha
call PutPixel
popa
;move to the next pixle to point for the color
inc si
;changes x value based on the pixle placment for each line
inc [ImageX]
;dec dx
loop cycle1
; X loop
        ;push dx
        ;loop takes one from cx each time
        mov cx, [ImageW]
        ; cant do memory minus memory so added dx
        mov dx, [ImageW]
;Imagex resets
sub [ImageX], dx
;pop dx
;goes to next line
inc [ImageY]
       ;subscribes 1 from imageH 
        dec [ImageH]
        ; to check if the whole picture is drawn (no lines left to draw)
        ;(if [imageh] isnt equal to 0)
        jnz cycle1

; Y loop
  ret
ENDP DrawMovingImage



;----------------------------------------------------------
; put colors each pixle on screen
;----------------------------------------------------------
; Input:ImageX , ImageY.
; Output: Draw’s the pixel in the current x,y (ImageX , ImageY).
; Registers
;             cx, si, al, dx, bh
;----------------------------------------------------------
proc PutPixel near
        mov bh,0h
        ;put x image value in cx
        mov cx,[ImageX]
        ;put y image value in dx
        mov dx,[ImageY]
        ;makes 015 transperent color
        cmp al, 13
        je skip

mov ah,0Ch
;int to draw
int 10h
Skip :
        ret
        endp PutPixel
		

		
;----------------------------------------------
; Showing to the user the win screen of the game    
;----------------------------------------------------------
; Input: WinScreen (offset)
; Output: Shows the win screen
; Registers 
;             ah, al, dx
;----------------------------------------------------------
proc  Show_Win

;changes back to text mode
		mov ax, 03h
        int 10h
;prints the win screen
		mov ah, 09h
        mov dx, offset WinScreen
        int 21h
;Gets the user input
		mov ah, 07h
        int 21h
		jmp exit

ret
endp Show_Win

END start

