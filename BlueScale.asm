BlueScale SUBROUTINE
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
		; 192 Linee
		LDY #$C1
	ELSE
		; 228 Linee
		LDY #$E4
	ENDIF

.colorindex
    LDA _frameCounter
    AND #$0F
    BNE .fillscreen

    INC _colorIndex
    LDA _colorIndex
    CMP #$08
    BNE .fillscreen
    LDA #$00
    STA _colorIndex

.fillscreen
.printline
    STA WSYNC           ; line 1

    NOP                 ; [2]
    NOP                 ; [2]
    NOP                 ; [2]
    NOP                 ; [2]
    NOP                 ; [2]

    LDX _colorIndex     ; [2]
    LDA BlueScaleCols,X  ; [4]
    STA COLUBK          ; [2]

    DEY
    CPY #$00
    BNE .printline
    
.exit
    STA WSYNC
	LDA	#$00
	STA	COLUBK

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