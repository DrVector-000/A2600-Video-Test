TitleScreen SUBROUTINE
	;---------------------------------------------------
	; Vetical sync
	JSR FrameStart
	
	;---------------------------------------------------
    ; Vertical Blank
	; NTSC 37 Scan lines
	; PAL SECAM 45 Scan lines
	LDA	#$01
    STA	VBLANK          ; Start VBLANK
	
	LDA #T64VBlank
    STA TIM64T
.waitvb	
	LDA INTIM
	BNE .waitvb

	LDA	#$00
    STA	VBLANK          ; Stop VBLANK

	;---------------------------------------------------
    ; Kernal
	; NTSC 192 Scan lines
	; PAL SECAM 228 Scan lines
	IF SYSTEM == NTSC
		; 10 WSYNC
		LDA #$0A
	ELSE
		; 20 WSYNC
		LDA #$14
	ENDIF
	STA _nSync
	JSR WaitSync
    
	; Riga gialla
	LDA #Yellow
    STA	COLUBK

    STA WSYNC
    LDA	#$00
    STA	COLUBK

	; 2 WSYNC
	STA WSYNC
	STA WSYNC

	; Scrive titolo
	; 11 WSYNC
	JSR PrintTitle
	
	; 2 WSYNC
	STA WSYNC
	STA WSYNC

	; Riga gialla
	LDA #Yellow
    STA	COLUBK

	; 2 WSYNC
    STA WSYNC
    LDA	#$00
    STA	COLUBK
	STA WSYNC

	IF SYSTEM == NTSC
		; 123 WSYNC
		LDA #$7B
	ELSE
		; 149 WSYNC
		LDA #$95
	ENDIF
	STA _nSync
	JSR WaitSync

	; disegna "tubo rotante" :)
	; 41 WSYNC
	JSR DrawPipe

	;---------------------------------------------------
    ; Overscan
	; NTSC 30 Scan lines
	; PAL SECAM 36 Scan lines
	LDA #T64OverS
    STA TIM64T
.waitovs	
	LDA INTIM
	BNE .waitovs

    RTS

DrawPipe SUBROUTINE
    LDA _frameCounter
    AND #$0F
    BNE .draw

    INC _indexFirstColor
    LDA _indexFirstColor
    CMP #$08
    BNE .draw
    LDA #$00
    STA _indexFirstColor

.draw
	LDY _indexFirstColor
	STY _tempIndex
.drawcolor
	LDA GrayScaleCols,Y
	STA _color

	JSR DrawColorLine
	JSR NextColor
	JSR DrawColorLine
	JSR NextColor
	JSR DrawColorLine
	JSR NextColor
	JSR DrawColorLine
	JSR NextColor
	JSR DrawColorLine
	JSR NextColor
	JSR DrawColorLine
	JSR NextColor
	JSR DrawColorLine
	JSR NextColor
	JSR DrawColorLine

	; 34 WSYNC
	;LDA #$22
	;STA _nSync
	;JSR WaitSync

	STA WSYNC

.exit	
	; Colore nero
    LDA	#$00		; (2)
    STA	COLUBK		; (3)

	RTS

NextColor SUBROUTINE
	INC _tempIndex
    LDA _tempIndex
    CMP #$08
    BNE .exit
    LDA #$00
    STA _tempIndex

.exit
	LDY _tempIndex
	LDA GrayScaleCols,Y
	STA _color
	RTS

DrawColorLine SUBROUTINE
	LDX #$00
.loop
	STA WSYNC
	LDA _color
	STA COLUBK

	INX
	CPX #$05
	BNE .loop
	
	RTS

;****************************************************************************
; Print Title
;****************************************************************************
PrintTitle SUBROUTINE
	; Colore giallo
    LDA #Yellow
    STA	COLUPF
	
	LDX #$00
	LDY #$00
loop
	STA WSYNC

	LDA Title,y
	STA PF0

	INY
	LDA Title,y
	STA PF1

	INY
	LDA Title,y
	STA PF2

	INY
	LDA Title,y
	STA PF0

	INY
	LDA Title,y
	STA PF1

	INY
	LDA Title,y
	STA PF2

	INY
	INX
	CPX #$0A
	BNE loop

	LDA #$00
	STA PF0
	STA PF1
	STA PF2
	STA WSYNC
	STA WSYNC

	RTS

