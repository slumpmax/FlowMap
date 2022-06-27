; Byte References

VALTYPINT		equ	2
VALTYPSTR		equ	3
VALTYPSNG		equ	4
VALTYPDBL		equ	5

; VDP Commands
CMDSTOP		equ	00h	; Stop
CMDINVALID1	equ	10h	; Not used
CMDINVALID2	equ	20h	; Not used
CMDINVALID3	equ	30h	; Not used
CMDPOINT		equ	40h	; Point
CMDPSET		equ	50h	; Pset
CMDSEARCH		equ	60h	; Search
CMDLINE		equ	70h	; Line
CMDLMMV		equ	80h	; Low speed fill
CMDLMMM		equ	90h	; Low speed copy
CMDLMCM		equ	0A0h	; Low speed getpixels
CMDLMMC		equ	0B0h	; Low speed setpixels
CMDHMMV		equ	0C0h	; High speed fill
CMDHMMM		equ	0D0h	; High speed copy
CMDYMMM		equ	0E0h	; High speed copy y-direction
CMDHMMC		equ	0F0h	; High speed setpixels

; VDP Command Logical Operations
LCMD_IMP		equ	00h	; DES = SRC
LCMD_AND		equ	01h	; DES = SRC and DES
LCMD_OR		equ	02h	; DES = SRC or DES
LCMD_EOR		equ	03h	; DES = SRC xor DES
LCMD_NOT		equ	04h	; DES = not SRC
LCMD_TIMP		equ	08h	; Ignore CL0, DES = SRC
LCMD_TAND		equ	09h	; Ignore CL0, DES = SRC and DES
LCMD_TOR		equ	0Ah	; Ignore CL0, DES = SRC or DES
LCMD_TEOR		equ	0Bh	; Ignore CL0, DES = SRC xor DES
LCMD_TNOT		equ	0Ch	; Ignore CL0, DES = not SRC

VRAMPORT		equ	98h	; V9938 VRAM port
VDPPORT		equ	99h	; V9938 Register port
PALPORT		equ	9Ah	; V9938 Palette port
CMDPORT		equ	9Bh	; V9938 Command port

SELRG2		equ	82h	; V9938 Select Reg#2 - Page offset
SELRG14		equ	8Eh	; V9938 Select Reg#14 - High bit for VRAM address
SELRG15		equ	8Fh	; V9938 Select Reg#15 - Set status register index
SELRG17		equ	91h	; V9938 Select Reg#17 - Set command register index
SELRG18		equ	92h	; V9938 Select Reg#18 - Screen adjust
SELRG23		equ	97h	; V9938 Select Reg#23 - Vertical offset
SELRG27		equ	9Bh	; V9938 Select Reg#27 - Vertical offset

; Word References

MMUSRTAB		equ	0F39Ah
MMRG2SAV		equ	0F3E1h
MMVALTYP		equ	0F663h
MMUSRINT		equ	0F7F8h
MMDPPAGE		equ	0FAF5h
MMRG18SAV		equ	0FFF1h
MMRG23SAV		equ	0FFF6h
EXPTBL		equ	0FCC1h
SLTTBL		equ	0FCC5h
SCR5ATTR		equ	7600h

MSXERROR		equ	406Fh	; MSX BASIC ERROR HANDLER ROUTINE

; Routine constant

TILE_PAGE		equ	0
MAP_PAGE		equ	1
START_PAGE	equ	2
MAP_SLOT		equ	4
SPR_SLOT		equ	5
TILE_SLOT		equ	6

; === BSAVE header (7 Bytes) ===

PROGSTART		equ	0C000h

			org	PROGSTART - 7

			db	0FEh
			dw	PROGSTART
			dw	PROGEND - 1
			dw	PROGRUN
	
; === Begin ===

POSX:		dw	0000			;C000 World position X
POSY:		dw	0000			;C002 World position Y
POSYH		equ	POSY + 1

MAPX:		db	00			;C004
MAPY:		db	00			;C005
PATX:		db	00			;C006 
PATY:		db	00			;C007
DISPLAY_PAGE:	db	START_PAGE	;C008 Current display page (1, 2, 3)
AMOUNT:		db	01			;C009 Scroll count
SPEED:		db	01			;C00A Scroll speed 1,2,4,8,16
			db	00
OPOSX:		dw	0000			;C00C
OPOSY:		dw	0000			;C00E
			ds	16			; DUMMY DATA for future uses

; 32 hardware sprites location = db Y, X, N, C
SPRITE_TABLE:
		db	240, 0, 0, 0	;C020
		db	240, 0, 1, 0
		db	240, 0, 2, 0
		db	240, 0, 3, 0
		db	240, 0, 4, 0
		db	240, 0, 5, 0
		db	240, 0, 6, 0
		db	240, 0, 7, 0
		db	240, 0, 8, 0
		db	240, 0, 9, 0
		db	240, 0, 10, 0
		db	240, 0, 11, 0
		db	240, 0, 12, 0
		db	240, 0, 13, 0
		db	240, 0, 14, 0
		db	240, 0, 15, 0
		db	240, 0, 16, 0
		db	240, 0, 17, 0
		db	240, 0, 18, 0
		db	240, 0, 19, 0
		db	240, 0, 20, 0
		db	240, 0, 21, 0
		db	240, 0, 22, 0
		db	240, 0, 23, 0
		db	240, 0, 24, 0
		db	240, 0, 25, 0
		db	240, 0, 26, 0
		db	240, 0, 27, 0
		db	240, 0, 28, 0
		db	240, 0, 29, 0
		db	240, 0, 30, 0
		db	240, 0, 31, 0

; === Software sprite table [db X, FX, Y, Number (0-127)] ===
SOFT_SPRITE:
		db	050, 0, 050, $48	; C0A0
		db	070, 0, 050, $40
		db	090, 0, 050, $00
		db	110, 0, 050, $08
		db	130, 0, 100, $10
		db	150, 0, 100, $18
		db	170, 0, 100, $20
		db	190, 0, 100, $28

; === use for some subroutine ===
DESX0:		db	0
DESY0:		db	0
CNTX0:		db	0
CNTY0:		db	0
RAWSPEED:		db	01	; Internal speed

