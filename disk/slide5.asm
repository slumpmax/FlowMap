; Byte References

VALTYPINT       equ     2
VALTYPSTR       equ     3
VALTYPSNG       equ     4
VALTYPDBL       equ     5

; VDP Commands
CMDSTOP         equ     00h     ; Stop
CMDINVALID1     equ     10h     ; Not used
CMDINVALID2     equ     20h     ; Not used
CMDINVALID3     equ     30h     ; Not used
CMDPOINT        equ     40h     ; Point
CMDPSET         equ     50h     ; Pset
CMDSEARCH       equ     60h     ; Search
CMDLINE         equ     70h     ; Line
CMDLMMV         equ     80h     ; Low speed fill
CMDLMMM         equ     90h     ; Low speed copy
CMDLMCM         equ     0A0h    ; Low speed getpixels
CMDLMMC         equ     0B0h    ; Low speed setpixels
CMDHMMV         equ     0C0h    ; High speed fill
CMDHMMM         equ     0D0h    ; High speed copy
CMDYMMM         equ     0E0h    ; High speed copy y-direction
CMDHMMC         equ     0F0h    ; High speed setpixels

; VDP Command Logical Operations
LCMD_IMP        equ     00h     ; DES = SRC
LCMD_AND        equ     01h     ; DES = SRC and DES
LCMD_OR         equ     02h     ; DES = SRC or DES
LCMD_EOR        equ     03h     ; DES = SRC xor DES
LCMD_NOT        equ     04h     ; DES = not SRC
LCMD_TIMP       equ     08h     ; Ignore CL0, DES = SRC
LCMD_TAND       equ     09h     ; Ignore CL0, DES = SRC and DES
LCMD_TOR        equ     0Ah     ; Ignore CL0, DES = SRC or DES
LCMD_TEOR       equ     0Bh     ; Ignore CL0, DES = SRC xor DES
LCMD_TNOT       equ     0Ch     ; Ignore CL0, DES = not SRC

VRAMPORT        equ     98h     ; V9938 VRAM port
VDPPORT         equ     99h     ; V9938 Register port
PALPORT         equ     9Ah     ; V9938 Palette port
CMDPORT         equ     9Bh     ; V9938 Command port

SELRG2          equ     82h     ; V9938 Select Reg#2 - Page offset
SELRG5          equ     85h     ; V9938 Select Reg#5 - Sprite color & attribute offset
SELRG8          equ     88h     ; V9938 Select Reg#8 - Control register 8
SELRG14         equ     8Eh     ; V9938 Select Reg#14 - High bit for VRAM address
SELRG15         equ     8Fh     ; V9938 Select Reg#15 - Set status register index
SELRG17         equ     91h     ; V9938 Select Reg#17 - Set command register index
SELRG18         equ     92h     ; V9938 Select Reg#18 - Screen adjust
SELRG23         equ     97h     ; V9938 Select Reg#23 - Vertical offset
SELRG27         equ     9Bh     ; V9938 Select Reg#27 - Vertical offset

; Word References

MMUSRTAB        equ     0F39Ah
MMRG2SAV        equ     0F3E1h
MMRG8SAV        equ     0F3E7h
MMRG18SAV       equ     0FFF1h
MMRG23SAV       equ     0FFF6h
MMVALTYP        equ     0F663h
MMUSRINT        equ     0F7F8h
MMDPPAGE        equ     0FAF5h
EXPTBL          equ     0FCC1h
SLTTBL          equ     0FCC5h

MSXERROR        equ     406Fh   ; MSX BASIC ERROR HANDLER ROUTINE

; Routine constant

TILE_PAGE       equ     0
MAP_PAGE        equ     1
START_PAGE      equ     2
MAP_SLOT        equ     4
SPR_SLOT        equ     5
TILE_SLOT       equ     6
MAX_SOFT_SPR    equ     8

; === BSAVE header (7 Bytes) ===

PROGSTART       equ     0C000h

                org     PROGSTART - 7

                db      0FEh
                dw      PROGSTART
                dw      PROGEND - 1
                dw      PROGRUN
        
; === Begin ===

POSX:           dw      0000            ;C000 World position X
POSY:           dw      0000            ;C002 World position Y
POSYH           equ     POSY + 1

MAPX:           db      00              ;C004
MAPY:           db      00              ;C005
PATX:           db      00              ;C006 
PATY:           db      00              ;C007
DISPLAY_PAGE:   db      START_PAGE      ;C008 Current display page (1, 2, 3)
AMOUNT:         db      01              ;C009 Scroll count
SPEED:          db      01              ;C00A Scroll speed 1,2,4,8,16
READY:          db      00              ;C00B Image loaded in RAM
SPRITE_MODE     db      00              ;C00C bit0 = hard, bit1 = soft
                db      00              ;C00D
                dw      0000            ;C00E
SIGNATURE:      db      $46,$64         ;C010 Binary loaded signature
WALKTIME:       dw      0000            ;C012 Sprite walk time
                ds      12              ; DUMMY DATA for future uses

THARD class {
    Y       db      240
    X       db      0
    N       db      0
    C       db      0
}
;                THARD(Y: 240, X: 0, N: 0, C: 0)
; 32 hardware sprites location = db Y, X, N, C
HARD_SPRITE:
                db      240, 0, 0, 0    ;C020
                db      240, 0, 1, 0
                db      240, 0, 2, 0
                db      240, 0, 3, 0
                db      240, 0, 4, 0
                db      240, 0, 5, 0
                db      240, 0, 6, 0
                db      240, 0, 7, 0

                db      240, 0, 8, 0
                db      240, 0, 9, 0
                db      240, 0, 10, 0
                db      240, 0, 11, 0
                db      240, 0, 12, 0
                db      240, 0, 13, 0
                db      240, 0, 14, 0
                db      240, 0, 15, 0

                db      240, 0, 16, 0
                db      240, 0, 17, 0
                db      240, 0, 18, 0
                db      240, 0, 19, 0
                db      240, 0, 20, 0
                db      240, 0, 21, 0
                db      240, 0, 22, 0
                db      240, 0, 23, 0

                db      240, 0, 24, 0
                db      240, 0, 25, 0
                db      240, 0, 26, 0
                db      240, 0, 27, 0
                db      240, 0, 28, 0
                db      240, 0, 29, 0
                db      240, 0, 30, 0
                db      240, 0, 31, 0

; === Software sprite table [db X, FX, Y, Number (0-127)] ===
TSOFT class {
    FLAG    db  1
    PX      db  0
    PY      db  216
    ID      db  0
}

SOFT_SPRITE:
;                TSOFT(FLAG: 1, PX: 050, PY: 050, ID: $4A)   ; C0A0
;                TSOFT(FLAG: 1, PX: 070, PY: 050, ID: $42)
;                TSOFT(FLAG: 1, PX: 090, PY: 050, ID: $02)

;                TSOFT($01, 050, 090, $02)

                db      $01, 050, 050, $4A      ; C0A0
                db      $01, 070, 050, $42
                db      $01, 090, 050, $02
                db      $01, 110, 050, $0A
                db      $01, 130, 060, $12
                db      $01, 150, 060, $1A
                db      $01, 170, 060, $22
                db      $01, 190, 060, $2A

                db      $01, 010, 100, $32
                db      $01, 030, 100, $3A
                db      $01, 050, 100, $52
                db      $01, 070, 100, $5A
                db      $01, 100, 110, $62
                db      $01, 120, 110, $6A
                db      $01, 140, 110, $72
                db      $01, 160, 110, $7A

                db      $01, 060, 150, $4C
                db      $01, 080, 150, $44
                db      $01, 100, 150, $04
                db      $01, 120, 150, $0C
                db      $01, 160, 160, $14
                db      $01, 180, 160, $1C
                db      $01, 200, 160, $24
                db      $01, 220, 160, $2C

                db      $01, 030, 190, $34
                db      $01, 050, 190, $3C
                db      $01, 070, 190, $54
                db      $01, 090, 190, $5C
                db      $01, 110, 180, $64
                db      $01, 130, 180, $6C
                db      $01, 150, 180, $74
                db      $01, 170, 180, $7C

TRECT class {
    NX:         db      0
    NY:         db      0
    PX:         db      0
    PY:         db      0
    PAGE:       db      0
    MAPX:       db      0
    MAPY:       db      0
    PATX:       db      0
    PATY:       db      0
}
RECT0:      object  TRECT
RECT1:      object  TRECT
RECT_AREA:  object  TRECT

OPOSX:          dw      0000
OPOSY:          dw      0000
RAWSPEED:       db      01      ; Internal speed
HARD_OFFSET:    db      0       ; Hardware SPRITE COLOR & ATTRIBUTE TABLE
                                ; 0 = 7000h, 1 = 7400h
PRISLOT:        db      0       ; Old primary slot
SECSLOT:        db      0       ; Old secondary slot
MAPPER0:        db      0       ; Old RAM mapper port $FC
MAPPER1:        db      0       ; Old RAM mapper port $FD
MAPPER2:        db      0       ; Old RAM mapper port $FE
MAPPER3:        db      0       ; Old RAM mapper port $FF
SOFT_HISTORY:   ds      MAX_SOFT_SPR * SIZE(TRECT) + 1
; [NX] [NY] [PX] [PY] [PAGE] x 32 sprites, NX:0 = end

TMAPBUF class {
    NY          db      0
    SRCX        db      0
    SRCY        db      0
}
MAP_BUF_COUNT   equ     18          ; Amount of MAP_BUFFER
MAP_BUFFER:     ds      SIZE(TMAPBUF) * MAP_BUF_COUNT
                                    ; [NY] [SRCX] [SRCY], NY:0 = end

