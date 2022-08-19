TRECT class {
    NX:         db      0,1,100
    NY:         dw      3,30
    PX:         dd      0
    PY:         dq      0
    PAGE:       ds      0
    MAPX:       ds      10,2
    MAPY:       db      0
    PATX:       db      0
    PATY:       db      0
}
RECT0:  object  TRECT
RECT1   object  TRECT

    ld      hl,RECT1
    ld      bc,RECT1.PAGE
    ld      a,TRECT.PAGE
    ld      b,SIZE(TRECT)