; === V9938 CMD buffer ===
SRCX:		dw	0000
SRCY:		db	00
SRCPAGE:		db	00
DESX:		dw	0000
DESY:		db	00
DESPAGE:		db	00
CNTX:		dw	0000
CNTXH:		equ	CNTX + 1
CNTY:		dw	0000
CNTYH		equ	CNTY + 1
COLOR:		db	00
PARAM:		db	00
CMD:			db	00

; === V9938 Temp CMD buffer ===
SRCX1:		dw	0000
SRCY1:		db	00
SRCPAGE1:		db	00
DESX1:		dw	0000
DESY1:		db	00
DESPAGE1:		db	00
CNTX1:		dw	0000
CNTXH1:		equ	CNTX1 + 1
CNTY1:		dw	0000
CNTYH1:		equ	CNTY1 + 1
COLOR1:		db	00
PARAM1:		db	00
CMD1:		db	00

; === Execute V9938 command ===
VDPFILL:
		ld	a,24h
		ld	b,11
		ld	hl,DESX
		jr	VDPEXEC
VDPFILL1:
		ld	a,24h
		ld	b,11
		ld	hl,DESX1
		jr	VDPEXEC
VDPCOPY1:
		ld	a,20h
		ld	b,15
		ld	hl,SRCX1
		jr	VDPEXEC
VDPCOPY:
		ld	a,20h
		ld	b,15
		ld	hl,SRCX
VDPEXEC:
		di
		out	(VDPPORT),a
		ld	a,SELRG17
		out	(VDPPORT),a
		ld	c,CMDPORT
VDPEX_WAIT:
		ld	a,2
		di
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		in	a,(VDPPORT)
		rra
		ld	a,0
		out	(VDPPORT),a
		ld	a,SELRG15
		ei
		out	(VDPPORT),a
		jr	c,VDPEX_WAIT
		otir
		ret
	
; === V9938 indirect register (no DI/EI) ===
VDP_INIT:
		out	(VDPPORT),a
		ld	a,SELRG17
		out	(VDPPORT),a
VDP_WAIT:
		ld	a,2
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		in	a,(VDPPORT)
		rra
		ld	a,0
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		jr	c,VDP_WAIT
		ret

; === Clear back page ===
CLEAR_BACK_PAGE:
		xor	a
		ld	(DESX),a
		ld	(DESY),a
		ld	(COLOR),a
		ld	(CNTX),a
		ld	(CNTY),a
		inc	a
		ld	(CNTXH),a
		ld	(CNTYH),a
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DESPAGE),a
		ld	a,CMDHMMV
		ld	(CMD),a
		call	VDPFILL
		ld	a,MAP_PAGE
		ld	(DESPAGE),a
		call	VDPFILL
		xor	a
		ld	(CNTXH),a
		ld	(CNTYH),a
		ret

; === Fetch POSX, POSY to MAPX, MAPY, PATX, PATY ===
; Return H = MAPX, L = PATX, D = MAPY, E = PATY
FETCH_XY:
		ld	hl,(POSX)
		ld	de,(POSY)
FETCH_POS:
		ld	a,h
		rlca
		rlca
		rlca
		rlca
		and	70h
		ld	h,a
		ld	a,l
		rrca
		rrca
		rrca
		rrca
		and	0Fh
		or	h
		ld	h,a
		ld	(MAPX),a
		ld	a,l
		and	0Fh
		ld	l,a
		ld	(PATX),a
		; ld	(DESX),a

		ld	a,d
		rlca
		rlca
		rlca
		rlca
		and	70h
		ld	d,a
		ld	a,e
		rrca
		rrca
		rrca
		rrca
		and	0Fh
		or	d
		ld	d,a
		ld	(MAPY),a
		ld	a,e
		; ld	(DESY),a
		and	0Fh
		ld	e,a
		ld	(PATY),a

		ret

; === Fetch MAPX, MAPY ===
; Input HL = POSX, DE = POSY
; Return H = MAPX, D = MAPY
FETCH_MAP:
		ld	a,h
		rlca
		rlca
		rlca
		rlca
		and	70h
		ld	h,a
		ld	a,l
		rrca
		rrca
		rrca
		rrca
		and	0Fh
		or	h
		ld	h,a
		ld	(MAPX),a

		ld	a,d
		rlca
		rlca
		rlca
		rlca
		and	70h
		ld	d,a
		ld	a,e
		rrca
		rrca
		rrca
		rrca
		and	0Fh
		or	d
		ld	d,a
		ld	(MAPY),a

		ret

; === Set vertical offset VDP & screen adjust VDP ===
SETSCROLL:
		ld	a,2
		di
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		in	a,(VDPPORT)
		rrca
		ld	a,0
		out	(VDPPORT),a
		ld	a,SELRG15
		ei
		out	(VDPPORT),a
		jr	c,SETSCROLL
SETSC_WAIT1:
		ld	a,2
		di
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		in	a,(VDPPORT)
		rlca
		rlca
		ld	a,0
		out	(VDPPORT),a
		ld	a,SELRG15
		ei
		out	(VDPPORT),a
		jr	c,SETSC_WAIT1
SETSC_WAIT2:
		ld	a,2
		di
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		in	a,(VDPPORT)
		rlca
		rlca
		ld	a,0
		out	(VDPPORT),a
		ld	a,SELRG15
		ei
		out	(VDPPORT),a
		jr	nc,SETSC_WAIT2
		ld	a,(POSY)
		ld	(MMRG23SAV),a
		di
		out	(VDPPORT),a
		ld	a,SELRG23
		ei
		out	(VDPPORT),a
		ld	a,(POSX)
		add	a,8
		and	0Fh
		ld	(MMRG18SAV),a
		di
		out	(VDPPORT),a
		ld	a,SELRG18
		ei
		out	(VDPPORT),a
		ld	a,(DISPLAY_PAGE)
		ld	(MMDPPAGE),a
		rrca
		rrca
		rrca
		and	60h
		or	1Fh
		ld	(MMRG2SAV),a
		di
		out	(VDPPORT),a
		ld	a,SELRG2
		ei
		out	(VDPPORT),a
		ret

