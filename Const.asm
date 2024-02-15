;************************************************************************
;* Costanti
;************************************************************************

;---------------------------------------------------
; Standard TV
NTSC        = 0
PAL         = 1
SECAM       = 2
SYSTEM      = PAL

	;---------------------------------------------------
	; NTSC
    IF SYSTEM == NTSC
; Vertical Blank scan lines
VBlankSL    = 37
; TV Picture scan lines
PictureSL   = 192
; Overscan scan lines
OverSSL     = 30
	;---------------------------------------------------
	; PAL
    ELSE
        IF SYSTEM == PAL
; Vertical Blank scan lines
VBlankSL    = 45
; TV Picture scan lines
PictureSL   = 228
; Overscan scan lines
OverSSL     = 36
        ;---------------------------------------------------
        ; SECAM
        ELSE
            IF SYSTEM == SECAM
; Vertical Blank scan lines
VBlankSL    = 45
; TV Picture scan lines
PictureSL   = 228
; Overscan scan lines
OverSSL     = 36
            ELSE
                ECHO "UNKNOWN TV SYSTEM"
            ENDIF
        ENDIF
    ENDIF

; Vertical Blank TIM64T ticks
T64VBlank   = VBlankSL * 76 / 64
; Overscan TIM64 ticks
T64OverS    = OverSSL * 76 / 64

;---------------------------------------------------
; Colori
	;---------------------------------------------------
	; NTSC
    IF SYSTEM == NTSC
Yellow      = $1C
LightGray   = $0C
DarkGray    = $02
Gray        = $04
Cyan        = $AE
Green       = $C8
Violet      = $56
Red         = $40
Blue        = $84
Black       = $00
DarkBlue    = $80
White       = $0E
DarkViolet  = $60
    ELSE
        IF SYSTEM == PAL
Yellow      = $2E
LightGray   = $0E
DarkGray    = $02
Gray        = $04
Cyan        = $7F
Green       = $5A
Violet      = $86
Red         = $66
Blue        = $D4
Black       = $00
DarkBlue    = $B0
White       = $0E
DarkViolet  = $A0
        ELSE
            IF SYSTEM == SECAM
Yellow      = $0C
LightGray   = $0E
DarkGray    = $00
Gray        = $00
Cyan        = $0A
Green       = $08
Violet      = $06
Red         = $04
Blue        = $02
Black       = $00
DarkBlue    = $02
White       = $0E
DarkViolet  = $06
            ENDIF
        ENDIF
    ENDIF