; === V9938 CMD class ===
TVCMD class {
    SRCX        dw      0000
    SRCY        db      00
    SRCPAGE     db      00
    DESX        dw      0000
    DESY        db      00
    DESPAGE     db      00
    CNTX        db      00
    CNTXH       db      00
    CNTY        db      00
    CNTYH       db      00
    COLOR       db      00
    PARAM       db      00
    CMD         db      00
}
VCMD0:   object  TVCMD
VCMD1:   object  TVCMD

; === Execute V9938 command ===
VDPCOPY:
                ld      a,20h
                ld      b,15
                push    ix
                pop     hl
                jr      VDPEXEC
VDPFILL:
                ld      a,24h
                ld      b,11
                push    ix
                pop     hl
                inc     hl
                inc     hl
                inc     hl
                inc     hl
VDPEXEC:
                di
                out     (VDPPORT),a
                ld      a,SELRG17
                ei
                out     (VDPPORT),a
                ld      c,CMDPORT
VDPEX_WAIT:
                ld      a,2
                di
                out     (VDPPORT),a
                ld      a,SELRG15
                out     (VDPPORT),a
                in      a,(VDPPORT)
                rra
                ld      a,0
                out     (VDPPORT),a
                ld      a,SELRG15
                ei
                out     (VDPPORT),a
                jr      c,VDPEX_WAIT
                otir
                ret
        
; === V9938 indirect register (no DI/EI) ===
VDP_INIT:
                out     (VDPPORT),a
                ld      a,SELRG17
                out     (VDPPORT),a
VINIT_WAIT:
                ld      a,2
                out     (VDPPORT),a
                ld      a,SELRG15
                out     (VDPPORT),a
                in      a,(VDPPORT)
                rra
                ld      a,0
                out     (VDPPORT),a
                ld      a,SELRG15
                out     (VDPPORT),a
                jr      c,VINIT_WAIT
                ret

; === V9938 wait busy ===
VDP_WAIT:
                ld      a,2
                di
                out     (VDPPORT),a
                ld      a,SELRG15
                out     (VDPPORT),a
                in      a,(VDPPORT)
                rra
                ld      a,0
                out     (VDPPORT),a
                ld      a,SELRG15
                ei
                out     (VDPPORT),a
                jr      c,VDP_WAIT
                ret

; === Wait VSYNC ===
WAIT_VSYNC:
                ld      a,2
                di
                out     (VDPPORT),a
                ld      a,SELRG15
                out     (VDPPORT),a
                in      a,(VDPPORT)
                rlca
                rlca
                ld      a,0
                out     (VDPPORT),a
                ld      a,SELRG15
                ei
                out     (VDPPORT),a
                jr      c,WAIT_VSYNC
WV_DRAW:
                ld      a,2
                di
                out     (VDPPORT),a
                ld      a,SELRG15
                out     (VDPPORT),a
                in      a,(VDPPORT)
                rlca
                rlca
                ld      a,0
                out     (VDPPORT),a
                ld      a,SELRG15
                ei
                out     (VDPPORT),a
                jr      nc,WV_DRAW
                ret

; === Wait HSYNC ===
WAIT_HSYNC:
                ld      a,2
                di
                out     (VDPPORT),a
                ld      a,SELRG15
                out     (VDPPORT),a
                in      a,(VDPPORT)
                rlca
                rlca
                rlca
                ld      a,0
                out     (VDPPORT),a
                ld      a,SELRG15
                ei
                out     (VDPPORT),a
                jr      c,WAIT_HSYNC
WH_HDRAW:
                ld      a,2
                di
                out     (VDPPORT),a
                ld      a,SELRG15
                out     (VDPPORT),a
                in      a,(VDPPORT)
                rlca
                rlca
                rlca
                ld      a,0
                out     (VDPPORT),a
                ld      a,SELRG15
                ei
                out     (VDPPORT),a
                jr      nc,WH_HDRAW
                dec     b
                jr      nz,WAIT_HSYNC
                ret

; === Clear page A ===
; input: IX = VCMD, A = PAGE NUMBER
; changed: IX A B C H L VCMD [SRCX...CMD]
CLEAR_PAGE:
                ld      (ix + TVCMD.DESPAGE),a
                xor     a
                ld      (ix + TVCMD.DESX),a
                ld      (ix + TVCMD.DESY),a
                ld      (ix + TVCMD.COLOR),a
                ld      (ix + TVCMD.CNTX),a
                ld      (ix + TVCMD.CNTY),a
                inc     a
                ld      (ix + TVCMD.CNTXH),a
                ld      (ix + TVCMD.CNTYH),a
                ld      (ix + TVCMD.CMD),CMDHMMV
                call    VDPFILL
                xor     a
                ld      (ix + TVCMD.CNTXH),a
                ld      (ix + TVCMD.CNTYH),a
                ret

; === Fetch POSX, POSY to MAPX, MAPY, PATX, PATY ===
; Return H = MAPX, L = PATX, D = MAPY, E = PATY
FETCH_XY:
                ld      hl,(POSX)
                ld      de,(POSY)
FETCH_POS:
                ld      a,h
                rlca
                rlca
                rlca
                rlca
                and     70h
                ld      h,a
                ld      a,l
                rrca
                rrca
                rrca
                rrca
                and     0Fh
                or      h
                ld      h,a
                ld      (MAPX),a
                ld      a,l
                and     0Fh
                ld      l,a
                ld      (PATX),a

                ld      a,d
                rlca
                rlca
                rlca
                rlca
                and     70h
                ld      d,a
                ld      a,e
                rrca
                rrca
                rrca
                rrca
                and     0Fh
                or      d
                ld      d,a
                ld      (MAPY),a
                ld      a,e
                and     0Fh
                ld      e,a
                ld      (PATY),a

                ret

; === Fetch MAPX, MAPY ===
; Input HL = POSX, DE = POSY
; Return H = MAPX, D = MAPY
FETCH_MAP:
                ld      a,h
                rlca
                rlca
                rlca
                rlca
                and     70h
                ld      h,a
                ld      a,l
                rrca
                rrca
                rrca
                rrca
                and     0Fh
                or      h
                ld      h,a
                ld      (MAPX),a

                ld      a,d
                rlca
                rlca
                rlca
                rlca
                and     70h
                ld      d,a
                ld      a,e
                rrca
                rrca
                rrca
                rrca
                and     0Fh
                or      d
                ld      d,a
                ld      (MAPY),a

                ret

; === Set vertical offset VDP & screen adjust VDP ===
SETSCROLL:
                call    VDP_WAIT
                call    WAIT_VSYNC
                ld      a,(POSY)
                ld      (MMRG23SAV),a
                di
                out     (VDPPORT),a
                ld      a,SELRG23
                ei
                out     (VDPPORT),a
                ld      a,(POSX)
                add     a,8
                and     0Fh
                ld      (MMRG18SAV),a
                di
                out     (VDPPORT),a
                ld      a,SELRG18
                ei
                out     (VDPPORT),a
                ld      a,(DISPLAY_PAGE)
                ld      (MMDPPAGE),a
                rrca
                rrca
                rrca
                and     60h
                or      1Fh
                ld      (MMRG2SAV),a
                di
                out     (VDPPORT),a
                ld      a,SELRG2
                ei
                out     (VDPPORT),a
SET_HARD:
                ld      a,(HARD_OFFSET) ; Hardware sprite attribute table
                rlca
                rlca
                rlca
                or      $E7
                di
                out     (VDPPORT),a
                ld      a,SELRG5
                ei
                out     (VDPPORT),a
                ret

; === Put 32 hardware sprites ===
PUT_HARD:
                ld      a,(SPRITE_MODE)
                and     1
                ret     z
                ld      a,(POSX)
                and     15
                ld      d,a
                ld      a,(POSY)
                ld      e,a
                ld      a,(HARD_OFFSET)
                xor     1
                and     1
                ld      (HARD_OFFSET),a ; 0:7200h, 1:7600h
                rlca
                rlca
                or      $72
                ld      h,a
                rlca
                rlca
                and     1
                di
                out     (VDPPORT),a
                ld      a,SELRG14
                out     (VDPPORT),a
                ld      a,0
                out     (VDPPORT),a
                ld      a,h
                and     3Fh
                or      40h
                out     (VDPPORT),a
                ld      b,32
                ld      hl,HARD_SPRITE
LOOP_PUT_HARD:
                ld      a,(hl)
                inc     hl
                add     a,e
                cp      217
                jr      nc,NO_216
                dec     a
NO_216:
                out     (VRAMPORT),a
                ld      a,(hl)
                inc     hl
                add     a,d
                out     (VRAMPORT),a
                ld      a,(hl)
                inc     hl
                rlca
                rlca
                out     (VRAMPORT),a
                ld      a,(hl)
                inc     hl
                out     (VRAMPORT),a
                dec     b
                jr      nz,LOOP_PUT_HARD
                ei
                ret

; === Clear 32 hardware sprites ===
CLEAR_HARD:
                xor     a
                call    CLEAR_HARD_ONE
                ld      a,1
CLEAR_HARD_ONE:
                rlca
                rlca
                or      $72
                ld      h,a
                rlca
                rlca
                and     1
                di
                out     (VDPPORT),a
                ld      a,SELRG14
                out     (VDPPORT),a
                ld      a,0
                out     (VDPPORT),a
                ld      a,h
                and     3Fh
                or      40h
                out     (VDPPORT),a
                ld      b,32
                ld      a,216
                ld      d,0
                ld      c,VRAMPORT
LOOP_CLR_HARD:
                out     (c),a
                out     (c),d
                out     (c),d
                out     (c),d
                dec     b
                jr      nz,LOOP_CLR_HARD
                ei
                ret

; === USR2 - Set display to page (n) ===
SETVPAGE:
                ld      e,5
                ld      a,(MMVALTYP)
                cp      VALTYPINT
                jp      nz,MSXERROR
                ld      hl,(MMUSRINT)
                ld      a,h
                and     a
                jp      nz,MSXERROR
                ld      a,l
                cp      4
                jp      nc,MSXERROR
                ld      (MMDPPAGE),a
                rrca
                rrca
                rrca
                and     60h
                or      1Fh
                ld      (MMRG2SAV),a
                di
                out     (VDPPORT),a
                ld      a,SELRG2
                ei
                out     (VDPPORT),a
                ret
                
; === Fill horizontal block with color ===
; input: IX = VCMD [DESX, CNTX, COLOR, DESPAGE]
; input: IY = RECT
; input: POSY
; changed: DESY, CNTY, CMD, A, A', BC, HL
; changed: RECT [NY, PY]
FILL_HBAR:
                ld      a,(POSY)
                ld      (iy + TRECT.PY),a
                ld      (iy + TRECT.NY),212
                jr      FILL_HRECT

; === Fill horizontal rect with color ===
; input: IX = VCMD [DESX, CNTX, COLOR, DESPAGE]
; input: IY [TRECT.NY] [TRECT.PY]
; changed: DESY, CNTY, CMD, A, A', BC, HL
FILL_HRECT:
                ld      a,(ix + TVCMD.DESX)
                rra
                ld      a,(ix + TVCMD.CNTX)
                rla
                and     3
                ld      a,CMDHMMV
                jr      z,FHR_HFILL
                ld      a,CMDLMMV
FHR_HFILL:
                ld      (ix + TVCMD.CMD),a
                ld      a,(iy + TRECT.NY)          ; NY
                dec     a
                ld      b,a
                ld      a,(iy + TRECT.PY)          ; PY
                ld      (ix + TVCMD.DESY),a
                ld      c,a
                add     a,b
                jr      nc,FHR_NOT_OVER
                ex      af,af'
                xor     a
                sub     c
                ld      (ix + TVCMD.CNTY),a
                call    VDPFILL
                xor     a
                ld      (ix + TVCMD.DESY),a
                ex      af,af'
                ld      b,a
FHR_NOT_OVER:
                ld      a,b
                inc     a
                ld      (ix + TVCMD.CNTY),a
                jr      nz,FHR_NOT_256
                inc     a
                ld      (ix + TVCMD.CNTYH),a
FHR_NOT_256:
                call    VDPFILL
                xor     a
                ld      (ix + TVCMD.CNTYH),a
                ret

; === Fill rectangle ===
; inputs: IX = VCMD [COLOR]
; inputs: IY [NX] [NY] [PX] [PY] [PAGE]
; changed: DESX, DESY, DESPAGE, CNTX, CNTY, CMD, A, A', BC, DE, HL
FILL_RECT:
                ld      a,(iy + TRECT.PAGE)
                ld      (ix + TVCMD.DESPAGE),a
                ld      c,(iy + TRECT.NX)
                ld      a,(iy + TRECT.PX)
                ld      (ix + TVCMD.DESX),a
                bit     0,a
                jr      z,FRECT_EVEN
                ld      b,a
                push    bc
                ld      (ix + TVCMD.CNTX),1
                ld      (ix + TVCMD.CNTXH),0

                ; input: IX = VCMD [DESX, CNTX, COLOR, DESPAGE]
                ; input: IY [TRECT.NY] [TRECT.PY]
                ; changed: DESY, CNTY, CMD, A, A', BC, HL
                call    FILL_HRECT

                pop     bc
                ld      a,b
                inc     a
                ld      (ix + TVCMD.DESX),a
                dec     c
                ret     z
FRECT_EVEN:
                ld      b,a
                ld      a,c
                and     $FE
                ld      (ix + TVCMD.CNTX),a
                jr      nz,FRECT_NOT_256
                bit     0,c
                jr      nz,FRECT_NOT_256
                inc     a
                ld      (ix + TVCMD.CNTXH),a
FRECT_NOT_256:
                push    bc
                call    FILL_HRECT
                pop     bc
                ld      (ix + TVCMD.CNTXH),0
                ld      a,c
                and     1
                ret     z
                ld      (ix + TVCMD.CNTX),a
                ld      a,b
                add     a,c
                dec     a
                ld      (ix + TVCMD.DESX),a
                jp      FILL_HRECT

; === Fill area with COLOR ===
; IX: VCMD [COLOR]
; IY: [NX] [NY] [PX] [PY] [PAGE] (Virtual screen 240x212)
; changed: DESX, DESY, DESPAGE, CNTX, CNTY, [CMD], A, A', BC, DE, HL
; changes: RECT1 [NX, NY, PX, PY, PAGE]
FILL_AREA:
                ld      a,(POSX)
                and     0Fh
                add     a,(iy + TRECT.PX)
                ld      (RECT_AREA + TRECT.PX),a
                ld      a,(POSY)
                add     a,(iy + TRECT.PY)
                ld      (RECT_AREA + TRECT.PY),a
                ld      a,(iy + TRECT.NX)
                ld      (RECT_AREA + TRECT.NX),a
                ld      a,(iy + TRECT.NY)
                ld      (RECT_AREA + TRECT.NY),a
                ld      a,(iy + TRECT.PAGE)
                ld      (RECT_AREA + TRECT.PAGE),a
                push    iy
                ld      iy,RECT_AREA

                ; inputs: IX = VCMD [COLOR]
                ; inputs: IY [NX] [NY] [PX] [PY] [PAGE]
                ; changed: DESX, DESY, DESPAGE, CNTX, CNTY, CMD, A, A', BC, DE, HL
                call    FILL_RECT

                pop     iy
                ret

; === Copy horizontal block from BACK to FRONT page ===
; input: IX [SRCX, DESX, CNTX], POSY
; input: IY [PX, NX]
; changed: A A' BC HL
COPY_HBAR:
                ld      a,(DISPLAY_PAGE)
                ld      (ix + TVCMD.DESPAGE),a
                xor     1
                ld      (ix + TVCMD.SRCPAGE),a
                ld      a,(ix + TVCMD.DESX)
                rrca
                ld      a,(ix + TVCMD.CNTX)
                rla
                and     3
                ld      a,CMDHMMM
                jr      z,CHB_HCOPY
                ld      a,CMDLMMM
CHB_HCOPY:
                ld      (ix + TVCMD.CMD),a
                ld      a,(POSY)
                ld      (ix + TVCMD.SRCY),a
                ld      (ix + TVCMD.DESY),a
                ld      l,a
                ld      a,212
                ld      (ix + TVCMD.CNTY),a
                dec     a
                add     a,l
                jr      nc,CHBNO1
                inc     a
                ex      af,af'
                xor     a
                sub     l
                ld      (ix + TVCMD.CNTY),a
                call    VDPCOPY
                ex      af,af'
                ld      (ix + TVCMD.CNTY),a
                xor     a
                ld      (ix + TVCMD.SRCY),a
                ld      (ix + TVCMD.DESY),a
CHBNO1:
                jp      VDPCOPY

; === Draw horizontal tile area ===
; input: IX = VCMD [DESX CNTX DESPAGE]
; input: IY = RECT [MAPX]
; input: POSY MAPY
; changed: RECT [NY, PY, MAPY]
; changed: VCMD [SRCX SRCY DESX DESY CNTX CNTY SRCPAGE DESPAGE CMD]
; changed: A C DE HL
DRAW_HTILE:
                ld      a,(POSY)
                ld      (iy + TRECT.PY),a
                ld      (iy + TRECT.NY),212
                ld      a,(MAPY)
                ld      (iy + TRECT.MAPY),a
                jr      DRAW_HRECT

; === Draw horizontal tile rectangle ===
; input: IX = VCMD [DESX CNTX DESPAGE]
; input: IY = RECT [NY PY MAPX MAPY]
; changed: A C DE HL SRCX SRCY DESX DESY CNTX CNTY SRCPAGE DESPAGE CMD
DRAW_HRECT:
                ld      a,(ix + TVCMD.DESX)
                rra
                ld      a,(ix + TVCMD.CNTX)
                rla
                and     3
                ld      a,CMDHMMM
                jr      z,DHR_HCOPY
                ld      a,CMDLMMM
DHR_HCOPY:
                ld      (ix + TVCMD.CMD),a
                ld      a,(iy + TRECT.NY)
                ld      c,a
                ld      a,(ix + TVCMD.DESX)
                and     0Fh
                ld      d,a                     ; d = xoffset (0-15)
                ld      a,(iy + TRECT.PY)
                ld      (ix + TVCMD.DESY),a
                and     0Fh
                ld      e,a                     ; e = yoffset (0-15)
                ld      a,(iy + TRECT.MAPX)
                ld      l,a
                ld      a,(iy + TRECT.MAPY)
                ld      h,a

                ; input: H = MAPY, L = MAPX, C = Count, D = X offset, E = Y offset
                ; return: MAP_BUFFER: [NY] [SX] [SY], NY:0 = end
                ; changed: A, A', BC, DE, HL
                call    GET_VMAP

                ld      a,TILE_PAGE
                ld      (ix + TVCMD.SRCPAGE),a
                ld      hl,MAP_BUFFER
                ld      a,(ix + TVCMD.DESY)
                ld      e,a
DHR_LOOP:
                ld      a,(hl)
                inc     hl
                and     a
                ret     z
                ld      (ix + TVCMD.CNTY),a
                ld      d,a
                ld      a,(hl)
                inc     hl
                ld      (ix + TVCMD.SRCX),a
                ld      a,(hl)
                inc     hl
                ld      (ix + TVCMD.SRCY),a
                push    hl
                call    VDPCOPY
                pop     hl
                ld      a,e
                add     a,d
                ld      (ix + TVCMD.DESY),a
                ld      e,a
                jr      DHR_LOOP

