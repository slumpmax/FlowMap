### Keyboard control
> **ESC** - Exit<br>
**ARROW KEY** - Scroll 8 direction<br>
**SPACE** - Toggle display page (2 and 3)<br>
**F1** - Redraw<br>
**F2** - 50/60 Hz<br>
**F3** - Reload binary<br>
**F4** - Next binary<br>
**0** - Show menu<br>
**1** - Show swap page (3)<br>
**2** - Show pattern page (0)<br>
**3** - Show map and software sprites page (1)<br>
**4** - Reset position to X:0 / Y:0<br>
**5** - Goto X:1024 / Y:1024<br>
**6** - Reload images<br>
**7** - Restore MAP & TILE from RAM<br>
**8** - Toggle hardware/software sprite<br>
**9** - Fast walk<br>
**\*** - Clear screen<br>
**\[** - Distance - 1<br>
**\]** - Distance + 1<br>
**INS** - Speed + 1<br>
**DEL** - Speed - 1<br>

### User routine
> **USR0**	=	INIT                             ; Initial draw<br>
**USR1**	=	SCROLL                         ; Scroll to direction (0 to 8)<br>
**USR2**	=	SETVPAGE                     ; Show page (0 to 3)<br>
**USR3**	=	SPRWALK                      ; Sprite walk (0 = Swap step, 1 = Swap step and do soft sprite walk)<br>
**USR4**	=	TESTAREA                     ; Test FILL and DRAW routine<br>
**USR5**	=	USER5		          	           ; Transfer MAPPAGE with RAM (0 = Restore, 1 = Store)<br>
**USR6**	=	USER6			                     ; Draw UI (0 = Remove, 1 = Draw)<br>
**USR7**	=	USER7			                     ; Draw/Erase Soft sprites (0 = Remove, 1 = Draw)<br>
**USR8**	=	CLEAR_DISPLAY             ; Clear screen<br>
**USR9**	=	CHANGE_SPRITE_MODE  ; Sprite mode (0 = None, 1 = Hard, 2 = Soft, 3 = Hard & Soft)<br>
