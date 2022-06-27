; === Select Primary + Secondary slot to RAM and set VRAM address
; input: A:0 = 0000h, A:1 = 4000h, B:0 = read VRAM, B:1 = write VRAM)
; return: B = old primary slot, C = old secondary slot, D = A (0 or 1)
; changed: A, E
SLOT_VRAM:
		and	1
		ld	d,a
		or	MAP_PAGE * 2
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,0
		out	(VDPPORT),a
		ld	a,b
		and	1
		rrca
		rrca
		out	(VDPPORT),a
		jr	SLOT_SEL
SLOT_RAM:
		and	1
		ld	d,a
SLOT_SEL:
		in	a,(0A8h)
		ld	b,a
		ld	a,(0FFFFh)
		cpl
		ld	c,a

		ld	a,0FCh
		bit	0,d
		jr	z,SRAM_AND_PRI
		ld	a,0F3h
SRAM_AND_PRI:
		and	b
		ld	e,a
		ld	a,b
		rlca
		rlca
		and	3
		bit	0,d
		jr	z,SRAM_SHIFT_PRI
		rlca
		rlca
SRAM_SHIFT_PRI:
		or	e
		out	(0A8h),a
		
		ld	a,0FCh
		bit	0,d
		jr	z,SRAM_AND_SEC
		ld	a,0F3h
SRAM_AND_SEC:
		and	c
		ld	e,a
		ld	a,c
		rlca
		rlca
		and	3
		bit	0,d
		jr	z,SRAM_SHIFT_SEC
		rlca
		rlca
SRAM_SHIFT_SEC:
		or	e
		ld	(0FFFFh),a
		ret
		
; === Store MAP_PAGE to RAM A:0 = 0000h, A:1 = 4000h ===
SLOT_STORE:
		di
		ld	b,0
		call	SLOT_VRAM
		rrc	d
		rrc	d
		ld	e,0
		ld	hl,4000h
SS_LOOP:
		in	a,(VRAMPORT)
		ld	(de),a
		inc	de
		dec	hl
		ld	a,h
		or	l
		jr	nz,SS_LOOP

		ld	a,b
		out	(0A8h),a
		ld	a,c
		ld	(0FFFFh),a
		ei
		ret

; === Restore MAP_PAGE from RAM A:0 = 0000h, A:1 = 4000h ===
SLOT_RESTORE:
		di
		ld	b,1
		call	SLOT_VRAM
		rrc	d
		rrc	d
		ld	e,0
		ld	hl,4000h
SR_LOOP:
		ld	a,(de)
		out	(VRAMPORT),a
		inc	de
		dec	hl
		ld	a,h
		or	l
		jr	nz,SR_LOOP

		ld	a,b
		out	(0A8h),a
		ld	a,c
		ld	(0FFFFh),a
		ei
		ret

; === Draw software sprites ===
PUT_SOFT:
		ld	a,(DISPLAY_PAGE)
		ld	(DESPAGE1),a
		
		ld	hl,SOFT_SPRITE
		ld	b,32
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
		ld	a,CMDHMMC | LCMD_TIMP
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
		inc	hl
		push	hl
		; ld	e,a
		; rrca
		; rrca
		; rrca
		; rrca
		; and	0Fh
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
		ld	d,127
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
		; ld	a,e
		; bit	0,d
		; jr	nz,PSOFT_ODD
		; rrca
		; rrca
		; rrca
		; rrca
PSOFT_ODD:
		; and	0Fh
		ld	a,(hl)
		inc	hl
		out	(VDPPORT),a
		ld	a,$80 + 44
		out	(VDPPORT),a
		bit	0,d
		jr	z,PSOFT_EVEN
		; inc	hl
		; ld	e,(hl)
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

; === Draw horizontal tile area ===
PPUT_HTILE:
PUT_HTILE:	; DESX, CNTX, MAPX, MAPY
		ld	a,(POSY)
		ld	e,a			; E = DESY
		ld	hl,(MAPX)		; H = MAPY, L = MAPX
		ld	a,212		; A = CNTY
		jr	PHA_TILE
PUT_HAREA:	; DESX, DESY0, CNTX, CNTY0, MAPX, POSY
		ld	a,(DESY0)
		ld	e,a
		ld	d,0
		ld	hl,(POSY)
		add	hl,de
		ld	e,l			; E = DESY
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
		ld	h,a			; H = MAPY
		ld	a,(MAPX)
		ld	l,a			; L = MAPX
		ld	a,(CNTY0)		; A = CNTY
PHA_TILE:
		ld	(CNTY1),a
		ld	c,a
		ld	a,e
		ld	(DESY1),a
		and	0Fh
		ld	e,a
		ld	a,(DESX)
		rra
		and	7
		ld	d,a
		call	GET_VMAP
		ld	a,(CNTX)
		ld	b,a			; B = pixel count
		ld	a,(DESX)
		and	a
		rra
		jr	nc,PHA_X_EVEN
		inc	b
PHA_X_EVEN:
		and	a
		rla
		ld	(DESX1),a
		bit	0,b
		jr	z,PHA_NX_EVEN
		inc	b
PHA_NX_EVEN:
		ld	a,b
		ld	(CNTX1),a
		and	a
		rra
		ld	b,a			;b = x byte count
		ex	af,af'
		
		di
		call	SET_TILE_SLOT
		push	hl
		push	de
		
		ld	hl,1
		ld	(TESTDATA),hl
		
		ld	hl,MAP_BUFFER
		ld	c,(hl)
		inc	hl
		ld	e,(hl)
		inc	hl
		ld	d,(hl)
		inc	hl
		ld	a,(de)
		inc	de
		ld	(COLOR1),a
		ld	a,(DESPAGE)
		ld	(DESPAGE1),a
		ld	a,CMDHMMC
		ld	(CMD1),a
		ld	a,36
		call	VDP_INIT
		exx
		ld	c,CMDPORT
		ld	hl,DESX1
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
		exx
PHA_LOOP:
		dec	b
		jr	z,PHA_NEXT_LINE
PHA_NEXT_BYTE:
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
		jr	nc,PHA_NEXT_BYTE
		ld	a,(de)
		inc	de
		out	(VDPPORT),a
		ld	a,$80 | 44
		out	(VDPPORT),a
		exx
		ld	hl,(TESTDATA)
		inc	hl
		ld	(TESTDATA),hl
		exx
		jr	PHA_LOOP
PHA_NEXT_LINE:
		ex	af,af'
		ld	b,a
		ex	af,af'
		dec	c
		jr	z,PHA_NEXT_ROW
		ld	a,8
		sub	b
		add	a,e
		ld	e,a
		jr	nc,PHA_NEXT_BYTE
		inc	d
		jr	PHA_NEXT_BYTE
PHA_NEXT_ROW:
		ld	a,(hl)
		and	a
		jr	z,PHA_END
		ld	c,a
		inc	hl
		ld	e,(hl)
		inc	hl
		ld	d,(hl)
		inc	hl
		jr	PHA_NEXT_BYTE
PHA_END:
		pop	de
		pop	hl
		call	RESET_TILE_SLOT
		ei
		ret

; === Draw horizontal tile area ===
PAINT_HTILE:	; DESX, CNTX, MAPX, MAPY
		ld	a,(POSY)
		ld	e,a			; E = DESY
		ld	hl,(MAPX)		; H = MAPY, L = MAPX
		ld	a,212		; A = CNTY
		jr	PAHA_TILE
PAINT_HAREA:	; DESX, DESY0, CNTX, CNTY0, MAPX, POSY
		ld	a,(DESY0)
		ld	e,a
		ld	d,0
		ld	hl,(POSY)
		add	hl,de
		ld	e,l			; E = DESY
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
		ld	h,a			; H = MAPY
		ld	a,(MAPX)
		ld	l,a			; L = MAPX
		ld	a,(CNTY0)		; A = CNTY
PAHA_TILE:
		ld	(CNTY1),a
		ld	c,a
		ld	a,e
		ld	(DESY1),a
		and	0Fh
		ld	e,a
		ld	a,(DESX)
		rra
		and	7
		ld	d,a
		call	GET_VMAP
		ld	a,(CNTX)
		ld	b,a			; B = pixel count
		ld	a,(DESX)
		and	a
		rra
		jr	nc,PAHA_X_EVEN
		inc	b
PAHA_X_EVEN:
		and	a
		rla
		ld	(DESX1),a
		bit	0,b
		jr	z,PAHA_NX_EVEN
		inc	b
PAHA_NX_EVEN:
		ld	a,b
		ld	(CNTX1),a
		and	a
		rra
		ld	b,a			;b = x byte count
		ex	af,af'
		
		di
		call	SET_TILE_SLOT
		push	hl
		push	de
		
		ld	hl,0
		ld	(TESTDATA),hl
		
		ld	hl,MAP_BUFFER
		ld	c,(hl)
		inc	hl
		ld	e,(hl)
		inc	hl
		ld	d,(hl)
		inc	hl

		exx
		ld	a,(DISPLAY_PAGE)
		rlca
		ld	d,a
		ld	a,(DESX1)
		ld	l,a
		ld	a,(DESY1)
		and	a
		rra
		rr	l
		ld	h,a
		ld	bc,128
		exx
PAHA_LOOP:
		ld	a,2
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
PAHA_WAIT:
		in	a,(VDPPORT)
		rra
		jr	c,PAHA_WAIT
		ld	a,0
		out	(VDPPORT),a
		ld	a,SELRG15
		out	(VDPPORT),a
		exx
		ld	a,h
		rlca
		rlca
		and	1
		or	d
		out	(VDPPORT),a
		ld	a,SELRG14
		out	(VDPPORT),a
		ld	a,l
		nop
		out	(VDPPORT),a
		ld	a,h
		and	3Fh
		or	$40
		out	(VDPPORT),a
		exx
PAHA_NEXT_BYTE:
		ld	a,(de)
		inc	de
		out	(VRAMPORT),a
		ld	ix,(TESTDATA)
		inc	ix
		ld	(TESTDATA),ix
		dec	b
		jr	nz,PAHA_NEXT_BYTE
		exx
		add	hl,bc
		ld	a,h
		and	7Fh
		ld	h,a
		exx
		ex	af,af'
		ld	b,a
		ex	af,af'
		dec	c
		jr	z,PAHA_NEXT_ROW
		ld	a,8
		sub	b
		add	a,e
		ld	e,a
		jr	nc,PAHA_LOOP
		inc	d
		jr	PAHA_LOOP
PAHA_NEXT_ROW:
		ld	a,(hl)
		and	a
		jr	z,PAHA_END
		ld	c,a
		inc	hl
		ld	e,(hl)
		inc	hl
		ld	d,(hl)
		inc	hl
		jr	PAHA_LOOP
PAHA_END:
		pop	de
		pop	hl
		call	RESET_TILE_SLOT
		ei
		ret

; === Set SLOT and MAPPER 0000h-7FFFh to RAM with TILE_SLOT (2 blocks)
; return: H:old mapper #0, L:old mapper #1, D:old port 0A8h, E:old 0FFFFh
SET_TILE_SLOT:
		in	a,(0A8h)
		ld	d,a
		and	0F0h
		ld	l,a
		ld	a,d
		rlca
		rlca
		and	3
		ld	h,a
		rlca
		rlca
		or	h
		or	l
		out	(0A8h),a
		ld	a,(0FFFFh)
		cpl
		ld	e,a
		and	0F0h
		ld	l,a
		ld	a,e
		rlca
		rlca
		and	3
		ld	h,a
		rlca
		rlca
		or	h
		or	l
		ld	(0FFFFh),a
		in	a,(0FCh)
		ld	h,a
		in	a,(0FDh)
		ld	l,a
		ld	a,TILE_SLOT
		out	(0FCh),a
		inc	a
		out	(0FDh),a
		ret
		
; === Restore SLOT and MAPPER 0000h-7FFFh to default ===
; input: H:old mapper #0, L:old mapper #1, D:old port 0A8h, E:old 0FFFFh
RESET_TILE_SLOT:
		ld	a,h
		out	(0FCh),a
		ld	a,l
		out	(0FDh),a
		ld	a,e
		ld	(0FFFFh),a
		ld	a,d
		out	(0A8h),a
		ret

; === Read MAP datas vertically ===
; input: H = MAPY, L = MAPX, C = Count, D = X offset, E = Y offset
; return: MAP_BUFFER: [NY] [AD1] [AD2], NY:0 = end
; changed: A, A', BC, DE, HL, IX, IY
GET_VMAP:
		ld	a,16
		sub	e
		cp	c
		jr	c,GETVM_NO_CROP
		ld	a,c
GETVM_NO_CROP:
		ld	b,a		; B = NY
		ld	a,e
		rlca
		rlca
		rlca
		or	d
		ld	e,a		; E = Yoffset * 8 + Xoffset

		rl	l
		res	7,h
		scf
		rr	h
		rr	l		; HL = Map address
		ld	ix,MAP_BUFFER

		di
		in	a,(0FEh)
		ex	af,af'
		ld	a,MAP_SLOT
		out	(0FEh),a
GETVM_LOOP:
		ld	(ix+0),b
		ld	a,(hl)
		rl	e
		and	a
		rra
		rr	e
		ld	(ix+1),e
		ld	(ix+2),a
		inc	ix
		inc	ix
		inc	ix
		
		ld	a,l
		add	a,128
		ld	l,a
		jr	nc,GETVM_NO_INC
		inc	h
GETVM_NO_INC:
		ld	a,c
		sub	b
		jr	z,GETVM_END
		ld	c,a
		ld	a,16
		cp	c
		jr	c,GETVM_NOT_LAST
		ld	a,c
GETVM_NOT_LAST:
		ld	b,a
		ld	e,d
		jr	GETVM_LOOP
GETVM_END:
		ld	(ix+0),a
		ex	af,af'
		out	(0FEh),a
		ei
		ret