; === Draw tile blocks to specified rectangle ===
; input: IX = VCMD
; input: IY = RECT [NX NY PX PY PAGE], POSX, POSY (256x212)
; changed: RECT [NX, NY, PX, PY, PAGE] A HL DE BC
DRAW_RECT:
                xor     a
                ld      (ix + TVCMD.COLOR),a
                ld      a,(iy + TRECT.PAGE)
                ld      (ix + TVCMD.DESPAGE),a
                
                ld      hl,(POSX)
                ld      a,l
                and     0Fh
                ld      d,a                     ; D = PATX
                add     a,240
                ld      e,a                     ; E = 240 + PATX
                ld      c,(iy + TRECT.NX)          ; C = NX
                dec     c
                ld      a,(iy + TRECT.PX)          ; PX
                ld      (ix + TVCMD.DESX),a
                cp      e
                jp      nc,DRECT_FILL_RIGHT
                cp      d
                jr      nc,DRECT_COPY
                cpl
                add     a,d
                cp      c
                jr      c,DRECT_NO_CROP_LEFT
                ld      a,c
DRECT_NO_CROP_LEFT:
                inc     a
                ld      (ix + TVCMD.CNTX),a
                ld      b,a
                exx
                call    FILL_HRECT
                exx
                ld      a,c
                inc     a
                sub     b
                ret     z
                dec     a
                ld      c,a
                ld      a,(ix + TVCMD.DESX)
                add     a,b
                ld      (ix + TVCMD.DESX),a
DRECT_COPY:
                ld      b,a
                rr      h
                rr      l
                rr      h
                rr      l
                rr      h
                rr      l
                rr      h
                rr      l
                rrca
                rrca
                rrca
                rrca
                and     0Fh
                add     a,l
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                ld      hl,(POSY)
                ld      a,(iy + TRECT.PY)
                sub     l
                add     a,l
                jr      nc,DRECT_NO_INC_H
                inc     h
DRECT_NO_INC_H:
                rr      h
                rra
                rr      h
                rra
                rr      h
                rra
                rr      h
                rra
                and     7Fh
                ld      (iy + TRECT.MAPY),a
                ld      a,b
                and     0Fh
                ld      b,a
                ld      a,16
                sub     b
DRECT_COPY_LOOP:
                dec     a
                cp      c
                jr      c,DRECT_NO_CROP_COPY
                ld      a,c
DRECT_NO_CROP_COPY:
                inc     a
                ld      b,a
                ld      a,(ix + TVCMD.DESX)
                ld      d,a
                add     a,b
                jr      z,DRECT_LAST
                cp      e
                jr      c,DRECT_NO_LAST
DRECT_LAST:
                ld      a,e
                sub     d
                ld      b,a
DRECT_NO_LAST:
                ld      a,b
                ld      (ix + TVCMD.CNTX),a
                ld      a,d
                cp      e
                jr      nc,DRECT_FILL_RIGHT
                exx
                call    DRAW_HRECT
                exx
                ld      a,d
                add     a,b
                ld      (ix + TVCMD.DESX),a
                ld      d,a
                ld      a,(iy + TRECT.MAPX)
                inc     a
                ld      (iy + TRECT.MAPX),a
                ld      a,c
                inc     a
                sub     b
                ret     z
                dec     a
                ld      c,a
                ld      a,16
                jr      DRECT_COPY_LOOP
DRECT_FILL_RIGHT:
                ld      a,c
                inc     a
                ld      (ix + TVCMD.CNTX),a
                call    FILL_HRECT
                ret

; === Draw tile blocks to specified area ===
; input: IX = VCMD [DESX...CMD]
; input: IY = [NX] [NY] [PX] [PY] [PAGE] (Virtual screen 240x212), POSX, POSY
; changed: RECT1 [NX, NY, PX, PY, PAGE]
DRAW_AREA:
                ld      a,(POSX)
                and     0Fh
                add     a,(iy + TRECT.PX)
                ld      (RECT_AREA + TRECT.PX),a
                ld      a,(POSY)
                add     a,(iy + TRECT.PY)
                ld      (RECT_AREA + TRECT.PY),a
                ld      a,(iy + TRECT.NX)
                ld      (RECT_AREA + TRECT.NX),a
                ld      a,(iy + TRECT.NY)
                ld      (RECT_AREA + TRECT.NY),a
                ld      a,(iy + TRECT.PAGE)
                ld      (RECT_AREA + TRECT.PAGE),a
                push    iy
                ld      iy,RECT_AREA
                call    DRAW_RECT
                pop     iy
                ret

; === Draw line to back page ===
; input: IX = VCMD [DESX...CMD]
; input: IY [NX] [NY] [PX] [PY] [PAGE]
; input: POSX, POSY
DRAW_BACK_RECT:
                ld      a,(iy + TRECT.PAGE)
                ld      (ix + TVCMD.DESPAGE),a
                ld      a,(iy + TRECT.PY)
                ld      hl,(POSY)
                sub     l
                add     a,l
                ld      l,a
                jr      nc,DBACK_NO_INC
                inc     h
DBACK_NO_INC:
                ld      a,l
                rr      h
                rra
                rr      h
                rra
                rr      h
                rra
                rr      h
                rra
                and     7Fh
                ld      (iy + TRECT.MAPY),a

                ld      hl,(POSX)
                ld      a,l
                rr      h
                rra
                rr      h
                rra
                rr      h
                rra
                rr      h
                rra
                and     7Fh
                inc     a
                ld      h,a                     ; H = MAPX + 1
                ld      a,l
                and     0Fh
                ld      l,a                     ; L = PATX
                inc     a
                rlca
                rlca
                rlca
                rlca
                and     0F0h
                ld      e,a                     ; E = (PATX + 1) * 16

                ld      c,16                    ; C = CNTX
                xor     a
                ld      d,a                     ; D = DESX
DBACK_LOOP:
                ld      (IX + TVCMD.DESX),a
                cp      240
                jr      c,DBACK_LESS_240
                jr      z,DBACK_240
                ld      a,h
                add     a,14
                ld      h,a
                ld      a,16
                sub     l
                ld      c,a
                jr      DBACK_LESS_PATX
DBACK_240:
                ld      a,l
                and     a
                jr      z,DBACK_PAT0
                ld      c,l
                ld      a,h
                sub     14
                ld      h,a
                jr      DBACK_LESS_PATX
DBACK_PAT0:
                inc     h
                jr      DBACK_LESS_PATX
DBACK_LESS_240:
                cp      e
                jr      nz,DBACK_LESS_PATX
                dec     h
                dec     h
DBACK_LESS_PATX:
                ld      a,h
                ld      (iy + TRECT.MAPX),a
                ld      a,c
                ld      (IX + TVCMD.CNTX),a
                exx
                call    DRAW_HRECT
                exx
                inc     h
                ld      a,d
                add     a,c
                ret     c
                ld      d,a
                jr      DBACK_LOOP

; === USR0 - Draw Initialize screen ===
INIT:
                ld      ix,VCMD0
                ld      iy,RECT0
                call    COPY_HARD
                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (DISPLAY_PAGE),a
                call    CLEAR_PAGE
                ld      (iy + TRECT.PX),0
                ld      a,(POSY)
                ld      (iy + TRECT.PY),a
                ld      (iy + TRECT.NX),0
                ld      (iy + TRECT.NY),212
                ld      a,(DISPLAY_PAGE)
                ld      (iy + TRECT.PAGE),a
                call    DRAW_RECT
                call   PUT_HARD
                call    SETSCROLL
                call   DRAW_SOFT
                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (iy + TRECT.PAGE),a
                jp      DRAW_BACK_RECT

; === Copy SPRITE COLOR & ATTRIBUTE from 7400h-76FFh to 7000h
; input: IX = VCMD
COPY_HARD:
                ld      a,232
                ld      (ix + TVCMD.SRCY),a
                ld      a,224
                ld      (ix + TVCMD.DESY),a
                ld      a,6
                ld      (ix + TVCMD.CNTY),a
                xor     a
                ld      (ix + TVCMD.DESX),a
                ld      (ix + TVCMD.CNTX),a
                inc     a
                ld      (ix + TVCMD.CNTXH),a
                ld      a,CMDHMMM
                ld      (ix + TVCMD.CMD),a
                call    VDPCOPY
                xor     a
                ld      (ix + TVCMD.CNTXH),a
                ret

; === Draw software sprites ===
; input: POSX, POSY, SPRITE_MODE, DISPLAY_PAGE
; changed: IX IY VCMD0
DRAW_SOFT:
                ld      a,(SPRITE_MODE)
                and     2
                ret     z
                push    ix
                push    iy
                ld      a,(DISPLAY_PAGE)
                ld      (VCMD1.DESPAGE),a
                ld      a,MAP_PAGE
                ld      (VCMD1.SRCPAGE),a
                ld      a,CMDLMMM | LCMD_TIMP
                ld      (VCMD1.CMD),a
                ld      ix,SOFT_SPRITE
                ld      iy,SOFT_HISTORY
                ld      hl,(POSX)
                ld      (OPOSX),hl
                ld      a,l
                and     0Fh
                ld      d,a
                ld      hl,(POSY)
                ld      (OPOSY),hl
                ld      e,l
                ld      a,MAX_SOFT_SPR
DSOFT_NLOOP:
                push    af
                ld      a,(ix + TSOFT.PX)
                cp      240
                ld      b,0
                jr      c,DSOFT_NO_NEGX
                jp      z,DSOFT_NO_SHOW
                sub     240
                ld      (VCMD1.CNTX),a
                ld      (iy + TRECT.NX),a
                cpl
                add     a,17
                ld      b,a
                ld      a,d
                ld      (VCMD1.DESX),a
                ld      (iy + TRECT.PX),a
                jr      DSOFT_NEXT_X
DSOFT_NO_NEGX:
                cp      225
                jr      c,DSOFT_NO_CROPX
                ld      l,a
                add     a,d
                ld      (VCMD1.DESX),a
                ld      (iy + TRECT.PX),a
                ld      a,240
                sub     l
                jr      DSOFT_NX
DSOFT_NO_CROPX:
                add     a,d
                ld      (VCMD1.DESX),a
                ld      (iy + TRECT.PX),a
                ld      a,16