Title
	.byte $40,$2B,$EC,$80,$DB,$1D ;|  X   X X XX  XX XXX||   XXX XX XXX XXX   | ( 25)
	.byte $40,$2A,$AD,$80,$DA,$1D ;|  X   X X X X XX X X||   XXX XX X X XXX   | ( 26)
	.byte $40,$2A,$A5,$00,$92,$08 ;|  X   X X X X X  X X||    X  X  X    X    | ( 27)
	.byte $40,$2A,$A5,$00,$92,$08 ;|  X   X X X X X  X X||    X  X  X    X    | ( 28)
	.byte $80,$4A,$AD,$00,$99,$08 ;|   X X  X X X XX X X||    X  XX  X   X    | ( 29)
	.byte $80,$4A,$AD,$00,$99,$08 ;|   X X  X X X XX X X||    X  XX  X   X    | ( 30)
	.byte $80,$4A,$A5,$00,$90,$09 ;|   X X  X X X X  X X||    X  X    X  X    | ( 31)
	.byte $80,$4A,$A5,$00,$90,$09 ;|   X X  X X X X  X X||    X  X    X  X    | ( 32)
	.byte $00,$8A,$AD,$00,$9A,$09 ;|    X   X X X XX X X||    X  XX X X  X    | ( 33)
	.byte $00,$8B,$EC,$00,$9B,$09 ;|    X   X XX  XX XXX||    X  XX XXX  X    | ( 34)

Version
	.byte $00,$00,$00,$00,$02,$1C ;|                    ||          X   XXX   | ( 38)
	.byte $00,$00,$00,$00,$02,$14 ;|                    ||          X   X X   | ( 39)
	.byte $00,$00,$00,$00,$02,$14 ;|                    ||          X   X X   | ( 40)
	.byte $00,$00,$00,$00,$02,$14 ;|                    ||          X   X X   | ( 41)
	.byte $00,$00,$00,$00,$02,$15 ;|                    ||          X X X X   | ( 42)
	.byte $00,$00,$00,$00,$02,$1D ;|                    ||          X X XXX   | ( 43)

SelRes
	.byte $00,$08,$00,$00,$00,$01 ;|        X           ||            X       | (167)
	.byte $00,$18,$00,$00,$00,$03 ;|       XX           ||            XX      | (168)
	.byte $00,$38,$00,$00,$00,$07 ;|      XXX           ||            XXX     | (169)
	.byte $00,$78,$00,$00,$00,$0F ;|     XXXX           ||            XXXX    | (170)
	.byte $00,$38,$00,$00,$00,$07 ;|      XXX           ||            XXX     | (171)
	.byte $00,$18,$00,$00,$00,$03 ;|       XX           ||            XX      | (172)
	.byte $00,$08,$00,$00,$00,$01 ;|        X           ||            X       | (173)
	.byte $00,$00,$00,$00,$00,$00 ;|                    ||                    | (174)
	.byte $00,$00,$00,$00,$00,$00 ;|                    ||                    | (175)
	.byte $00,$00,$00,$00,$00,$00 ;|                    ||                    | (176)
	.byte $00,$00,$00,$00,$00,$00 ;|                    ||                    | (177)
	.byte $C0,$37,$00,$00,$07,$16 ;|  XX  XX XXX        ||         XXX XX X   | (178)
	.byte $40,$A4,$00,$00,$04,$12 ;|  X X X  X          ||         X   X  X   | (179)
	.byte $C0,$32,$00,$00,$02,$16 ;|  XX  XX  X         ||          X  XX X   | (180)
	.byte $40,$A2,$00,$00,$02,$12 ;|  X X X   X         ||          X  X  X   | (181)
	.byte $40,$A1,$00,$00,$01,$12 ;|  X X X    X        ||           X X  X   | (182)
	.byte $40,$B7,$00,$00,$07,$36 ;|  X X XX XXX        ||         XXX XX XX  | (183)