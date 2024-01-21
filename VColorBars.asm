VColorBars SUBROUTINE
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

	;---------------------------------------------------
    ; PAL TV 242 Scanlines
.area1
    LDY #$00
.area1loop
    STA WSYNC           ; (3) attendi Horizontal Blank
	INY					; (2)
	CPY	#$B4            ; (2) numero di linee (180)
	BEQ	.area2			; (2)
	
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
.lightgray
	LDA	#$0E			; (2) (63/68)
	STA	COLUBK			; (3)
    NOP					; (2)
.yellow
	LDA	#$2F			; (2) (21/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.cyan	
	LDA	#$7F			; (2) (42/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.green
	LDA	#$5B			; (2) (63/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.violet
	LDA	#$86			; (2) (84/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.red	
	LDA	#$65			; (2) (105/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.blue	
	LDA	#$D4			; (2) (126/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.black
	LDA	#$00			; (2) (147/160)
	STA	COLUBK			; (3)
	JMP	.area1loop		; (3)

.area2
    LDY #$00
.area2loop
    STA WSYNC           ; attendi Horizontal Blank
	INY
	CPY	#$0A            ; numero di linee (10)
	BEQ	.area3
	
    NOP
    NOP
    NOP
    NOP
    NOP
.blue2	
	LDA	#$D4
	STA	COLUBK
    NOP
.black2
	LDA	#$00
	STA	COLUBK
    NOP
.violet2
	LDA	#$86
	STA	COLUBK
    NOP
.black3
	LDA	#$00
	STA	COLUBK
    NOP
.cyan2	
	LDA	#$7F
	STA	COLUBK
    NOP
.black4
	LDA	#$00
	STA	COLUBK
    NOP
.lightgray2
	LDA	#$0E
	STA	COLUBK
    NOP
.black5
	LDA	#$00
	STA	COLUBK
    JMP .area2loop

.area3
    LDY #$00
.area3loop
    STA WSYNC           ; attendi Horizontal Blank
	INY
	CPY	#$35            ; numero di linee (52) (53???)
	BEQ	.exit
	
    NOP
    NOP
    NOP
    NOP
    NOP
.darkblue	
	LDA	#$B0
	STA	COLUBK
	NOP
    NOP
    NOP
.white	
	LDA	#$0F
	STA	COLUBK
	NOP
	NOP
    NOP
.darkviolet
	LDA	#$A0
	STA	COLUBK
	NOP
	NOP
    NOP
.black6
	LDA	#$00
	STA	COLUBK
	JMP	.area3loop

.exit
	;---------------------------------------------------
    ; Overscan
	; 30 WSYNC
	LDA #$24
    STA TIM64T
.waitovs	
	LDA INTIM
	BNE .waitovs

    RTS