; Put 32 hardware sprites
PUT_HARD:
		ret
		exx
		ld	a,(POSX)
		and	15
		ld	d,a
		ld	a,(POSY)
		ld	e,a
		ld	hl,SCR5ATTR
		ld	a,h
		rrca
		rrca
		and	1
		di
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,l
		out	(VDPPORT),a
		ld	a,h
		and	3Fh
		or	40h
		out	(VDPPORT),a
		ld	b,32
		ld	hl,SPRITE_TABLE
LOOP_PUT_HARD:
		ld	a,(hl)
		inc	hl
		add	a,e
		cp	217
		jr	nc,NO_216
		dec	a
NO_216:
		out	(VRAMPORT),a
		ld	a,(hl)
		inc	hl
		add	a,d
		out	(VRAMPORT),a
		ld	a,(hl)
		inc	hl
		rlca
		rlca
		out	(VRAMPORT),a
		ld	a,(hl)
		inc	hl
		out	(VRAMPORT),a
		dec	b
		jr	nz,LOOP_PUT_HARD
		ei
		exx
		ret

; === USR2 - Set display to page (n) ===
SETVPAGE:
		ld	e,5
		ld	a,(MMVALTYP)
		cp	VALTYPINT
		jp	nz,MSXERROR
		ld	hl,(MMUSRINT)
		ld	a,h
		and	a
		jp	nz,MSXERROR
		ld	a,l
		cp	4
		jp	nc,MSXERROR
		ld	(MMDPPAGE),a
		rrca
		rrca
		rrca
		and	60h
		or	1Fh
		ld	(MMRG2SAV),a
		di
		out	(VDPPORT),a
		ld	a,SELRG2
		ei
		out	(VDPPORT),a
		ret
		
; === Draw horizontal tile area ===
PDRAW_HTILE:
		ld	a,TILE_PAGE
		ld	(SRCPAGE),a
DRAW_HTILE:
		ld	a,(POSY)
		ld	e,a
		ld	a,212
		jr	DHA_TILE
PDRAW_HAREA:
		ld	a,TILE_PAGE
		ld	(SRCPAGE),a
DRAW_HAREA:	; DESX, DESY0, CNTX, CNTY0, MAPX, MAPY
		ld	a,(DESX)
		rrca
		ld	a,(CNTX)
		rla
		and	3
		ld	a,CMDHMMM
		jr	z,DHA_HCOPY
		ld	a,CMDLMMM
DHA_HCOPY:
		ld	(CMD),a
		ld	a,(DESY0)
		ld	e,a
		ld	d,0
		ld	hl,(POSY)
		add	hl,de
		ld	e,l
		ld	a,l
		rr	h
		rra
		rr	h
		rra
		rr	h
		rra
		rr	h
		rra
		and	7Fh
		ld	(MAPY),a
		ld	a,(CNTY0)
DHA_TILE:
		ex	af,af'
		ld	a,(DESX)
		and	0Fh
		ld	b,a			; b = xoffset (0-15)
		ld	a,e
		and	0Fh
		ld	c,a			; c = yoffset (0-15)
		ld	a,16
		sub	c
		ld	d,a			; d = 16 - yoffset
		ld	(CNTY),a
		ld	hl,(MAPX)		; h = mapy, l = mapx
DHA_LOOP:
		push	hl
		push	bc
		call	GET_MAP
		pop	bc
		ld	h,a
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		add	a,b
		ld	(SRCX),a
		ld	a,h
		and	0F0h
		add	a,c
		ld	(SRCY),a
		ld	a,e
		ld	(DESY),a
		push	bc
		call	VDPCOPY
		pop	bc
		ld	a,e
		add	a,d
		ld	e,a
		ex	af,af'
		sub	d
		pop	hl
		ret	z
		ret	c
		ld	d,16
		cp	d
		jr	nc,DHA_NO
		ld	d,a
DHA_NO:
		ex	af,af'
		ld	a,d
		ld	(CNTY),a
		ld	a,h
		inc	a
		and	7Fh
		ld	h,a
		xor	a
		ld	c,a
		jr	DHA_LOOP

; === Draw tile blocks to specified area ===
; DESX0, DESY0, CNTX0, CNTY0, MAPX, MAPY (Virtual screen 240x212)
DRAW_AREA:
		ld	a,TILE_PAGE
		ld	(SRCPAGE),a
		xor	a
		ld	(COLOR),a
		ld	a,(CNTX0)
		ld	b,a			; b = CNTX0
		
		ld	hl,(POSX)
		ld	a,l
		and	0Fh
		ld	c,a
		ld	a,(DESX0)
		ld	e,a
		add	a,c
		ld	(DESX),a
		jr	c,DA_OVER
		ld	d,0
		add	hl,de
DA_OVER:
		ld	d,a
		and	0Fh
		ld	e,a			; e = x offset (0-15)
		ld	a,l
		rr	h
		rra
		rr	h
		rra
		rr	h
		rra
		rr	h
		rra
		and	7Fh
		ld	(MAPX),a
		
		ld	l,d			; d = DESX
		ld	d,c			; d = PATX
		ld	a,240
		add	a,d
		ld	h,a			; h = 240 + PATX

		ld	a,l
		cp	d
		jr	c,DA_FILL_LEFT
DA_LOOP:					; loop draw
		cp	h
		jr	c,DA_DRAW
		ld	a,16
		sub	e
		dec	a
		dec	b
		cp	b
		jr	c,DA_NO_CROP_RIGHT
		ld	a,b
DA_NO_CROP_RIGHT:
		inc	a
		inc	b
		ld	(CNTX),a
		jp	FILL_HAREA
DA_FILL_LEFT:
		ld	a,d
		sub	l
		dec	a
		dec	b
		cp	b
		jr	c,DA_NO_CROP_LEFT
		ld	a,b
DA_NO_CROP_LEFT:
		inc	a
		inc	b
		ld	(CNTX),a
		ld	c,a
		exx
		call	FILL_HAREA
		exx
		jr	DA_NEXT
DA_DRAW:
		cp	240
		jr	nz,DA_NOT_LAST
		ld	a,d
		jr	DA_CROP_TILE
DA_NOT_LAST:
		ld	a,16
		sub	e
DA_CROP_TILE:
		dec	a
		dec	b
		cp	b
		jr	c,DA_NO_CROP_TILE
		ld	a,b
