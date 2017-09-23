; Byte References

VALTYPINT	equ	2
VALTYPSTR	equ	3
VALTYPSNG	equ	4
VALTYPDBL	equ	5

CMDSTOP		equ	00h	; Stop
CMDINVALID1	equ	10h	; Not used
CMDINVALID2	equ	20h	; Not used
CMDINVALID3	equ	30h	; Not used
CMDPOINT	equ	40h	; Point
CMDPSET		equ	50h	; Pset
CMDSEARCH	equ	60h	; Search
CMDLINE		equ	70h	; Line
CMDLMMV		equ	80h	; Low speed fill
CMDLMMM		equ	90h	; Low speed copy
CMDLMCM		equ	0A0h	; Low speed getpixels
CMDLMMC		equ	0B0h	; Low speed setpixels
CMDHMMV		equ	0C0h	; High speed fill
CMDHMMM		equ	0D0h	; High speed copy
CMDYMMM		equ	0E0h	; High speed copy y-direction
CMDHMMC		equ	0F0h	; High speed setpixels

VRAMPORT	equ	98h	; V9938 VRAM port
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

MMUSRTAB	equ	0F39Ah
MMRG2SAV	equ	0F3E1h
MMVALTYP	equ	0F663h
MMUSRINT	equ	0F7F8h
MMDPPAGE	equ	0FAF5h
MMRG18SAV	equ	0FFF1h
MMRG23SAV	equ	0FFF6h
SCR5ATTR	equ	7600h

MSXERROR	equ	406Fh	; MSX BASIC ERROR HANDLER ROUTINE

; Routine constant

TILE_PAGE	equ	0
MAP_PAGE	equ	1
START_PAGE	equ	2

; === BSAVE header (7 Bytes) ===

PROGSTART	equ	0C000h

		ORG	PROGSTART - 7

		db	0FEh
		dw	PROGSTART
		dw	PROGEND - 1
		dw	PROGRUN
	
; === Begin ===

POSX:		dw	0000		;C000
POSY:		dw	0000		;C002
POSYH		equ	POSY + 1

MAPX:		db	00		;C004
MAPY:		db	00		;C005
PATX:		db	00		;C006
PATY:		db	00		;C007
MPAGE:		db	START_PAGE	;C008
		db	00, 00, 00	;C009-C00B
OPOSX:		dw	0000		;C00C
OPOSY:		dw	0000		;C00E

SRCX:		dw	0000		;C010
SRCY:		db	00		;C012
SPAGE:		db	00		;C013
DESX:		dw	0000		;C014
DESY:		db	00		;C016
DPAGE:		db	00		;C017
CNTX:		dw	0000		;C018
CNTXH:		equ	CNTX + 1
CNTY:		dw	0000		;C01A
CNTYH		equ	CNTY + 1
COLOR:		db	00		;C01C
PARAM:		db	00		;C01D
CMD:		db	00, 00		;C01E

; 32 hardware sprites location = db Y, X, N, C
SPRTABLE:	db	240, 0, 0, 0	;C020
		db	240, 0, 1 0
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

; === Execute V9938 command ===
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
		
; === Clear back page ===
CLRBKPAGE:
		xor	a
		ld	(DESX),a
		ld	(DESY),a
		ld	(COLOR),a
		ld	(CNTX),a
		ld	(CNTY),a
		inc	a
		ld	(CNTXH),a
		ld	(CNTYH),a
		ld	a,(MPAGE)
		xor	1
		ld	(DPAGE),a
		ld	a,CMDHMMV
		ld	(CMD),a
		ld	hl,DESX
		ld	b,11
		ld	a,24h
		call	VDPEXEC
		xor	a
		ld	(CNTXH),a
		ld	(CNTYH),a
		ret

; === Fetch POSX, POSY to MAPX, MAPY, PATX, PATY ===
; Return H = MAPX, L = PATX, D = MAPY, E = PATY
FETCHXY:
		ld	hl,(POSY)
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
		ld	d,a
		ld	(MAPY),a
		ld	a,l
		and	0Fh
		ld	e,a
		ld	(PATY),a
		ld	(DESY),a
		ld	hl,(POSX)
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
		ld	(DESX),a
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
		ld	a,(MPAGE)
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

; Put 32 hardware sprites
PUTHARD:
		exx
		;push	bc
		;push	de
		;push	hl
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
		ld	hl,SPRTABLE
LOOP_PUTHARD:
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
		jr	nz,LOOP_PUTHARD
		ei
		exx
		;pop	hl
		;pop	de
		;pop	bc
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
		
; === Draw horizontal tile blocks ===
DRAWHTILE:
		ld	a,212
		ex	af,af'
		ld	a,(DESX)
		and	0Fh
		ld	b,a
		ld	a,(POSY)
		ld	e,a
		and	0Fh
		ld	c,a
		ld	a,16
		sub	c
		ld	d,a
		ld	(CNTY),a
		ld	hl,(MAPX)
DHTLOOP1:
		push	hl
		rl	l
		and	a
		rr	h
		rr	l
		ld	a,h
		rlca
		rlca
		and	1		
		or	MAP_PAGE * 2
		di
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,l
		out	(VDPPORT),a
		ld	a,h
		and	3Fh
		out	(VDPPORT),a
		ei
		in	a,(VRAMPORT)
		ld	l,a
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		add	a,b
		ld	(SRCX),a
		ld	a,l
		and	0F0h
		add	a,c
		ld	(SRCY),a
		ld	a,e
		ld	(DESY),a
		push	bc
		ld	b,0Fh
		ld	hl,SRCX
		ld	a,20h
		call	VDPEXEC
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
		jr	nc,DHTNO1
		ld	d,a
DHTNO1:
		ex	af,af'
		ld	a,d
		ld	(CNTY),a
		ld	a,h
		inc	a
		and	7Fh
		ld	h,a
		xor	a
		ld	c,a
		jr	DHTLOOP1

; === Fill horizontal tile block with color #0 ===
FILLHTILE:
		ld	hl,(MAPX)
		ex	de,hl
		ld	c,e
		ld	b,CMDHMMV
		ld	a,(DESY)
		ld	d,a
		ld	a,(CNTY)
		ld	e,a
		ld	a,16
		sub	b
		cp	e
		jr	nc,FHTLOOP1
		ld	a,e
FHTLOOP1:
		ld	(CNTY),a
		ex	af,af'
		ld	a,d
		ld	(DESY),a
		push	hl
		rl	l
		and	a
		rr	h
		rr	l
		ld	a,h
		rlca
		rlca
		and	1
		or	MAP_PAGE * 2
		di
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,l
		out	(VDPPORT),a
		ld	a,h
		and	3Fh
		out	(VDPPORT),a
		ei
		in	a,(VRAMPORT)
		ld	l,a
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		add	a,c
		ld	(SRCX),a
		ld	a,l
		and	0F0h
		add	a,b
		ld	(SRCY),a
		push	bc
		ld	a,20h
		ld	b,15
		ld	hl,SRCX
		call	VDPEXEC
		ex	af,af'
		ld	b,a
		adc	a,d
		ld	d,a
		ld	a,e
		sub	b
		ld	e,a
		ld	a,b
		pop	bc
		pop	hl
		ret	z
		ret	c
		ld	a,h
		inc	a
		and	7Fh
		ld	h,a
		xor	a
		ld	b,a
		ld	a,16
		cp	e
		jr	nc,FHTNO1
		ld	a,e
FHTNO1:
		jr	FHTLOOP1

; === Draw vertical tile blocks ===
DRAWVTILE:
		ld	a,CMDLMMM
		ld	(CMD),a
		ld	a,TILE_PAGE
		ld	(SPAGE),a
		ld	a,240
		ld	(CNTX),a
		ex	af,af'
		ld	a,(DESY)
		and	0Fh
		ld	c,a
		ld	a,(DESX)
		and	0Fh
		ld	b,a
		ld	e,a
		ld	a,16
		sub	e
		ld	d,a
		ld	(CNTX),a
		ld	hl,(MAPX)
DVTLOOP1:
		push	hl
		rl	l
		and	a
		rr	h
		rr	l
		ld	a,h
		rlca
		rlca
		and	1
		or	MAP_PAGE * 2
		di
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,l
		out	(VDPPORT),a
		ld	a,h
		and	3Fh
		out	(VDPPORT),a
		ei
		in	a,(VRAMPORT)
		ld	l,a
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		add	a,b
		ld	(SRCX),a
		ld	a,l
		and	0F0h
		add	a,c
		ld	(SRCY),a
		push	bc
		ld	hl,SRCX
		ld	b,15
		ld	a,20h
		call	VDPEXEC
		pop	bc
		ld	a,e
		add	a,d
		ld	e,a
		ld	(DESX),a
		ex	af,af'
		sub	d
		pop	hl
		ret	z
		ret	c
		ld	d,16
		cp	d
		jr	nc,DVTNO1
		ld	d,a
		ex	af,af'
		ld	a,CMDLMMM
		jr	DVTNO2
DVTNO1:
		ex	af,af'
		ld	a,CMDHMMM
DVTNO2:
		ld	(CMD),a
		ld	a,d
		ld	(CNTX),a
		ld	a,l
		inc	a
		and	7Fh
		ld	l,a
		xor	a
		ld	b,a
		jr	DVTLOOP1

; === Draw tile blocks to specified area ===
DRAWAREA:
		ld	a,(CNTX)
		ld	b,a
		ld	hl,(POSX)
		ld	a,(DESX)
		add	a,l
		jr	nc,DANO1
		inc	h
DANO1:
		and	a
		rra
		jr	nc,DANO2
		inc	b
DANO2:
		rlca
		ld	l,a
		and	0Fh
		ld	(PATX),a
		ld	a,l
		rrca
		rrca
		rrca
		rrca
		and	0Fh
		ld	l,a
		ld	a,h
		rlca
		rlca
		rlca
		rlca
		and	70h
		or	l
		ld	(MAPX),a
		ld	a,b
		inc	a
		and	0FEh
		ld	(CNTX),a
		ld	hl,(POSY)
		ld	a,(DESY)
		add	a,l
		jr	nc,DANO3
		inc	h
DANO3:
		ld	l,a
		and	0Fh
		ld	(PATY),a
		ld	a,l
		rrca
		rrca
		rrca
		rrca
		and	0Fh
		ld	l,a
		ld	a,h
		rlca
		rlca
		rlca
		rlca
		and	70h
		or	l
		ld	(MAPY),a
		ld	bc,(PATX)
		ld	hl,(MAPX)
		ld	a,(CNTX)
		ld	d,a
		ld	a,16
		sub	c
		cp	d
		jr	nc,DANO4
		ld	a,d
DANO4:
		ld	(CNTX),a
		ld	a,d
		push	af
;		ld	a,()



; === USR0 - Draw Initialize screen ===
INIT:
		call	CLRBKPAGE
		call	FETCHXY
		ld	a,(MPAGE)
		xor	1
		ld	(MPAGE),a
		ld	(DPAGE),a
		ld	a,TILE_PAGE
		ld	(SPAGE),a
		ld	a,16
		sub	l
		ld	(CNTX),a
		ld	a,CMDLMMM
		ld	(CMD),a
		ld	a,0F0h
INITLOOP1:
		push	af
		ld	a,(POSY)
		ld	(DESY),a
		call	DRAWHTILE
		ld	a,(CNTX)
		ld	l,a
		ld	a,(DESX)
		add	a,l
		ld	(DESX),a
		ld	a,(MAPX)
		inc	a
		and	7Fh
		ld	(MAPX),a
		pop	af
		sub	l
		jr	z,INITEND1
		jr	c,INITEND1
		ld	b,a
		ld	c,16
		cp	c
		jr	nc,INITNO1
		ld	c,a
INITNO1:
		ld	a,c
		ld	(CNTX),a
		ld	a,b
		jr	INITLOOP1
INITEND1:
		call	SETSCROLL
		jp	MKBKPAGE

; === Fill horizontal block with color ===
FILLHBAR:
		ld	a,(POSY)
		ld	(DESY),a
		ld	l,a
		ld	a,212
		ld	(CNTY),a
		dec	a
		add	a,l
		jr	nc,FHBNO1
		inc	a
		ex	af,af'
		xor	a
		sub	l
		ld	(CNTY),a
		ld	hl,DESX
		ld	b,11
		ld	a,24h
		call	VDPEXEC
		ex	af,af'
		ld	(CNTY),a
		xor	a
		ld	(DESY),a
FHBNO1:
		ld	hl,DESX
		ld	b,11
		ld	a,24h
		jp	VDPEXEC

; === Make back page ===
MKBKPAGE:
		call	CLRBKPAGE
		call	FETCHXY
		ld	a,(MPAGE)
		xor	1
		ld	(DPAGE),a
		ld	a,CMDHMMM
		ld	(CMD),a
		ld	a,16
		ld	(CNTX),a
		ld	a,l
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		ld	c,a
		xor	a
		ld	b,a
MBPLOOP1:
		inc	h
		ld	a,b
		cp	c
		jr	nz,MBPNO1
		dec	h
		dec	h
MBPNO1:
		ld	(DESX),a
		ld	a,h
		and	7Fh
		ld	h,a
		ld	(MAPX),a
		ld	a,d
		ld	(MAPY),a
		ld	a,(POSY)
		ld	(DESY),a
		exx
		call	DRAWHTILE
		exx
		ld	a,b
		add	a,16
		ret	c
		ld	b,a
		jr	MBPLOOP1

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
		ld	hl,(POSX)
		ld	(OPOSX),hl
		ld	hl,(POSY)
		ld	(OPOSY),hl
		ld	a,(de)
		ld	l,a
		inc	de
		ld	a,(de)
		ld	h,a
		jp	(hl)

SCROLLSUB:
		dw	NOSCROLL
		dw	SCROLL_UP
		dw	SCROLL_UPRIGHT
		dw	SCROLL_RIGHT
		dw	SCROLL_DOWNRIGHT
		dw	SCROLL_DOWN
		dw	SCROLL_DOWNLEFT
		dw	SCROLL_LEFT
		dw	SCROLL_UPLEFT

NOSCROLL:
		ret

; === Draw line to back page ===
DRAWBKLINE:
		ld	a,TILE_PAGE
		ld	(SPAGE),a
		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMM
		ld	(CMD),a
		xor	a
		ld	d,a
		ld	a,(POSX)
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		ld	e,a
		ld	a,(DESY)
		and	0Fh
		ld	c,a
		ld	hl,(MAPX)
DBLLOOP1:
		inc	l
		ld	a,d
		cp	e
		jr	nz,DBLNO1
		dec	l
		dec	l
DBLNO1:
		ld	a,l
		and	7Fh
		ld	l,a
		push	hl
		rl	l
		and	a
		rr	h
		rr	l
		ld	a,h
		rlca
		rlca
		and	1
		or	MAP_PAGE * 2
		di
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,l
		out	(VDPPORT),a
		ld	a,h
		and	3Fh
		out	(VDPPORT),a
		ei
		in	a,(VRAMPORT)
		ld	l,a
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		ld	(SRCX),a
		ld	a,l
		and	0F0h
		add	a,c
		ld	(SRCY),a
		ld	a,d
		ld	(DESX),a
		ld	hl,SRCX
		ld	b,15
		ld	a,20h
		push	bc
		call	VDPEXEC
		pop	bc
		pop	hl
		ld	a,d
		add	a,16
		ret	c
		ld	d,a
		jr	DBLLOOP1

; === Scroll right ===
SCROLL_RIGHT:
		ld	hl,(POSX)
		inc	hl
		ld	a,h
		and	7
		ld	h,a
		ld	(POSX),hl
		call	FETCHXY
		xor	a
		ld	(COLOR),a
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,l
		and	a
		jp	nz,MOVE_RIGHT
		ld	a,(MPAGE)
		xor	1
		ld	(MPAGE),a
		ld	(DPAGE),a
		ld	a,0F0h
		ld	(DESX),a
		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMV
		ld	(CMD),a
		push	hl
		call	FILLHBAR
		call	SETSCROLL
		pop	hl
		xor	a
		ld	(DESX),a
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,(MPAGE)
		xor	1
		ld	(DPAGE),a
		ld	a,h
		dec	a
		and	7Fh
		ld	(MAPX),a
		ld	a,d
		ld	(MAPY),a
		ld	a,TILE_PAGE
		ld	(SPAGE),a
		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMM
		ld	(CMD),a
		push	hl
		push	de
		call	DRAWHTILE
		pop	de
		pop	hl
		ld	a,1
		ld	(CNTX),a
		ld	a,255
		ld	(DESX),a
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,h
		add	a,14
		and	7Fh
		ld	(MAPX),a
		ld	a,d
		ld	(MAPY),a
		ld	a,CMDLMMM
		ld	(CMD),a
		jp	DRAWHTILE

; === Move right ===
MOVE_RIGHT:
		call	SETSCROLL
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,l
		dec	a
		ld	l,a
		ld	(DESX),a
		xor	a
		ld	(COLOR),a
		inc	a
		ld	(CNTX),a
		ld	a,(MPAGE)
		ld	(DPAGE),a
		ld	a,CMDLMMV
		ld	(CMD),a
		push	hl
		call	FILLHBAR
		pop	hl
		ld	a,l
		add	a,240
		ld	(DESX),a
		ld	a,TILE_PAGE
		ld	(SPAGE),a
		ld	a,(MPAGE)
		ld	(DPAGE),a
		ld	a,CMDLMMM
		ld	(CMD),a
		ld	a,h
		add	a,15
		and	7Fh
		ld	(MAPX),a
		ld	a,d
		ld	(MAPY),a
		push	hl
		push	de
		call	DRAWHTILE
		pop	de
		pop	hl
		ld	a,h
		add	a,l
		inc	a
		and	7Fh
		ld	(MAPX),a
		ld	a,d
		ld	(MAPY),a
		ld	a,l
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		ld	(DESX),a
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,(MPAGE)
		xor	1
		ld	(DPAGE),a
		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMM
		ld	(CMD),a
		jp	DRAWHTILE

; === Scroll left ===
SCROLL_LEFT:
		ld	hl,(POSX)
		dec	hl
		ld	a,h
		and	7
		ld	h,a
		ld	(POSX),hl
		call	FETCHXY
		ld	a,l
		cp	15
		jp	nz,MOVE_LEFT
		ld	a,(MPAGE)
		xor	1
		ld	(MPAGE),a
		ld	(DPAGE),a
		ld	a,255
		ld	(DESX),a
		inc	a
		ld	(COLOR),a
		inc	a
		ld	(CNTX),a
		ld	a,CMDLMMV
		ld	(CMD),a
		push	hl
		call	FILLHBAR
		xor	a
		ld	(DESX),a
		ld	a,15
		ld	(CNTX),a
		call	FILLHBAR
		call	SETSCROLL
		pop	hl
		ld	a,(MPAGE)
		xor	1
		ld	(DPAGE),a
		ld	a,TILE_PAGE
		ld	(SPAGE),a
		ld	a,240
		ld	(DESX),a
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,h
		add	a,14
		and	7Fh
		ld	(MAPX),a
		ld	a,d
		ld	(MAPY),a
		ld	a,16
		ld	(CNTX),a
		ld	a,CMDHMMM
		ld	(CMD),a
		jp	DRAWHTILE

; === Move left ===
MOVE_LEFT:
		call	SETSCROLL
		ld	a,(MPAGE)
		ld	(DPAGE),a
		ld	a,l
		add	a,240
		ld	(DESX),a
		ld	a,(POSY)
		ld	(DESY),a
		xor	a
		ld	(COLOR),a
		inc	a
		ld	(CNTX),a
		ld	a,CMDLMMV
		ld	(CMD),a
		push	hl
		call	FILLHBAR
		pop	hl
		ld	a,l
		ld	(DESX),a
		ld	a,TILE_PAGE
		ld	(SPAGE),a
		ld	a,h
		ld	(MAPX),a
		ld	a,d
		ld	(MAPY),a
		ld	a,CMDLMMM
		ld	(CMD),a
		push	hl
		push	de
		call	DRAWHTILE
		pop	de
		pop	hl
		ld	a,(MPAGE)
		xor	1
		ld	(DPAGE),a
		ld	a,l
		rlca
		rlca
		rlca
		rlca
		and	0F0h
		ld	(DESX),a
		ld	a,16
		ld	(CNTX),a
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,h
		add	a,l
		dec	a
		and	7Fh
		ld	(MAPX),a
		ld	a,d
		ld	(MAPY),a
		ld	a,CMDHMMM
		ld	(CMD),a
		jp	DRAWHTILE

; === Step down ===
STEP_DOWN:
		ld	hl,(POSY)
		inc	hl
		ld	a,h
		and	7
		ld	h,a
		ld	(POSY),hl
		call	FETCHXY
		xor	a
		ld	(DESX),a
		ld	(CNTX),a
		ld	(COLOR),a
		inc	a
		ld	(CNTY),a
		ld	a,(POSY)
		add	a,211
		ld	(DESY),a
		ld	a,(MPAGE)
		ld	(DPAGE),a
		ld	a,CMDHMMV
		ld	(CMD),a
		push	hl
		ld	hl,DESX
		ld	b,11
		ld	a,24h
		call	VDPEXEC
		pop	hl
		ld	a,l
		ld	(DESX),a
		ld	a,(POSY)
		add	a,211
		ld	e,a
		ld	a,(POSYH)
		jr	nc,STDNO1
		inc	a
STDNO1:
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
		ld	(MAPY),a
		exx
		call	DRAWVTILE
		exx
		ld	a,(MPAGE)
		xor	1
		ld	(DPAGE),a
		jp	DRAWBKLINE

; === Step up ===
STEP_UP:
		ld	hl,(POSY)
		dec	hl
		ld	a,h
		and	7
		ld	h,a
		ld	(POSY),hl
		call	FETCHXY
		xor	a
		ld	(DESX),a
		ld	(CNTX),a
		ld	(COLOR),a
		inc	a
		ld	(CNTY),a
		ld	a,(POSY)
		ld	(DESY),a
		ld	a,(MPAGE)
		ld	(DPAGE),a
		ld	a,CMDHMMV
		ld	(CMD),a
		push	hl
		ld	hl,DESX
		ld	b,11
		ld	a,24H
		call	VDPEXEC
		pop	hl
		ld	a,l
		ld	(DESX),a
		exx
		call	DRAWVTILE
		exx
		ld	a,(MPAGE)
		xor	1
		ld	(DPAGE),a
		jp	DRAWBKLINE

; === Scroll up ===
SCROLL_UP:
		call	STEP_UP
		jp	SETSCROLL
		
; === Scroll down ===
SCROLL_DOWN:
		call	STEP_DOWN
		jp	SETSCROLL
		
; === Scroll up right ===
SCROLL_UPRIGHT:
		call	STEP_UP
		jp	SCROLL_RIGHT
		
; === Scroll down right ===
SCROLL_DOWNRIGHT:
		call	STEP_DOWN
		jp	SCROLL_RIGHT
		
; === Scroll down left ===
SCROLL_DOWNLEFT:
		call	STEP_DOWN
		jp	SCROLL_LEFT
		
; === Scroll up left ===
SCROLL_UPLEFT:
		call	STEP_UP
		jp	SCROLL_LEFT
		
; === V9938 Temp CMD buffer ===
SRCX1:		dw	0000		;CD30
SRCY1:		db	00		;CD32
SPAGE1:		db	00		;CD33
DESX1:		dw	0000		;CD34
DESY1:		db	00		;CD36
DPAGE1:		db	00		;CD37
CNTX1:		dw	0000		;CD38
CNTY1:		dw	0000		;CD3A
COLOR1:		db	00		;CD3C
PARAM1:		db	00		;CD3D
CMD1:		db	00		;CD3E

; === Restore background ===
RESTOREBG:
		ld	a,(OPOSX)
		and	0Fh
		add	a,100
		ld	(DESX1),a
		ld	a,(OPOSY)
		add	a,100
		ld	(DESY1),a
		ld	a,32
		ld	(CNTX1),a
		ld	(CNTY1),a
		ld	a,(MPAGE)
		ld	(DPAGE1),a
		xor	a
		ld	(SRCX1),a
		ld	a,128
		ld	(SRCY1),a
		ld	a,MAP_PAGE
		ld	(SPAGE1),a
		ld	a,CMDLMMM
		ld	(CMD1),a
		push	hl
		push	bc
		ld	hl,SRCX1
		ld	b,15
		ld	a,20h
		call	VDPEXEC
		pop	bc
		pop	hl
		ret

; === Put software sprites ===
PUTSOFT:
		ld	a,(POSX)
		and	0Fh
		add	a,100
		ld	(DESX1),a
		ld	a,(POSY)
		add	a,100
		ld	(DESY1),a
		ld	a,20H
		ld	(CNTX1),a
		ld	(CNTY1),a
		ld	a,(MPAGE)
		ld	(DPAGE1),a
		ld	a,128
		ld	(SRCX1),a
		ld	(SRCY1),a
		ld	a,TILE_PAGE
		ld	(SPAGE1),a
		ld	a,CMDLMMM
		ld	(CMD1),a
		ld	hl,SRCX1
		ld	b,15
		ld	a,20h
		jp	VDPEXEC

; === Draw sprite ===
DRAWSPRITE:
		call	RESTOREBG
		jp	PUTSOFT

; === Initialize USR routines ===
ADDRUSR0	equ	INIT
ADDRUSR1	equ	SCROLL
ADDRUSR2	equ	SETVPAGE

PROGRUN:
		ld	hl,ADDRUSR0
		ld	(MMUSRTAB),hl
		ld	hl,ADDRUSR1
		ld	(MMUSRTAB + 2),hl
		ld	hl,ADDRUSR2
		ld	(MMUSRTAB + 4),hl
		ret
		
PROGEND:
