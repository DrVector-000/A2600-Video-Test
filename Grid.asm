Grid SUBROUTINE
	;---------------------------------------------------
	; Vetical sync
	JSR FrameStart
	
	;---------------------------------------------------
	; Verical Blank 37 linee
	; fuori standard 31 linee (31 * 76 / 64 = 36 cicli di timer)
	LDA	#$01
    STA	VBLANK          ; Start VBLANK
	
	IF SYSTEM == NTSC
		; 22 Linee
		LDA #$1A
	ELSE
		; 31 Linee
		LDA #$24
	ENDIF
    STA TIM64T
.waitvb	
	LDA INTIM
	BNE .waitvb

	LDA	#$00
    STA	VBLANK          ; Stop VBLANK

	; Colore righe orizzontali
	LDA	#White
	STA	COLUPF
	
	; Colore righe verticali
	; LDA	#$FE
	STA	COLUP0
	STA	COLUP1
	
	; Impostazione sprites
	LDA	#$03
	STA	NUSIZ0
	STA	NUSIZ1
	
	STA	WSYNC

	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	JMP	.draw

.draw
	LDA	#$10
	STA	GRP0
	STA	RESP0
	STA	GRP1
	
	NOP
	NOP
	NOP
    NOP

	LDA	#$02
	STA	RESP1
	STA	ENAM0
	STA	ENAM1
	NOP
	STA	RESM0
	NOP
	NOP
	NOP
	NOP
	STA	RESM1
	LDA	#$D0
	STA	HMM0
	LDA	#$E0
	STA	HMM1
	
	STA	WSYNC
	STA	HMOVE
	LDY	#$00
	LDX	#$02

.drawv	
    STA	WSYNC
	INX
	LDA	#$00
	CPX	#$19
	BNE	.drawh
	
	LDX	#$00
	LDA	#$FF
.drawh	
    STA	PF0
	STA	PF1
	STA	PF2
	INY
	IF SYSTEM == NTSC
		CPY	#$D6
	ELSE
		CPY	#$FF
	ENDIF
	BNE	.drawv

	;---------------------------------------------------
    ; Overscan
	; 30 WSYNC
	; fuori standard 22 linee (22 * 76 / 64 = 26 cicli timer)
	LDA #$19
    STA TIM64T
.waitos	
	LDA INTIM
	BNE .waitos

	LDA	#$00
	STA	ENAM0
	STA	ENAM1
	STA	GRP0
	STA	GRP1

    RTS