DSOFT_NX:
                ld      (VCMD1.CNTX),a
                ld      (iy + TRECT.NX),a
DSOFT_NEXT_X:
                ld      a,(ix + TSOFT.PY)
                cp      212
                ld      c,0
                jr      c,DSOFT_NO_NEGY
                cp      241
                jp      c,DSOFT_NO_SHOW
                sub     240
                ld      (VCMD1.CNTY),a
                ld      (iy + TRECT.NY),a
                cpl
                add     a,17
                ld      c,a
                ld      a,e
                ld      (VCMD1.DESY),a
                ld      (iy + TRECT.PY),a
                jr      DSOFT_NEXT_Y
DSOFT_NO_NEGY:
                cp      197
                jr      c,DSOFT_NO_CROPY
                ld      l,a
                add     a,e
                ld      (VCMD1.DESY),a
                ld      (iy + TRECT.PY),a
                ld      a,212
                sub     l
                jr      DSOFT_NY
DSOFT_NO_CROPY:
                add     a,e
                ld      (VCMD1.DESY),a
                ld      (iy + TRECT.PY),a
                ld      a,16
DSOFT_NY:
                ld      (VCMD1.CNTY),a
                ld      (iy + TRECT.NY),a
DSOFT_NEXT_Y:
                ld      a,(ix + TSOFT.ID)
                ld      l,a
                and     0Fh
                rlca
                rlca
                rlca
                rlca
                or      b
                ld      (VCMD1.SRCX),a
                ld      a,l
                and     70h
                or      80h
                or      c
                push    ix
                ld      ix,VCMD1
                ld      (ix + TVCMD.SRCY),a
                ld      a,(ix + TVCMD.CNTY)
                ld      b,a
                ld      a,(ix + TVCMD.DESY)
                ld      c,a
                add     a,b
                jr      nc,DSOFT_NO_OVER
                jr      z,DSOFT_NO_OVER
                ld      b,a
                xor     a
                sub     c
                ld      (ix + TVCMD.CNTY),a
                ld      c,a
                push    bc
                call    VDPCOPY
                pop     bc
                ld      a,b
                ld      (ix + TVCMD.CNTY),a
                ld      a,(ix + TVCMD.SRCY)
                add     a,c
                ld      (ix + TVCMD.SRCY),a
                xor     a
                ld      (ix + TVCMD.DESY),a
DSOFT_NO_OVER:
                call    VDPCOPY
                ld      a,(ix + TVCMD.DESPAGE)
                ld      (iy + TRECT.PAGE),a
                ld      bc,SIZE(TRECT)
                add     iy,bc
                pop     ix
DSOFT_NO_SHOW:
                ld      bc,SIZE(TSOFT)
                add     ix,bc
                pop     af
                dec     a
                jp      nz,DSOFT_NLOOP
                xor     a
                ld      (iy + TRECT.NX),a
                pop     iy
                pop     ix
                ret

; === Restore sprites background ===
DRAW_SOFT_BACK:
                ld      a,(SPRITE_MODE)
                and     2
                ret     z
                push    ix
                push    iy
                ld      ix,VCMD1
                ld      iy,SOFT_HISTORY
                ld      b,MAX_SOFT_SPR
DSBACK_LOOP:
                ld      a,(iy + TRECT.NX)
                and     a
                jr     z,DSBACK_END
                push    bc
;               ld      a,(DISPLAY_PAGE)
;               ld      (iy + TRECT.PAGE),a
                call    DRAW_RECT
                ld      bc,SIZE(TRECT)
                add     iy,bc
                pop     bc
                dec     b
                jr      nz,DSBACK_LOOP
DSBACK_END:
                pop     iy
                pop     ix
                ret

; === USR1 - Do scroll with direction (n) ===
SCROLL:
                ld      e,5
                ld      a,(MMVALTYP)
                cp      VALTYPINT
                jp      nz,MSXERROR
                ld      hl,(MMUSRINT)
                ld      a,h
                and     a
                jp      nz,MSXERROR
                ld      a,l
                cp      9
                jp      nc,MSXERROR
                push    af
                call    AUTO_WALK
                pop     af
                ld      de,SCROLLSUB
                rlca
                add     a,e
                ld      e,a
                jr      nc,SCROLLNO1
                inc     d
SCROLLNO1:
                ld      a,(de)
                ld      l,a
                inc     de
                ld      a,(de)
                ld      h,a
                ld      (SCROLL_RT - 2),hl
                ld      a,(AMOUNT)
SCROLL_LOOP:
                push    af
                call    NOSCROLL
SCROLL_RT:
                pop     af
                dec     a
                jr      nz,SCROLL_LOOP
                ret

SCROLLSUB:
                dw      NOSCROLL
                dw      SCROLL_UP
                dw      SCROLL_UPRIGHT
                dw      SCROLL_RIGHT_X
                dw      SCROLL_DOWNRIGHT
                dw      SCROLL_DOWN
                dw      SCROLL_DOWNLEFT
                dw      SCROLL_LEFT_X
                dw      SCROLL_UPLEFT

NOSCROLL:
                ld      b,30
                push    bc
WLOOP:
                call    AUTO_WALK
                ld      a,(HARD_OFFSET)
                xor     1
                ld      (HARD_OFFSET),a
                call    PUT_HARD
                ; call  SET_HARD
                call    DRAW_SOFT_BACK
                call    SETSCROLL
                call    DRAW_SOFT
                
                pop     bc
                dec     b
                jr      nz,WLOOP
                ret

; === Scroll right X ===
SCROLL_RIGHT_X:
                ld      a,(POSX)
                ld      d,a                     ; D = POSX
                ld      a,(SPEED)
                ld      b,a                     ; B = SPEED
                ld      c,1                     ; C = 1
                ld      ix,VCMD0                ; IX = VCMD0
                ld      iy,RECT0                ; IY = RECT0
SRX_PRE:
                ld      a,c
                ld      (RAWSPEED),a            ; RAWSPEED = C
                sla     c                       ; C = C * 2
                rr      b
                jr      c,SRX_BEGIN             ; SPEED == 1, GO
                rr      d
                push    de
                push    bc
                call    c,SRX_BEGIN             ; SCROLL WHEN POSX & 1
                pop     bc
                pop     de
                ld      a,c
                cp      16
                jr      nz,SRX_PRE              ; MULTIPLE SCROLL
                ld      (RAWSPEED),a
SRX_BEGIN:
                ld      hl,(POSY)
                ld      (OPOSY),hl
                ld      hl,(POSX)               ; HL = POSX
                ld      (OPOSX),hl
                ld      (ix + TVCMD.COLOR),0
                ld      a,(RAWSPEED)
                ld      b,a                     ; B = RAWSPEED
                add     a,l
                jr      nc,SRX_NO_INCH
                inc     h
SRX_NO_INCH:
                ld      l,a             ; HL = POSX + RAWSPEED
                ld      a,b
                cpl
                inc     a
                and     l
                ld      l,a
                ld      a,h
                and     7
                ld      h,a             ; POSX = HL = (POSX + RAWSPEED) & -RAWSPEED
                ld      (POSX),hl

                ; Return H = MAPX, L = PATX, D = MAPY, E = PATY
                call    FETCH_XY

                ld      a,(POSY)
                ld      (ix + TVCMD.DESY),a
                ld      a,l
                and     a
                jp      nz,MOVE_RIGHT_X

                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (DISPLAY_PAGE),a
                ld      (ix + TVCMD.DESPAGE),a
                ld      (ix + TVCMD.COLOR),0
                ld      (ix + TVCMD.DESX),240
                ld      (ix + TVCMD.CNTX),16
                push    hl

                ; input: IX = VCMD [DESX, CNTX, COLOR, DESPAGE]
                ; input: IY = RECT
                ; input: POSY
                ; changed: DESY, CNTY, CMD, A, A', BC, HL
                ; changed: RECT [NY, PY]
                call    FILL_HBAR
                
                ld      a,(RAWSPEED)
                dec     a
                jr      z,SRX_1X
                dec     a
                jr      z,SRX_1X
                
                ; 4X
                ld      b,a
                ld      a,224
                ld      (ix + TVCMD.DESX),a
                ld      a,(MAPX)
                add     a,14
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                ld      a,b
SRX_LP:
                push    af

                ; input: IX = VCMD [DESX CNTX DESPAGE]
                ; input: IY = RECT [MAPX]
                ; input: POSY MAPY
                ; changed: RECT [NY, PY, MAPY]
                ; changed: VCMD [SRCX SRCY DESX DESY CNTX CNTY SRCPAGE DESPAGE CMD]
                ; changed: A C DE HL
                call    DRAW_HTILE

                ld      a,(ix + TVCMD.DESX)
                sub     16
                ld      (ix + TVCMD.DESX),a
                ld      a,(iy + TRECT.MAPX)
                dec     a
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                pop     af
                dec     a
                jr      nz,SRX_LP
SRX_1X:
                call    PUT_HARD
                call    SETSCROLL
                call    DRAW_SOFT_BACK
                call    DRAW_SOFT
                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (ix + TVCMD.DESPAGE),a
                pop     hl
                ld      a,h
                inc     a
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                ld      (ix + TVCMD.DESX),0
                push    hl

                ;ld     ix,VCMD0
                call    DRAW_HTILE

                pop     hl
                ld      a,h
                add     a,15
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                ld      (ix + TVCMD.DESX),240

                ;ld     ix,VCMD0
                jp      DRAW_HTILE

; === Move right X ===
; H = MAPX, L = PATX, D = MAPY, E = PATY, B = RAWSPEED
MOVE_RIGHT_X:
                ld      (ix + TVCMD.CNTX),b       ; RAWSPEED
                ld      a,(DISPLAY_PAGE)
                ld      (ix + TVCMD.DESPAGE),a
                xor     1
                ld      (ix + TVCMD.SRCPAGE),a
                ld      a,l
                sub     b
                ld      l,a
                ld      (ix + TVCMD.DESX),a
                push    hl
                call    PUT_HARD
                call    SETSCROLL

                ; input: IX = VCMD [DESX, CNTX, COLOR, DESPAGE]
                ; input: IY = RECT
                ; input: POSY
                ; changed: DESY, CNTY, CMD, A, A', BC, HL
                ; changed: RECT [NY, PY]
                call    FILL_HBAR

                pop     hl
                ld      a,l
                add     a,240
                ld      (ix + TVCMD.SRCX),a
                ld      (ix + TVCMD.DESX),a
                ld      a,(RAWSPEED)
                ld      (ix + TVCMD.CNTX),a
                push    hl

                ; input: IX [SRCX, DESX, CNTX], POSY
                ; input: IY [PX, NX]
                ; changed: A A' BC HL
                call    COPY_HBAR

                call    DRAW_SOFT_BACK
                call    DRAW_SOFT
                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (ix + TVCMD.DESPAGE),a
                ld      a,(MAPX)
                ld      (iy + TRECT.MAPX),a
                call    DRAW_HTILE

                pop     hl
                inc     l
                ld      a,l
                cp      15
                ret     z
                inc     a
                add     a,h
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                ld      a,l
                rlca
                rlca
                rlca
                rlca
                and     0F0h
                ;ld     ix,VCMD0
                ld      (ix + TVCMD.DESX),a
                ld      (ix + TVCMD.CNTX),16
                ld      a,(RAWSPEED)
MRX_LP:
                push    af
                call    DRAW_HTILE
                ld      a,(ix + TVCMD.DESX)
                add     a,16
                ld      (ix + TVCMD.DESX),a
                ld      a,(iy + TRECT.MAPX)
                inc     a
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                pop     af
                dec     a
                jr      nz,MRX_LP
                ret

; === Scroll left X ===
SCROLL_LEFT_X:
                ld      ix,VCMD0
                ld      iy,RECT0
                ld      a,(POSX)
                ld      d,a
                ld      a,(SPEED)
                ld      b,a
                ld      c,1
SLX_PRE:
                ld      a,c
                ld      (RAWSPEED),a
                sla     c
                rr      b
                jr      c,SLX_BEGIN
                rr      d
                push    de
                push    bc
                call    c,SLX_BEGIN
                pop     bc
                pop     de
                ld      a,c
                cp      16
                jr      nz,SLX_PRE
                ld      (RAWSPEED),a
SLX_BEGIN:
                ld      hl,(POSY)
                ld      (OPOSY),hl
                ld      hl,(POSX)
                ld      (OPOSX),hl
                ld      a,(RAWSPEED)
                ld      c,a
                ld      b,0
                add     hl,bc
                dec     hl
                cpl
                inc     a
                and     l
                ld      l,a
                and     a
                sbc     hl,bc
                ld      a,h
                and     7
                ld      h,a
                ld      (POSX),hl
                call    FETCH_XY
                ld      a,(POSY)
                ld      (ix + TVCMD.DESY),a
                ld      a,l
                add     a,c
                cp      16
                jp      nz,MOVE_LEFT_X

                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (DISPLAY_PAGE),a
                ld      (ix + TVCMD.DESPAGE),a
                xor     a
                ld      (ix + TVCMD.DESX),a
                ld      (ix + TVCMD.COLOR),a
                ld      a,16
                sub     c
                ld      (ix + TVCMD.CNTX),a
                push    hl
                ; ld    a,(ix + TVCMD.CNTX)
                ; and   a
                call    nz,FILL_HBAR
                ld      a,(RAWSPEED)
                ld      (ix + TVCMD.CNTX),a
                cpl
                inc     a
                ld      (ix + TVCMD.DESX),a
                call    FILL_HBAR
                pop     hl

                ld      a,(RAWSPEED)
                ld      b,a
                ld      a,16
                sub     b
                ld      (ix + TVCMD.DESX),a
                push    hl
                ld      a,(MAPX)
                ld      (iy + TRECT.MAPX),a

                ;ld      ix,VCMD0
                call    DRAW_HTILE

                ld      a,(ix + TVCMD.DESX)
                ld      (ix + TVCMD.CNTX),a
                and     a
                jr      z,SLX_NO_COPY
                ld      a,240
                ld      (ix + TVCMD.DESX),a
                pop     hl
                ld      a,h
                add     a,15
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                push    hl

                ;ld      ix,VCMD0
                call    DRAW_HTILE
SLX_NO_COPY:
                call    PUT_HARD
                call    SETSCROLL
                call    DRAW_SOFT_BACK
                call    DRAW_SOFT
                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (ix + TVCMD.DESPAGE),a
                ld      a,(ix + TVCMD.CNTX)
                and     a
                jr      z,SLX_SKIP_COPY
                pop     hl
                ld      a,h
                ld      (iy + TRECT.MAPX),a
                push    hl

                ;ld      ix,VCMD0
                call    DRAW_HTILE
SLX_SKIP_COPY:
                pop     hl
                ld      a,h
                add     a,15
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                ld      a,(RAWSPEED)
                ld      (ix + TVCMD.CNTX),a
                cpl
                inc     a
                ld      (ix + TVCMD.DESX),a

                ;ld      ix,VCMD0
                call    DRAW_HTILE
                
                ld      a,(RAWSPEED)
                dec     a
                ret     z
                dec     a
                ret     z
                ld      b,a
                ld      a,16
                ld      (ix + TVCMD.CNTX),a
                ld      a,224
                ld      (ix + TVCMD.DESX),a
                ld      a,(iy + TRECT.MAPX)
                dec     a
                dec     a
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                ld      a,b
SLX_LP:
                push    af

                ;ld      ix,VCMD0
                call    DRAW_HTILE

                ld      a,(ix + TVCMD.DESX)
                sub     16
                ld      (ix + TVCMD.DESX),a
                ld      a,(iy + TRECT.MAPX)
                dec     a
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                pop     af
                dec     a
                jr      nz,SLX_LP
                ret

; === Move left X ===
MOVE_LEFT_X:
                ld      ix,VCMD0
                ld      iy,RECT0
                ld      a,(DISPLAY_PAGE)
                ld      (ix + TVCMD.DESPAGE),a
                xor     1
                ld      (ix + TVCMD.SRCPAGE),a
                ld      (ix + TVCMD.COLOR),0
                ld      a,(RAWSPEED)
                ld      (ix + TVCMD.CNTX),a
                ld      b,a
                ld      a,l
                add     a,240
                ld      (ix + TVCMD.DESX),a
                push    hl
                call    PUT_HARD
                call    SETSCROLL
                call    FILL_HBAR
                pop     hl
                ld      a,l
                ld      (ix + TVCMD.DESX),a
                add     a,240
                ld      (ix + TVCMD.SRCX),a
                ld      a,(RAWSPEED)
                ld      (ix + TVCMD.CNTX),a
                push    hl

                ; input: IX [SRCX, DESX, CNTX], POSY
                ; input: IY [PX, NX]
                ; changed: A A' BC HL
                call    COPY_HBAR

                call    DRAW_SOFT_BACK
                call    DRAW_SOFT

;                ld      ix,VCMD0
;                ld      iy,RECT0
                pop     hl
                ld      a,l
                add     a,240
                ld      (ix + TVCMD.DESX),a
                ld      a,(ix + TVCMD.SRCPAGE)
                ld      (ix + TVCMD.DESPAGE),a
                ld      a,h
                add     a,15
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                push    hl

                call    DRAW_HTILE

                pop     hl

                ld      a,16
                ld      (ix + TVCMD.CNTX),a
                
                ld      a,l
                cp      14
                ret     z

                add     a,h
                and     7Fh
                ld      (iy + TRECT.MAPX),a
                ld      h,a
                ld      a,l
                inc     a
                rlca
                rlca
                rlca
                rlca
                and     0F0h
                ld      l,a
                ld      (ix + TVCMD.DESX),a
                ld      a,(RAWSPEED)
                ld      l,a
MLX_LP:
                push    hl

                call    DRAW_HTILE

                pop     hl
                ld      a,(ix + TVCMD.DESX)
                add     a,16
                ld      (ix + TVCMD.DESX),a
                inc     h
                ld      a,h
                ld      (iy + TRECT.MAPX),a
                dec     l
                jr      nz,MLX_LP
                ret

; === Step down ===
STEP_DOWN_X:
                ; ld    a,(POSY)
                ; ld    d,a
                ld      a,(SPEED)
                ; ld    b,a
                ; ld    c,1
SDX_PRE:
                ; ld    a,c
                ; ld    (RAWSPEED),a
                ; sla   c
                ; rr    b
                ; jr    c,SDX_BEGIN
                ; rr    d
                ; push  de
                ; push  bc
                ; call  c,SDX_BEGIN
                ; pop   bc
                ; pop   de
                ; ld    a,c
                ; cp    16
                ; jr    nz,SDX_PRE
                ; ld    (RAWSPEED),a
                ld      (RAWSPEED),a
SDX_BEGIN:
                ld      hl,(POSY)
                ld      a,(RAWSPEED)
                ld      c,a
                ld      b,0
                add     hl,bc
                cpl
                inc     a
                and     l
                ld      l,a
                ld      a,h
                and     7
                ld      h,a
                ld      (POSY),hl
                
                ld      a,(RAWSPEED)
                ld      b,a
                ld      a,(POSY)
                add     a,212
                sub     b
                ld      ix,VCMD0
                ld      iy,RECT0
                ld      (iy + TRECT.PX),0
                ld      (iy + TRECT.PY),a
                ld      (iy + TRECT.NX),0
                ld      (iy + TRECT.NY),b
                ld      a,(DISPLAY_PAGE)
                ld      (iy + TRECT.PAGE),a
                call    DRAW_RECT
                
                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (iy + TRECT.PAGE),a

                jp      DRAW_BACK_RECT
                ret