DA_NO_CROP_TILE:
		inc	a
		inc	b
		ld	(CNTX),a
		ld	c,a
		exx
		call	DRAW_HAREA
		exx
		ld	a,(MAPX)
		inc	a
		ld	(MAPX),a
DA_NEXT:
		ld	a,l
		add	a,c
		ld	l,a
		ld	(DESX),a
		and	0Fh
		ld	e,a
		ld	a,b
		sub	c
		ld	b,a
		ld	a,l
		jr	nz,DA_LOOP
		ret

; === Draw line to back page ===
DRAW_BACK:
		ld	a,TILE_PAGE
		ld	(SRCPAGE),a
		ld	a,CMDLMMM
		ld	(CMD),a

		ld	hl,(POSX)
		ld	a,l
		rr	h
		rra
		rr	h
		rra
		rr	h
		rra
		rr	h
		rra
		and	7Fh
		inc	a
		ld	h,a			; H = MAPX + 1
		ld	a,l
		and	0Fh
		ld	l,a			; L = PATX
		inc	a
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		ld	e,a			; E = (PATX + 1) * 16

		ld	c,16			; C = CNTX
		xor	a
		ld	d,a			; D = DESX
DBACK_LOOP:
		ld	(DESX),a
		cp	240
		jr	c,DBACK_LESS_240
		jr	z,DBACK_240
		ld	a,h
		add	a,14
		ld	h,a
		ld	a,16
		sub	l
		ld	c,a
		jr	DBACK_LESS_PATX
DBACK_240:
		ld	a,l
		and	a
		jr	z,DBACK_PAT0
		ld	c,l
		ld	a,h
		sub	14
		ld	h,a
		jr	DBACK_LESS_PATX
DBACK_PAT0:
		inc	h
		jr	DBACK_LESS_PATX
DBACK_LESS_240:
		cp	e
		jr	nz,DBACK_LESS_PATX
		dec	h
		dec	h
DBACK_LESS_PATX:
		ld	a,h
		ld	(MAPX),a
		ld	a,c
		ld	(CNTX),a
		exx
		call	DRAW_HAREA
		exx
		inc	h
		ld	a,d
		add	a,c
		ret	c
		ld	d,a
		jr	DBACK_LOOP

; === USR0 - Draw Initialize screen ===
INIT:
		call	CLEAR_BACK_PAGE
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DISPLAY_PAGE),a
		ld	(DESPAGE),a
		xor	a
		ld	(DESX0),a
		ld	(DESY0),a
		ld	a,240
		ld	(CNTX0),a
		ld	a,212
		ld	(CNTY0),a
		call	DRAW_AREA
		call	SETSCROLL
		call	PUT_HARD
		call	PUT_SOFT
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DESPAGE),a
		jp	DRAW_BACK

; === Fill horizontal block with color ===
FILL_HBAR:
		ld	a,(POSY)
		ld	l,a
		ld	(DESY),a
		ld	a,212
		jr	FHA_BAR
FILL_HAREA:	; DESX, DESY0, CNTX, CNTY0, COLOR
		ld	a,(DESX)
		rrca
		ld	a,(CNTX)
		rla
		and	3
		ld	a,CMDHMMV
		jr	z,FHA_HFILL
		ld	a,CMDLMMV
FHA_HFILL:
		ld	(CMD),a
		ld	a,(DESY0)
		ld	l,a
		ld	a,(POSY)
		add	a,l
		ld	l,a
		ld	(DESY),a
		ld	a,(CNTY0)
FHA_BAR:
		ld	(CNTY),a
		dec	a
		add	a,l
		jr	nc,FHA_NO
		inc	a
		ex	af,af'
		xor	a
		sub	l
		ld	(CNTY),a
		call	VDPFILL
		ex	af,af'
		ld	(CNTY),a
		xor	a
		ld	(DESY),a
FHA_NO:
		jp	VDPFILL

; === Copy horizontal block ===
COPY_HBAR:
		ld	a,(POSY)
		ld	(SRCY),a
		ld	(DESY),a
		ld	l,a
		ld	a,212
		ld	(CNTY),a
		dec	a
		add	a,l
		jr	nc,CHBNO1
		inc	a
		ex	af,af'
		xor	a
		sub	l
		ld	(CNTY),a
		call	VDPCOPY
		ex	af,af'
		ld	(CNTY),a
		xor	a
		ld	(SRCY),a
		ld	(DESY),a
CHBNO1:
		jp	VDPCOPY

; === Fill vertical block
FILL_VBAR:
		xor	a
		ld	(COLOR),a
		ld	(DESX),a
		ld	(CNTX),a
		inc	a
		ld	(CNTXH),a
		ld	a,CMDHMMV
		ld	(CMD),a
		ld	a,(CNTY)
		ld	b,a
		ld	a,(DESY)
		ld	c,a
		add	a,b
		jr	nc,FV_NO_CROP
		jr	z,FV_NO_CROP
		push	af
		xor	a
		sub	c
		ld	(CNTY),a
		call	VDPFILL
		pop	af
		ld	(CNTY),a
		xor	a
		ld	(DESY),a
FV_NO_CROP:
		call	VDPFILL
		xor	a
		ld	(CNTXH),a
		ret

; === Fill area ===
; inputs: DESX0, DESY0, CNTX0, CNTY0, COLOR
FILL_AREA:
		ld	a,(POSX)
		and	0Fh
		ld	c,a
		ld	a,(CNTX0)
		ld	b,a
		ld	a,(DESX0)
		add	a,c
		ld	(DESX),a
		and	0Fh
		ld	c,a
		ld	a,16
		sub	c
		dec	a
		dec	b
		cp	b
		jr	c,FA_NO_CROP
		ld	a,b
FA_NO_CROP:
		inc	a
		inc	b
		ld	(CNTX),a
		ld	c,a
		push	bc
		call	FILL_HAREA
		pop	bc
		ld	a,b
		sub	c
		ret	z
		ld	b,a
		ld	a,(DESX)
		add	a,c
		ld	(DESX),a
		ld	a,15
		dec	b
		cp	b
		jr	c,FA_NO_CROP
		ld	a,b
		jr	FA_NO_CROP

