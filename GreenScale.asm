GreenScale SUBROUTINE
	;---------------------------------------------------
	; Vetical sync
	JSR FrameStart
	
	;---------------------------------------------------
	; Verical Blank 37 linee
	LDA	#$01
    STA	VBLANK          ; Start VBLANK
	
	LDA #$2B
    STA TIM64T
.waitvb	
	LDA INTIM
	BNE .waitvb

	LDA	#$00
    STA	VBLANK          ; Stop VBLANK

    LDY #$F2            ; numero di linee

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

	;---------------------------------------------------
    ; PAL TV 242 Scanlines
.fillscreen
.printline
    STA WSYNC           ; line 1

    NOP                 ; [2]
    NOP                 ; [2]
    NOP                 ; [2]
    NOP                 ; [2]
    NOP                 ; [2]

    LDX _colorIndex     ; [2]
    LDA GreenScalePAL,X ; [4]
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
	; 30 WSYNC
	LDA #$24
    STA TIM64T
.waitovs	
	LDA INTIM
	BNE .waitovs

    RTS