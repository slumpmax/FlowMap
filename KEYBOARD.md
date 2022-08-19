ESC - Exit
ARROW KEY - Scroll 8 direction
SPACE - Toggle display page (2 and 3)
F1 - Redraw
F2 - 50/60 Hz
F3 - Reload binary
F4 - Next binary
0 - Show menu
1 - Show swap page (3)
2 - Show pattern page (0)
3 - Show map and software sprites page (1)
4 - Reset position to X:0 / Y:0
5 - Goto X:1024 / Y:1024
6 - Reload images
7 - Restore MAP & TILE from RAM
8 - Toggle hardware/software sprite
9 - Fast walk
\* - Clear screen
\[ - Distance - 1
\] - Distance + 1
INS - Speed + 1
DEL - Speed - 1

USR0	=	INIT                             ; Initial draw
USR1	=	SCROLL                         ; Scroll to direction (0 to 8)
USR2	=	SETVPAGE                     ; Show page (0 to 3)
USR3	=	SPRWALK                      ; Sprite walk (0 = Swap step, 1 = Swap step and do soft sprite walk)
USR4	=	TESTAREA                     ; Test FILL and DRAW routine
USR5	=	USER5		          	           ; Transfer MAPPAGE with RAM (0 = Restore, 1 = Store)
USR6	=	USER6			                     ; Draw UI (0 = Remove, 1 = Draw)
USR7	=	USER7			                     ; Draw/Erase Soft sprites (0 = Remove, 1 = Draw)
USR8	=	CLEAR_DISPLAY             ; Clear screen
USR9	=	CHANGE_SPRITE_MODE  ; Sprite mode (0 = None, 1 = Hard, 2 = Soft, 3 = Hard & Soft)