;************************************************************************
;* Costanti
;************************************************************************

; Standard TV
PAL         = 1

    IFNCONST PAL
; NTSC
ScanLines   = 192
T64VBlank   = 43
T64Overscan = 35
    ELSE
; PAL
ScanLines   = 228
T64VBlank   = 53
T64Overscan = 42
    ENDIF