; === Step up ===
STEP_UP:
                ld      a,(SPEED)
                ld      (RAWSPEED),a
STX_BEGIN:
                ld      hl,(POSY)
                ld      a,(RAWSPEED)
                ld      c,a
                ld      b,0
                and     a
                sbc     hl,bc
                cpl
                inc     a
                and     l
                ld      l,a
                ld      a,h
                and     7
                ld      h,a
                ld      (POSY),hl

                ld      a,(RAWSPEED)
                ld      b,a
                ld      a,(POSY)
                ld      ix,VCMD0
                ld      iy,RECT0
                ld      (iy + TRECT.PX),0
                ld      (iy + TRECT.PY),a
                ld      (iy + TRECT.NX),0
                ld      (iy + TRECT.NY),b
                ld      a,(DISPLAY_PAGE)
                ld      (iy + TRECT.PAGE),a
                call    DRAW_RECT
                
                ld      a,(DISPLAY_PAGE)
                xor     1
                ld      (iy + TRECT.PAGE),a
                jp      DRAW_BACK_RECT

; === Scroll up ===
SCROLL_UP:
                call    STEP_UP
                call    PUT_HARD
                call    SETSCROLL
                call    DRAW_SOFT_BACK
                jp      DRAW_SOFT
                
; === Scroll down ===
SCROLL_DOWN:
                call    STEP_DOWN_X
                call    PUT_HARD
                call    SETSCROLL
                call    DRAW_SOFT_BACK
                jp      DRAW_SOFT
                
; === Scroll up right ===
SCROLL_UPRIGHT:
                call    STEP_UP
                jp      SCROLL_RIGHT_X
                
; === Scroll down right ===
SCROLL_DOWNRIGHT:
                call    STEP_DOWN_X
                jp      SCROLL_RIGHT_X
                
; === Scroll down left ===
SCROLL_DOWNLEFT:
                call    STEP_DOWN_X
                jp      SCROLL_LEFT_X
                
; === Scroll up left ===
SCROLL_UPLEFT:
                call    STEP_UP
                jp      SCROLL_LEFT_X
                
; === Read MAP at 0000h ===
; input: H = MAPY, L = MAPX
; return: A = Data
; changed: B = Port(0FEh), C = 0FEh, HL = Address
GET_MAP:
                ld      a,h
                rl      l
                rra
                rr      l
                and     3Fh
                or      80h
                ld      h,a
                ld      c,0FEh
                di
                in      b,(c)
                ld      a,MAP_SLOT
                out     (c),a
                ld      a,(hl)
                out     (c),b
                ei
                ret

; === Read MAP datas vertically ===
; input: H = MAPY, L = MAPX, C = Count, D = X offset, E = Y offset
; return: MAP_BUFFER: [NY] [SX] [SY], NY:0 = end
; changed: A, A', BC, DE, HL
GET_VMAP:
                push    ix
                dec     c
                ld      a,16
                sub     e
                dec     a
                cp      c
                jr      c,GETVM_NO_CROP
                ld      a,c
GETVM_NO_CROP:
                inc     a
                ld      b,a             ; B = NY

                rl      l
                res     7,h
                scf
                rr      h
                rr      l               ; HL = Map address 8000h
                ld      ix,MAP_BUFFER

                di
                in      a,(0FEh)
                ex      af,af'
                ld      a,MAP_SLOT
                out     (0FEh),a
GETVM_LOOP:
                ld      (ix + TMAPBUF.NY),b
                ld      a,(hl)
                rla
                rl      e
                rla
                rl      e
                rla
                rl      e
                rla
                rl      e
                and     $F0
                or      d
                ld      (ix + TMAPBUF.SRCX),a
                ld      a,e
                rlca
                rlca
                rlca
                rlca
                ld      (ix + TMAPBUF.SRCY),a
                push    bc
                ld      bc,SIZE(TMAPBUF)
                add     ix,bc
                pop     bc
                
                ld      a,l
                add     a,128
                ld      l,a
                jr      nc,GETVM_NO_INC
                inc     h
GETVM_NO_INC:
                ld      a,h
                and     3Fh
                or      80h
                ld      h,a
                ld      a,c
                inc     a
                sub     b
                jr      z,GETVM_END
                dec     a
                ld      c,a
                ld      a,15
                cp      c
                jr      c,GETVM_NOT_LAST
                ld      a,c
GETVM_NOT_LAST:
                inc     a
                ld      b,a
                ld      e,0
                jr      GETVM_LOOP
GETVM_END:
                ld      (ix + TMAPBUF.NY),a
                ex      af,af'
                out     (0FEh),a
                ei
                pop     ix
                ret

; === Store/Restore TILE/SPRITE with RAM mapper ===
; A: (PAGE * 2) or (0 = Y0 / 1 = Y128), B: RAM page (0-7)
TILE_STORE:
                ld      c,0
                jr      TILE_MAPPER
TILE_RESTORE:
                ld      c,$40
TILE_MAPPER:
                and     7
                di
                out     (VDPPORT),a
                ld      a,SELRG14
                out     (VDPPORT),a
                ld      a,0
                out     (VDPPORT),a
                ld      a,c
                out     (VDPPORT),a
                and     a
                ex      af,af'
                ld      c,0FEh
                ld      a,b
                in      b,(c)
                out     (c),a
                ld      hl,8000h
                ld      de,0000h        ; d = col block offset, e = line offset
                ld      c,0             ; c = row block offset
TILES_LOOP:
                ex      af,af'
                jr      nz,TILES_RES
                in      a,(VRAMPORT)
                ld      (hl),a
                jr      TILES_GO
TILES_RES:
                ld      a,(hl)
                out     (VRAMPORT),a
TILES_GO:
                ex      af,af'
                inc     hl
                ld      a,l
                and     7
                jr      nz,TILES_LOOP
                ld      a,d
                inc     a
                cp      16
                jr      z,TILES_NEXT_LINE
                ld      d,a
                ld      a,l
                add     a,120
                ld      l,a
                jr      nc,TILES_LOOP
                inc     h
                jr      TILES_LOOP
TILES_NEXT_LINE:
                ld      d,0
                ld      a,e
                inc     a
                cp      16
                jr      z,TILES_NEXT_ROW
                ld      e,a
                rlca
                rlca
                rlca
                ld      l,a
                ld      a,c
                rlca
                rlca
                rlca
                or      $80
                ld      h,a
                jr      TILES_LOOP
TILES_NEXT_ROW:
                ld      e,0
                ld      a,c
                inc     a
                cp      8
                jr      z,TILES_END
                ld      c,a
                rlca
                rlca
                rlca
                or      $80
                ld      h,a
                ld      l,0
                jr      TILES_LOOP
TILES_END:
                ld      c,0FEh
                out     (c),b
                ei
                ret

; === Store data to RAM mapper ===
; A: (PAGE * 2) or (0 = Y0 / 1 = Y128), B: RAM page (0-7)
RAM_STORE:
                and     7
                di
                out     (VDPPORT),a
                ld      a,SELRG14
                out     (VDPPORT),a
                ld      a,0
                out     (VDPPORT),a
                ld      a,0
                out     (VDPPORT),a
                ld      c,0FEh
                ld      a,b
                in      b,(c)
                out     (c),a
                ld      hl,8000h
                ld      de,4000h
RAMS_LOOP:
                in      a,(VRAMPORT)
                ld      (hl),a
                inc     hl
                dec     de
                ld      a,d
                or      e
                jr      nz,RAMS_LOOP
                out     (c),b
                ei
                ret

; === Restore data from RAM mapper ===
; A: (PAGE * 2) or (0 = Y0 / 1 = Y128), B: RAM page (0-7)
RAM_RESTORE:
                and     7
                di
                out     (VDPPORT),a
                ld      a,SELRG14
                out     (VDPPORT),a
                ld      a,0
                out     (VDPPORT),a
                ld      a,40h
                out     (VDPPORT),a
                ld      c,0FEh
                ld      a,b
                in      b,(c)
                out     (c),a
                ld      hl,8000h
                ld      de,4000h
RAMR_LOOP:
                ld      a,(hl)
                out     (VRAMPORT),a
                inc     hl
                dec     de
                ld      a,d
                or      e
                jr      nz,RAMR_LOOP
                out     (c),b
                ei
                ret

; === Store MAPS/TILES/SPRITES to RAM ===
DATA_STORE:
                ld      ix,VCMD0
                call    COPY_HARD

                ld      a,MAP_PAGE * 2
                ld      b,MAP_SLOT
                call    z,RAM_STORE
                
                ld      a,MAP_PAGE * 2 | 1
                ld      b,SPR_SLOT
                call    TILE_STORE

                ld      a,TILE_PAGE * 2
                ld      b,TILE_SLOT
                call    TILE_STORE

                ld      a,TILE_PAGE * 2 | 1
                ld      b,TILE_SLOT + 1
                call    TILE_STORE

                ld      a,1
                ld      (READY),a
                ret

; === Restore MAPS/TILES/SPRITES from RAM ===
DATA_RESTORE:
                ld      a,MAP_PAGE * 2
                ld      b,MAP_SLOT
                call    z,RAM_RESTORE
                
                ld      a,MAP_PAGE * 2 | 1
                ld      b,SPR_SLOT
                call    TILE_RESTORE

                ld      a,TILE_PAGE * 2
                ld      b,TILE_SLOT
                call    TILE_RESTORE

                ld      a,TILE_PAGE * 2 | 1
                ld      b,TILE_SLOT + 1
                call    TILE_RESTORE

                ret
                
; === Clear display page ===
CLEAR_DISPLAY:
                ld      ix,VCMD0
                ld      a,(MMDPPAGE)
                jp      CLEAR_PAGE

; === Sprite Walk ===
SPRWALK:
                ld      e,5
                ld      a,(MMVALTYP)
                cp      VALTYPINT
                jp      nz,MSXERROR
                ld      hl,(MMUSRINT)
                ld      a,h
                or      l
                call    nz,SWALK_CONTROL
AUTO_WALK:
                ld      hl,(WALKTIME)
                inc     hl
                ld      (WALKTIME),hl
                ld      a,l
                and     $3
                ret     nz

                ld      hl,HARD_SPRITE + 2
                ld      b,32
HWALK_LP:
                ld      a,(hl)
                xor     2
                ld      (hl),a
                inc     hl
                inc     hl
                inc     hl
                inc     hl
                djnz    HWALK_LP

                ld      ix,SOFT_SPRITE
                ld      b,MAX_SOFT_SPR
                ld      de,SIZE(TSOFT)
SWALK_LP:
                ld      a,(ix + TSOFT.ID)
                xor     1
                ld      (ix + TSOFT.ID),a
                add     ix,de
                djnz    SWALK_LP
                ret

; === Sprite walk with control ===
SWALK_CONTROL:
                ld      ix,SOFT_SPRITE
                ld      de,SIZE(TSOFT)
                ld      b,MAX_SOFT_SPR
SOFTWALK_LP:
                inc     (ix + TSOFT.PX)
                inc     (ix + TSOFT.PX)
                inc     (ix + TSOFT.PX)
                inc     (ix + TSOFT.PY)
                add     ix,de
                djnz    SOFTWALK_LP
                dec     a
                jr      nz,SWALK_CONTROL
                ret

; === TEST ROUTINE ===
TESTDATA:       dw      MAP_BUFFER
TESTBUF:        dw      SOFT_HISTORY
TESTNX:         dw      0               ; CNTX
TESTNY:         dw      0               ; CNTY
TESTX:          dw      1023
TESTY:          dw      1023

; input: IX = VCMD [DESX, CNTX, COLOR, DESPAGE]
; input: IY [TRECT.NY] [TRECT.PY]
; changed: DESY, CNTY, CMD, A, A', BC, HL
TESTAREA:
                ld      e,5
                ld      a,(MMVALTYP)
                cp      VALTYPINT
                jp      nz,MSXERROR

                ld      ix,VCMD0
                ld      iy,RECT0

                call    CLEAR_DISPLAY

                ld      hl,(TESTX)
                inc     hl
                ld      (TESTX),hl
                ld      (POSX),hl
                ld      hl,(TESTY)
                inc     hl
                ld      (TESTY),hl
                ld      (POSY),hl
                ;call   FETCH_XY

                ld      (iy + TRECT.PAGE),2
                ld      (iy + TRECT.PX),128
                ld      (iy + TRECT.PY),40
                ld      (iy + TRECT.NX),100
                ld      (iy + TRECT.NY),100
                ld      (ix + TVCMD.COLOR),66h
                call    FILL_AREA

                ld      (iy + TRECT.PAGE),2
                ld      (iy + TRECT.PX),128
                ld      (iy + TRECT.PY),40
                ld      (iy + TRECT.NX),100
                ld      (iy + TRECT.NY),100
                ld      (ix + TVCMD.COLOR),0FFh
                call    FILL_AREA

                ld      (iy + TRECT.PX),10
                ld      (iy + TRECT.PY),10
                ld      (iy + TRECT.NX),20
                ld      (iy + TRECT.NY),30
                ld      (ix + TVCMD.COLOR),55h
                call    FILL_AREA

                ld      (iy + TRECT.PX),21
                ld      (iy + TRECT.PY),100
                ld      (iy + TRECT.NX),200
                ld      (iy + TRECT.NY),112
                ld      (ix + TVCMD.COLOR),0CCh
                call    FILL_AREA

                ld      ix,VCMD0
                ld      iy,RECT0
                ld      a,(DISPLAY_PAGE)
                ld      (ix + TVCMD.DESPAGE),a
                ld      (ix + TVCMD.DESX),0
                ld      (ix + TVCMD.CNTX),16
                ld      a,(POSY)
                ld      (iy + TRECT.PY),a
                ld      (iy + TRECT.NY),212
                ; input: IX = VCMD [DESX CNTX MAPX MAPY DESPAGE]
                ; input: IY = RECT [NY PY]
                ; changed: A C DE HL SRCX SRCY DESX DESY
                ; changed: CNTX CNTY SRCPAGE DESPAGE CMD
                call    DRAW_HRECT

                ld      ix,VCMD0
                ld      iy,RECT0
                ld      a,(DISPLAY_PAGE)
                ld      (iy + TRECT.PAGE),a
                ld      (iy + TRECT.PX),0
                ld      (iy + TRECT.PY),0
                ld      (iy + TRECT.NX),0
                ld      (iy + TRECT.NY),212

                ; input: IX = VCMD [DESX CNTX MAPX MAPY DESPAGE]
                ; input: IY = RECT [NY PY]
                ; changed: A C DE HL SRCX SRCY DESX DESY
                ; changed: CNTX CNTY SRCPAGE DESPAGE CMD
                call    DRAW_AREA

                ld      (iy + TRECT.PX),97
                ld      (iy + TRECT.PY),97
                ld      (iy + TRECT.NX),65
                ld      (iy + TRECT.NY),65
                ld      (ix + TVCMD.COLOR),$36
                call    FILL_RECT
                call    DRAW_SOFT

                ld      hl,(VCMD0.CNTX)
                ld      (TESTNX),hl
                ld      hl,(VCMD0.CNTY)
                ld      (TESTNY),hl
                ld      hl,TESTDATA
                ld      (MMUSRINT),hl
                ret

;=== Change sprite mode ===
CHANGE_SPRITE_MODE:
                ld      e,5
                ld      a,(MMVALTYP)
                cp      VALTYPINT
                jp      nz,MSXERROR
                ld      hl,(MMUSRINT)
                ld      a,h
                and     a
                jp      nz,MSXERROR
                ld      a,l
                cp      4
                jp      nc,MSXERROR
                ld      (SPRITE_MODE),a
                and     1
                jr      z,SPR_CLR_HARD
                call    PUT_HARD
                jr      SPR_CHK_SOFT
SPR_CLR_HARD:
                call    CLEAR_HARD
SPR_CHK_SOFT:
                call    DRAW_SOFT_BACK
                ld      a,(SPRITE_MODE)
                and     2
                jp      nz,DRAW_SOFT
                ret

;=== Store/Restore DATA with RAM ===
USER5:
                ld      e,5
                ld      a,(MMVALTYP)
                cp      VALTYPINT
                jp      nz,MSXERROR
                ld      hl,(MMUSRINT)
                ld      a,h
                and     a
                jp      nz,MSXERROR
                ld      a,l
                cp      2
                jp      nc,MSXERROR
                and     a
                jp      nz,DATA_STORE
                jp      DATA_RESTORE

;=== Draw UI ===
; input: 0 = remove, 1 = draw
DRAW_UI:
                ld      e,5
                ld      a,(MMVALTYP)
                cp      VALTYPINT
                jp      nz,MSXERROR
                ld      hl,(MMUSRINT)
                ld      a,h
                and     a
                jp      nz,MSXERROR
                ld      a,l
                cp      2
                jp      nc,MSXERROR
                and     a
                ld      ix,VCMD0
                ld      iy,RECT_AREA
                jr      z,UI_REMOVE
                ld      a,(MMDPPAGE)
                ld      (iy + TRECT.PAGE),a
                ld      (iy + TRECT.PX),10
                ld      (iy + TRECT.PY),10
                ld      (iy + TRECT.NX),100
                ld      (iy + TRECT.NY),80
                ld      (ix + TVCMD.COLOR),0
                call    FILL_AREA
                ret
UI_REMOVE:
                ld      a,(MMDPPAGE)
                ld      (iy + TRECT.PAGE),a
                ld      (iy + TRECT.PX),10
                ld      (iy + TRECT.PY),10
                ld      (iy + TRECT.NX),100
                ld      (iy + TRECT.NY),80
                call    DRAW_AREA
                ret
                
;=== Draw/Erase Soft sprite ===
USER7:
                ld      e,5
                ld      a,(MMVALTYP)
                cp      VALTYPINT
                jp      nz,MSXERROR
                ld      hl,(MMUSRINT)
                ld      a,h
                or      l
                jp      z,DRAW_SOFT_BACK
                jp      DRAW_SOFT
                
;=== Initialize USR routines ===
ADDRUSR0        equ     INIT
ADDRUSR1        equ     SCROLL
ADDRUSR2        equ     SETVPAGE
ADDRUSR3        equ     SPRWALK
ADDRUSR4        equ     TESTAREA
ADDRUSR5        equ     USER5                   ; Store/Restore DATA with RAM
ADDRUSR6        equ     DRAW_UI                 ; Draw UI
ADDRUSR7        equ     USER7                   ; Draw/Erase Soft sprites
ADDRUSR8        equ     CLEAR_DISPLAY
ADDRUSR9        equ     CHANGE_SPRITE_MODE      ; 0:None/1:Hard/2:Soft/3:Hard&Soft

PROGRUN:
                ld      hl,ADDRUSR0
                ld      (MMUSRTAB + 0),hl
                ld      hl,ADDRUSR1
                ld      (MMUSRTAB + 2),hl
                ld      hl,ADDRUSR2
                ld      (MMUSRTAB + 4),hl
                ld      hl,ADDRUSR3
                ld      (MMUSRTAB + 6),hl
                ld      hl,ADDRUSR4
                ld      (MMUSRTAB + 8),hl
                ld      hl,ADDRUSR5
                ld      (MMUSRTAB + 10),hl
                ld      hl,ADDRUSR6
                ld      (MMUSRTAB + 12),hl
                ld      hl,ADDRUSR7
                ld      (MMUSRTAB + 14),hl
                ld      hl,ADDRUSR8
                ld      (MMUSRTAB + 16),hl
                ld      hl,ADDRUSR9
                ld      (MMUSRTAB + 18),hl
                ret
               
PROGEND: