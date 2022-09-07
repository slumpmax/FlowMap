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

; === Execute V9938 command ===
VDPCOPY:
                ld      a,20h
                ld      b,15
                push    ix
                pop     hl
                di
                out     (VDPPORT),a
                ld      a,SELRG17
                ei
                out     (VDPPORT),a
                ld      c,CMDPORT
VDPCOPY_WAIT:
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
                jr      c,VDPCOPY_WAIT
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
                outi
                outi
                outi
                outi
                ret

; === Execute V9938 command ===
VDPFILL:
                ld      a,24h
                ld      b,11
                push    ix
                pop     hl
                inc     hl
                inc     hl
                inc     hl
                inc     hl
                di
                out     (VDPPORT),a
                ld      a,SELRG17
                ei
                out     (VDPPORT),a
                ld      c,CMDPORT
VDPFILL_WAIT:
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
                jr      c,VDPFILL_WAIT

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
