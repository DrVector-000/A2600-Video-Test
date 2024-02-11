GrayScale SUBROUTINE
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
.topbars
    LDY #$00
.topbarsloop
    STA WSYNC           ; (3) attendi Horizontal Blank
	INY					; (2)
	IF SYSTEM == NTSC
		; 96 WSYNC
		CPY	#$61
	ELSE
		; 114 WSYNC
		CPY	#$72
	ENDIF
	BEQ	.bottombars	    ; (2)
	
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)

.col1
	LDA	#$0E			; (2) (63/68)
	STA	COLUBK
    NOP
.col2
	LDA	#$0C
	STA	COLUBK
    NOP
.col3
	LDA	#$0A
	STA	COLUBK
    NOP
.col4
	LDA	#$08
	STA	COLUBK
    NOP
.col5
	LDA	#$06
	STA	COLUBK
    NOP
.col6
	LDA	#$04
	STA	COLUBK
    NOP
.col7
	LDA	#$02
	STA	COLUBK
    NOP
.col8
	LDA	#$00
	STA	COLUBK
    JMP .topbarsloop

.bottombars
    LDY #$00
.bottombarsloop
    STA WSYNC           ; (3) attendi Horizontal Blank
	INY					; (2)
	IF SYSTEM == NTSC
		; 96 WSYNC
		CPY	#$60
	ELSE
		; 114 WSYNC
		CPY	#$72
	ENDIF
	BEQ	.exit	        ; (2)
	
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)

.col9
	LDA	#$00			; (2) (63/68)
	STA	COLUBK
    NOP
.col10
	LDA	#$02
	STA	COLUBK
    NOP
.col11
	LDA	#$04
	STA	COLUBK
    NOP
.col12
	LDA	#$06
	STA	COLUBK
    NOP
.col13
	LDA	#$08
	STA	COLUBK
    NOP
.col14
	LDA	#$0A
	STA	COLUBK
    NOP
.col15
	LDA	#$0C
	STA	COLUBK
    NOP
.col16
	LDA	#$0E
	STA	COLUBK
    JMP .bottombarsloop

.exit
	LDA	#Black
	STA	COLUBK
	STA WSYNC

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