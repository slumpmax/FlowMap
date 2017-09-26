; Byte References

VALTYPINT	equ	2
VALTYPSTR	equ	3
VALTYPSNG	equ	4
VALTYPDBL	equ	5

; VDP Commands
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

; VDP Command Logical Operations
LCMD_IMP	equ	00h	; DES = SRC
LCMD_AND	equ	01h	; DES = SRC and DES
LCMD_OR		equ	02h	; DES = SRC or DES
LCMD_EOR	equ	03h	; DES = SRC xor DES
LCMD_NOT	equ	04h	; DES = not SRC
LCMD_TIMP	equ	08h	; Ignore CL0, DES = SRC
LCMD_TAND	equ	09h	; Ignore CL0, DES = SRC and DES
LCMD_TOR	equ	0Ah	; Ignore CL0, DES = SRC or DES
LCMD_TEOR	equ	0Bh	; Ignore CL0, DES = SRC xor DES
LCMD_TNOT	equ	0Ch	; Ignore CL0, DES = not SRC

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