; === USR1 - Do scroll with direction (n) ===
SCROLL:
		ld	e,5
		ld	a,(MMVALTYP)
		cp	VALTYPINT
		jp	nz,MSXERROR
		ld	hl,(MMUSRINT)
		ld	a,h
		and	a
		jp	nz,MSXERROR
		ld	a,l
		cp	9
		jp	nc,MSXERROR
		ld	de,SCROLLSUB
		rlca
		add	a,e
		ld	e,a
		jr	nc,SCROLLNO1
		inc	d
SCROLLNO1:
		ld	a,(de)
		ld	l,a
		inc	de
		ld	a,(de)
		ld	h,a
		ld	(SCROLL_RT - 2),hl
		ld	a,(AMOUNT)
SCROLL_LOOP:
		ld	hl,(POSX)
		ld	(OPOSX),hl
		ld	hl,(POSY)
		ld	(OPOSY),hl
		push	af
		call	NOSCROLL
SCROLL_RT:
		pop	af
		dec	a
		jr	nz,SCROLL_LOOP
		ret

SCROLLSUB:
		dw	NOSCROLL
		dw	SCROLL_UP
		dw	SCROLL_UPRIGHT
		dw	SCROLL_RIGHT_X
		dw	SCROLL_DOWNRIGHT
		dw	SCROLL_DOWN
		dw	SCROLL_DOWNLEFT
		dw	SCROLL_LEFT_X
		dw	SCROLL_UPLEFT

NOSCROLL:
		ret

; === Scroll right X ===
SCROLL_RIGHT_X:
		call	PUT_SOFT_BACK
		ld	a,(POSX)
		ld	d,a
		ld	a,(SPEED)
		ld	b,a
		ld	c,1
SRX_PRE:
		ld	a,c
		ld	(RAWSPEED),a
		sla	c
		rr	b
		jr	c,SRX_BEGIN
		rr	d
		push	de
		push	bc
		call	c,SRX_BEGIN
		pop	bc
		pop	de
		ld	a,c
		cp	16
		jr	nz,SRX_PRE
		ld	(RAWSPEED),a

SRX_BEGIN:
		xor	a
		ld	(COLOR),a
		ld	hl,(POSX)
		ld	a,(RAWSPEED)
		ld	b,a
		add	a,l
		jr	nc,SRX_NO_INCH
		inc	h
SRX_NO_INCH:
		ld	l,a
		ld	a,b
		cpl
		inc	a
		and	l
		ld	l,a
		ld	a,h
		and	7
		ld	h,a
		ld	(POSX),hl
		call	FETCH_XY
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,l
		and	a
		jp	nz,MOVE_RIGHT_X
		
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DISPLAY_PAGE),a
		ld	(DESPAGE),a
		ld	a,240
		ld	(DESX),a
		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMV
		ld	(CMD),a
		push	hl
		call	FILL_HBAR
		
		ld	a,CMDHMMM
		ld	(CMD),a
		ld	a,TILE_PAGE
		ld	(SRCPAGE),a
		ld	a,(RAWSPEED)
		dec	a
		jr	z,SRX_1X
		dec	a
		jr	z,SRX_1X
		
		; 4X
		ld	b,a
		ld	a,224
		ld	(DESX),a
		ld	a,(MAPX)
		add	a,14
		and	7Fh
		ld	(MAPX),a
		ld	a,b
SRX_LP:
		push	af
		call	DRAW_HTILE
		ld	a,(DESX)
		sub	16
		ld	(DESX),a
		ld	a,(MAPX)
		dec	a
		and	7Fh
		ld	(MAPX),a
		pop	af
		dec	a
		jr	nz,SRX_LP
SRX_1X:
		call	SETSCROLL
		call	PUT_HARD
		call	PUT_SOFT
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DESPAGE),a
		pop	hl
		ld	a,h
		inc	a
		and	7Fh
		ld	(MAPX),a
		xor	a
		ld	(DESX),a
		push	hl
		call	DRAW_HTILE
		pop	hl
		ld	a,h
		add	a,15
		and	7Fh
		ld	(MAPX),a
		ld	a,240
		ld	(DESX),a
		jp	DRAW_HTILE

; === Move right X ===
MOVE_RIGHT_X:
		ld	a,b
		ld	(CNTX),a
		ld	a,(DISPLAY_PAGE)
		ld	(DESPAGE),a
		xor	1
		ld	(SRCPAGE),a
		ld	a,l
		sub	b
		ld	l,a
		ld	(DESX),a
		ld	a,CMDHMMV
		dec	b
		jr	nz,MRX_HFILL
		ld	a,CMDLMMV
MRX_HFILL:
		ld	(CMD),a
		push	hl
		call	SETSCROLL
		call	FILL_HBAR
		pop	hl
		ld	a,l
		add	a,240
		ld	(SRCX),a
		ld	(DESX),a
		ld	a,(RAWSPEED)
		dec	a
		ld	a,CMDHMMM
		jr	nz,MRX_HCOPY
		ld	a,CMDLMMM
MRX_HCOPY:
		ld	(CMD),a
		push	hl
		call	COPY_HBAR
		call	PUT_HARD
		call	PUT_SOFT
		ld	a,(SRCPAGE)
		ld	(DESPAGE),a
		call	PDRAW_HTILE
		pop	hl
		inc	l
		ld	a,l
		cp	15
		ret	z
		inc	a
		add	a,h
		and	7Fh
		ld	(MAPX),a
		ld	a,l
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		ld	(DESX),a
		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMM
		ld	(CMD),a
		ld	a,(RAWSPEED)
MRX_LP:
		push	af
		call	DRAW_HTILE
		ld	a,(DESX)
		add	a,16
		ld	(DESX),a
		ld	a,(MAPX)
		inc	a
		and	7Fh
		ld	(MAPX),a
		pop	af
		dec	a
		jr	nz,MRX_LP
		ret

; === Scroll left X ===
SCROLL_LEFT_X:
		call	PUT_SOFT_BACK
		ld	a,(POSX)
		ld	d,a
		ld	a,(SPEED)
		ld	b,a
		ld	c,1
SLX_PRE:
		ld	a,c
		ld	(RAWSPEED),a
		sla	c
		rr	b
		jr	c,SLX_BEGIN
		rr	d
		push	de
		push	bc
		call	c,SLX_BEGIN
		pop	bc
		pop	de
		ld	a,c
		cp	16
		jr	nz,SLX_PRE
		ld	(RAWSPEED),a

SLX_BEGIN:
		ld	hl,(POSX)
		ld	a,(RAWSPEED)
		ld	c,a
		ld	b,0
		add	hl,bc
		dec	hl
		cpl
		inc	a
		and	l
		ld	l,a
		and	a
		sbc	hl,bc
		ld	a,h
		and	7
		ld	h,a
		ld	(POSX),hl
		call	FETCH_XY
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,l
		add	a,c
		cp	16
		jp	nz,MOVE_LEFT_X
		
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DISPLAY_PAGE),a
		ld	(DESPAGE),a
		xor	a
		ld	(DESX),a
		ld	(COLOR),a
		ld	a,16
		sub	c
		ld	(CNTX),a
		ld	a,CMDHMMV
		dec	c
		jr	nz,SLX_HFILL
		ld	a,CMDLMMV
SLX_HFILL:
		ld	(CMD),a
		push	hl
		ld	a,(CNTX)
		and	a
		call	nz,FILL_HBAR
		ld	a,(RAWSPEED)
		ld	(CNTX),a
		cpl
		inc	a
		ld	(DESX),a
		call	FILL_HBAR
		pop	hl

		ld	a,(RAWSPEED)
		ld	b,a
		ld	a,16
		sub	b
		ld	(DESX),a
		ld	a,CMDHMMM
		dec	b
		jr	nz,SLX_HCOPY
		ld	a,CMDLMMM
SLX_HCOPY:
		ld	(CMD),a
		push	hl
		call	PDRAW_HTILE
		ld	a,(DESX)
		ld	(CNTX),a
		and	a
		jr	z,SLX_NO_COPY
		ld	a,240
		ld	(DESX),a
		pop	hl
		ld	a,h
		add	a,15
		and	7Fh
		ld	(MAPX),a
		push	hl
		call	DRAW_HTILE
SLX_NO_COPY:
		call	SETSCROLL
		call	PUT_HARD
		call	PUT_SOFT
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DESPAGE),a
		ld	a,(CNTX)
		and	a
		jr	z,SLX_SKIP_COPY
		pop	hl
		ld	a,h
		ld	(MAPX),a
		push	hl
		call	DRAW_HTILE
SLX_SKIP_COPY:
		pop	hl
		ld	a,h
		add	a,15
		and	7Fh
		ld	(MAPX),a
		ld	a,(RAWSPEED)
		ld	(CNTX),a
		cpl
		inc	a
		ld	(DESX),a
		call	DRAW_HTILE
		
		ld	a,(RAWSPEED)
		dec	a
		ret	z
		dec	a
		ret	z
		ld	b,a
		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMM
		ld	(CMD),a
		ld	a,224
		ld	(DESX),a
		ld	a,(MAPX)
		dec	a
		dec	a
		and	7Fh
		ld	(MAPX),a
		ld	a,b
SLX_LP:
		push	af
		call	DRAW_HTILE
		ld	a,(DESX)
		sub	16
		ld	(DESX),a
		ld	a,(MAPX)
		dec	a
		and	7Fh
		ld	(MAPX),a
		pop	af
		dec	a
		jr	nz,SLX_LP
		ret

; === Move left X ===
MOVE_LEFT_X:
		ld	a,(DISPLAY_PAGE)
		ld	(DESPAGE),a
		xor	1
		ld	(SRCPAGE),a
		xor	a
		ld	(COLOR),a
		ld	a,(RAWSPEED)
		ld	(CNTX),a
		ld	b,a
		ld	a,l
		add	a,240
		ld	(DESX),a
		ld	a,CMDHMMV
		dec	b
		jr	nz,MLX_HFILL
		ld	a,CMDLMMV
MLX_HFILL:
		ld	(CMD),a
		push	hl
		call	SETSCROLL
		call	FILL_HBAR
		pop	hl
		ld	a,l
		ld	(DESX),a
		add	a,240
		ld	(SRCX),a
		ld	a,(RAWSPEED)
		dec	a
		ld	a,CMDHMMM
		jr	nz,MLX_HCOPY
		ld	a,CMDLMMM
MLX_HCOPY:
		ld	(CMD),a
		push	hl
		call	COPY_HBAR
		call	PUT_HARD
		call	PUT_SOFT
		pop	hl
		ld	a,l
		add	a,240
		ld	(DESX),a
		ld	a,(SRCPAGE)
		ld	(DESPAGE),a
		ld	a,h
		add	a,15
		and	7Fh
		ld	(MAPX),a
		push	hl
		call	PDRAW_HTILE
		pop	hl

		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMM
		ld	(CMD),a
		
		ld	a,l
		cp	14
		ret	z

		add	a,h
		and	7Fh
		ld	(MAPX),a
		ld	h,a
		ld	a,l
		inc	a
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		ld	l,a
		ld	(DESX),a
		ld	a,(RAWSPEED)
		ld	l,a
MLX_LP:
		push	hl
		call	DRAW_HTILE
		pop	hl
		ld	a,(DESX)
		add	a,16
		ld	(DESX),a
		inc	h
		ld	a,h
		ld	(MAPX),a
		dec	l
		jr	nz,MLX_LP
		ret

; === Step down ===
STEP_DOWN_X:
		; ld	a,(POSY)
		; ld	d,a
		; ld	a,(SPEED)
		; ld	b,a
		; ld	c,1
; SDX_PRE:
		; ld	a,c
		; ld	(RAWSPEED),a
		; sla	c
		; rr	b
		; jr	c,SDX_BEGIN
		; rr	d
		; push	de
		; push	bc
		; call	c,SDX_BEGIN
		; pop	bc
		; pop	de
		; ld	a,c
		; cp	16
		; jr	nz,SDX_PRE
		; ld	(RAWSPEED),a
		ld	a,(SPEED)
		ld	(RAWSPEED),a
