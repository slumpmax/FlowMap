; === Draw software sprites from RAM ===
PUT_SOFT:
		ld	a,(DISPLAY_PAGE)
		ld	(VCMD1 + VDP_DESPAGE),a
		ld	a,CMDLMMC | LCMD_TIMP
		ld	(VCMD1 + VDP_CMD),a
		ld	ix,SOFT_SPRITE
		ld	iy,SOFT_HISTORY
		ld	hl,(POSX)
		ld	(OPOSX),hl
		ld	a,l
		and	0Fh
		ld	d,a				; D = PATX
		ld	hl,(POSY)
		ld	(OPOSY),hl
		ld	e,l				; E = POSYL
		ld	a,MAX_SOFT_SPR
PSOFT_NLOOP:
		push	af
		ld	a,(ix+0)
		cp	240
		ld	b,0
		jr	c,PSOFT_NO_NEGX
		jp	z,PSOFT_NO_SHOW
		sub	240
		ld	(VCMD1 + VDP_CNTX),a
		ld	(iy + PP_NX),a
		cpl
		add	a,17
		ld	b,a
		ld	a,d
		ld	(VCMD1 + VDP_DESX),a
		ld	(iy + PP_PX),a
		jr	PSOFT_NEXT_X
PSOFT_NO_NEGX:
		cp	225
		jr	c,PSOFT_NO_CROPX
		ld	l,a
		add	a,d
		ld	(VCMD1 + VDP_DESX),a
		ld	(iy + PP_PX),a
		ld	a,240
		sub	l
		jr	PSOFT_NX
PSOFT_NO_CROPX:
		add	a,d
		ld	(VCMD1 + VDP_DESX),a
		ld	(iy + PP_PX),a
		ld	a,16
PSOFT_NX:
		ld	(VCMD1 + VDP_CNTX),a
		ld	(iy + PP_NX),a
PSOFT_NEXT_X:
		ld	a,(ix+2)
		cp	212
		ld	c,0
		jr	c,PSOFT_NO_NEGY
		cp	241
		jp	c,PSOFT_NO_SHOW
		sub	240
		ld	(VCMD1 + VDP_CNTY),a
		ld	(iy + PP_NY),a
		cpl
		add	a,17
		ld	c,a
		ld	a,e
		ld	(VCMD1 + VDP_DESY),a
		ld	(iy + PP_PY),a
		jr	PSOFT_NEXT_Y
PSOFT_NO_NEGY:
		cp	197
		jr	c,PSOFT_NO_CROPY
		ld	l,a
		add	a,e
		ld	(VCMD1 + VDP_DESY),a
		ld	(iy + PP_PY),a
		ld	a,212
		sub	l
		jr	PSOFT_NY
PSOFT_NO_CROPY:
		add	a,e
		ld	(VCMD1 + VDP_DESY),a
		ld	(iy + PP_PY),a
		ld	a,16
PSOFT_NY:
		ld	(VCMD1 + VDP_CNTY),a
		ld	(iy + PP_NY),a
PSOFT_NEXT_Y:
		ld	a,c
		rlca
		rlca
		rlca
		rlca
		or	b
		ld	l,a
		ld	h,(ix+3)
		srl	h
		rr	l
		
		ld	a,(VCMD1 + VDP_CNTY)
		ld	b,a
		ld	a,(VCMD1 + VDP_DESY)
		ld	c,a
		add	a,b
		jr	nc,PSOFT_NO_OVER
		jr	z,PSOFT_NO_OVER
		ld	b,a
		xor	a
		sub	c
		ld	(VCMD1 + VDP_CNTY),a
		ld	c,a
		di
		in	a,($FE)
		ld	(MAPPER2),a
		ld	a,SPR_SLOT
		out	($FE),a
		ld	a,(hl)
		ld	e,a		;;;;
		rrca
		rrca
		rrca
		rrca
		and	0Fh
		ld	(VCMD1 + VDP_COLOR),a
		push	bc
		call	VDP_INIT
		pop	bc
		ld	a,b
		ld	ix,VCMD1
		ld	(ix + VDP_CNTY),a
		ld	a,(ix + VDP_SRCY)
		add	a,c
		ld	(ix + VDP_SRCY),a
		xor	a
		ld	(ix + VDP_DESY),a
PSOFT_NO_OVER:
		call	VDPCOPY
		ld	bc,PP_SIZE
		add	iy,bc
PSOFT_NO_SHOW:
		inc	ix
		inc	ix
		inc	ix
		inc	ix
		pop	af
		dec	a
		jp	nz,PSOFT_NLOOP
		xor	a
		ld	(iy + PP_NX),a
		ret