SDX_BEGIN:
		ld	hl,(POSY)
		ld	a,(RAWSPEED)
		ld	c,a
		ld	b,0
		add	hl,bc
		cpl
		inc	a
		and	l
		ld	l,a
		ld	a,h
		and	7
		ld	h,a
		ld	(POSY),hl
		
		ld	a,(DISPLAY_PAGE)
		ld	(DESPAGE),a
		ld	a,(POSX)
		and	0Fh
		cpl
		inc	a
		ld	(DESX0),a
		xor	a
		ld	(CNTX0),a
		ld	a,(RAWSPEED)
		ld	b,a
		ld	(CNTY0),a
		ld	a,212
		sub	b
		ld	(DESY0),a
		call	DRAW_AREA
		
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DESPAGE),a
		jp	DRAW_BACK

; === Step up ===
STEP_UP:
		ld	a,(SPEED)
		ld	(RAWSPEED),a
STX_BEGIN:

		ld	hl,(POSY)
		ld	a,(RAWSPEED)
		ld	c,a
		ld	b,0
		and	a
		sbc	hl,bc
		cpl
		inc	a
		and	l
		ld	l,a
		ld	a,h
		and	7
		ld	h,a
		ld	(POSY),hl

		ld	a,(DISPLAY_PAGE)
		ld	(DESPAGE),a
		ld	a,(POSX)
		and	0Fh
		cpl
		inc	a
		ld	(DESX0),a
		xor	a
		ld	(CNTX0),a
		ld	(DESY0),a
		ld	a,(RAWSPEED)
		ld	(CNTY0),a
		call	DRAW_AREA
		
		ld	a,(DISPLAY_PAGE)
		xor	1
		ld	(DESPAGE),a
		jp	DRAW_BACK

; === Scroll up ===
SCROLL_UP:
		call	PUT_SOFT_BACK
		call	STEP_UP
		call	SETSCROLL
		call	PUT_HARD
		jp	PUT_SOFT
		
; === Scroll down ===
SCROLL_DOWN:
		call	PUT_SOFT_BACK
		call	STEP_DOWN_X
		call	SETSCROLL
		call	PUT_HARD
		jp	PUT_SOFT
		
; === Scroll up right ===
SCROLL_UPRIGHT:
		call	PUT_SOFT_BACK
		call	STEP_UP
		jp	SCROLL_RIGHT_X
		
; === Scroll down right ===
SCROLL_DOWNRIGHT:
		call	PUT_SOFT_BACK
		call	STEP_DOWN_X
		jp	SCROLL_RIGHT_X
		
; === Scroll down left ===
SCROLL_DOWNLEFT:
		call	PUT_SOFT_BACK
		call	STEP_DOWN_X
		jp	SCROLL_LEFT_X
		
; === Scroll up left ===
SCROLL_UPLEFT:
		call	PUT_SOFT_BACK
		call	STEP_UP
		jp	SCROLL_LEFT_X
		
; === Draw software sprites ===
PUT_SOFT:
		ld	a,(DISPLAY_PAGE)
		ld	(DESPAGE1),a
		
		ld	hl,SOFT_SPRITE
		ld	b,8
PSOFT_NLOOP:
		push	bc
		ld	b,(hl)
		ld	a,(POSX)
		and	0Fh
		add	a,b
		ld	(DESX1),a
		
		inc	hl
		inc	hl
		ld	b,(hl)
		ld	a,(POSY)
		add	a,b
		ld	(DESY1),a
		ld	a,16
		ld	(CNTX1),a
		ld	(CNTY1),a
		ld	a,CMDLMMC | LCMD_TIMP
		ld	(CMD1),a
		inc	hl
		ld	a,(hl)
		inc	hl
		push	hl
		and	7Fh
		ld	l,0
		scf
		rra
		rr	l
		ld	h,a
		ld	c,0FEh
		ld	a,SPR_SLOT
		di
		in	b,(c)
		out	(c),a
		ld	a,(hl)
		out	(c),b
		ei
		push	hl
		ld	e,a
		rrca
		rrca
		rrca
		rrca
		and	0Fh
		ld	(COLOR1),a

		ld	a,36
		call	VDP_INIT
		ld	hl,DESX1
		ld	c,CMDPORT
		outi
		outi
		outi
		outi

		outi
		outi
		outi
		outi

		outi
		outi
		outi
		
		pop	hl
		ld	d,255
		ld	c,0FEh
		di
		in	b,(c)
		ld	a,SPR_SLOT
		out	(c),a
PSOFT_LOOP:
		ld	a,2
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		in	a,(VDPPORT)
		rla
		ld	a,0
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		jr	nc,PSOFT_LOOP
PSOFT_LOOP2:
		ld	a,e
		bit	0,d
		jr	nz,PSOFT_ODD
		rrca
		rrca
		rrca
		rrca
PSOFT_ODD:
		and	0Fh
		out	(VDPPORT),a
		ld	a,$80 + 44
		out	(VDPPORT),a
		bit	0,d
		jr	z,PSOFT_EVEN
		inc	hl
		ld	e,(hl)
PSOFT_EVEN:
		dec	d
		jr	nz,PSOFT_LOOP
		out	(c),b
		ei
		pop	hl
		pop	bc
		dec	b
		jp	nz,PSOFT_NLOOP
		ret

; === Restore sprites background ===
PUT_SOFT_BACK:
		ld	hl,SOFT_SPRITE
		ld	b,8
PSBACK_LOOP:
		push	bc
		ld	c,16
		ld	a,(hl)
		bit	0,a
		jr	z,PSBACK_EVEN
		and	$FE
		inc	c
		inc	c
PSBACK_EVEN:
		ld	(DESX0),a
		inc	hl
		inc	hl
		ld	a,(hl)
		inc	hl
		inc	hl
		push	hl
		ld	(DESY0),a
		ld	a,c
		ld	(CNTX0),a
		ld	a,16
		ld	(CNTY0),a
		ld	a,(DISPLAY_PAGE)
		ld	(DESPAGE),a
		call	DRAW_AREA
		pop	hl
		pop	bc
		dec	b
		jr	nz,PSBACK_LOOP
		ret

; === Sprite Walk ===
SPRWALK:
		ld	hl,SPRITE_TABLE + 2
		ld	b,32
SPRWALK_LP:
		ld	a,(hl)
		xor	2
		ld	(hl),a
		inc	hl
		inc	hl
		inc	hl
		inc	hl
		djnz	SPRWALK_LP
		ret

; === Read MAP at 0000h ===
; input: H = MAPY, L = MAPX
; return: A = Data
; changed: B = Port(0FEh), C = 0FEh, HL = Address
GET_MAP:
		ld	a,h
		rl	l
		rra
		rr	l
		and	3Fh
		or	80h
		ld	h,a
		ld	c,0FEh
		di
		in	b,(c)
		ld	a,MAP_SLOT
		out	(c),a
		ld	a,(hl)
		out	(c),b
		ei
		ret

; === Store/Restore TILE/SPRITE with RAM mapper ===
; A: (PAGE * 2) or (0 = Y0 / 1 = Y128), B: RAM page (0-7)
TILE_RESTORE:
		ld	c,$40
		jr	TILE_MAPPER
TILE_STORE:
		ld	c,0
TILE_MAPPER:
		and	7
		di
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,0
		out	(VDPPORT),a
		ld	a,c
		out	(VDPPORT),a
		and	a
		ex	af,af'
		ld	c,0FEh
		ld	a,b
		in	b,(c)
		out	(c),a
		ld	hl,8000h
		ld	de,0000h	; d = col block offset, e = line offset
		ld	c,0		; c = row block offset
TILES_LOOP:
		ex	af,af'
		jr	nz,TILES_RES
		in	a,(VRAMPORT)
		ld	(hl),a
		jr	TILES_GO
TILES_RES:
		ld	a,(hl)
		out	(VRAMPORT),a
TILES_GO:
		ex	af,af'
		inc	hl
		ld	a,l
		and	7
		jr	nz,TILES_LOOP
		ld	a,d
		inc	a
		cp	16
		jr	z,TILES_NEXT_LINE
		ld	d,a
		ld	a,l
		add	a,120
		ld	l,a
		jr	nc,TILES_LOOP
		inc	h
		jr	TILES_LOOP
TILES_NEXT_LINE:
		ld	d,0
		ld	a,e
		inc	a
		cp	16
		jr	z,TILES_NEXT_ROW
		ld	e,a
		rlca
		rlca
		rlca
		ld	l,a
		ld	a,c
		rlca
		rlca
		rlca
		or	$80
		ld	h,a
		jr	TILES_LOOP
TILES_NEXT_ROW:
		ld	e,0
		ld	a,c
		inc	a
		cp	8
		jr	z,TILES_END
		ld	c,a
		rlca
		rlca
		rlca
		or	$80
		ld	h,a
		ld	l,0
		jr	TILES_LOOP
TILES_END:
		ld	c,0FEh
		out	(c),b
		ei
		ret

; === Store data to RAM mapper ===
; A: (PAGE * 2) or (0 = Y0 / 1 = Y128), B: RAM page (0-7)
RAM_STORE:
		and	7
		di
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,0
		out	(VDPPORT),a
		ld	a,0
		out	(VDPPORT),a
		ld	c,0FEh
		ld	a,b
		in	b,(c)
		out	(c),a
		ld	hl,8000h
		ld	de,4000h
RAMS_LOOP:
		in	a,(VRAMPORT)
		ld	(hl),a
		inc	hl
		dec	de
		ld	a,d
		or	e
		jr	nz,RAMS_LOOP
		out	(c),b
		ei
		ret

; === Restore data from RAM mapper ===
; A: (PAGE * 2) or (0 = Y0 / 1 = Y128), B: RAM page (0-7)
RAM_RESTORE:
		and	7
		di
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,0
		out	(VDPPORT),a
		ld	a,40h
		out	(VDPPORT),a
		ld	c,0FEh
		ld	a,b
		in	b,(c)
		out	(c),a
		ld	hl,8000h
		ld	de,4000h
RAMR_LOOP:
		ld	a,(hl)
		out	(VRAMPORT),a
		inc	hl
		dec	de
		ld	a,d
		or	e
		jr	nz,RAMR_LOOP
		out	(c),b
		ei
		ret

; === Map store to RAM 0000h ===
MAP_STORE:
		ld	a,MAP_PAGE * 2
		ld	b,MAP_SLOT
		call	z,RAM_STORE
		
		ld	a,MAP_PAGE * 2 | 1
		ld	b,SPR_SLOT
		call	TILE_STORE
		
		ret

; === Map restore from RAM 0000h ===
MAP_RESTORE:
		ld	a,MAP_PAGE * 2
		ld	b,MAP_SLOT
		call	z,RAM_RESTORE
		
		ld	a,MAP_PAGE * 2 | 1
		ld	b,SPR_SLOT
		call	TILE_RESTORE

		ret
		
; === TEST ROUTINE ===
TESTAREA:
		jp	PUT_SOFT

; === Initialize USR routines ===
ADDRUSR0	equ	INIT
ADDRUSR1	equ	SCROLL
ADDRUSR2	equ	SETVPAGE
ADDRUSR3	equ	SPRWALK
ADDRUSR4	equ	TESTAREA
ADDRUSR5	equ	MAP_STORE
ADDRUSR6	equ	MAP_RESTORE
ADDRUSR7	equ	PUT_SOFT_BACK
ADDRUSR8	equ	NOSCROLL
ADDRUSR9	equ	NOSCROLL

PROGRUN:
		ld	hl,ADDRUSR0
		ld	(MMUSRTAB + 0),hl
		ld	hl,ADDRUSR1
		ld	(MMUSRTAB + 2),hl
		ld	hl,ADDRUSR2
		ld	(MMUSRTAB + 4),hl
		ld	hl,ADDRUSR3
		ld	(MMUSRTAB + 6),hl
		ld	hl,ADDRUSR4
		ld	(MMUSRTAB + 8),hl
		ld	hl,ADDRUSR5
		ld	(MMUSRTAB + 10),hl
		ld	hl,ADDRUSR6
		ld	(MMUSRTAB + 12),hl
		ld	hl,ADDRUSR7
		ld	(MMUSRTAB + 14),hl
		ld	hl,ADDRUSR8
		ld	(MMUSRTAB + 16),hl
		ld	hl,ADDRUSR9
		ld	(MMUSRTAB + 18),hl
		ret
		
PROGEND:
