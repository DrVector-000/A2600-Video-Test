VColorBars SUBROUTINE
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
.area1
    LDY #$00
.area1loop
    STA WSYNC           ; (3) attendi Horizontal Blank
	INY					; (2)
	IF SYSTEM == NTSC
		; 150 WSYNC
		CPY #$97
	ELSE
		; 170 WSYNC
		CPY #$AA		; (2)
	ENDIF
	BEQ	.area2			; (2)
	
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
    NOP					; (2)
.lightgray
	LDA	#LightGray		; (2) (63/68)
	STA	COLUBK			; (3)
    NOP					; (2)
.yellow
	LDA	#Yellow			; (2) (21/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.cyan	
	LDA	#Cyan			; (2) (42/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.green
	LDA	#Green			; (2) (63/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.violet
	LDA	#Violet			; (2) (84/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.red	
	LDA	#Red			; (2) (105/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.blue	
	LDA	#Blue			; (2) (126/160)
	STA	COLUBK			; (3)
    NOP					; (2)
.black
	LDA	#Black			; (2) (147/160)
	STA	COLUBK			; (3)
	JMP	.area1loop		; (3)

.area2
    LDY #$00
.area2loop
    STA WSYNC           ; attendi Horizontal Blank
	INY
	IF SYSTEM == NTSC
		; 8 WSYNC
		CPY #$08
	ELSE
		; 10 WSYNC
		CPY #$0A
	ENDIF
	BEQ	.area3
	
    NOP
    NOP
    NOP
    NOP
    NOP
.blue2	
	LDA	#Blue
	STA	COLUBK
    NOP
.black2
	LDA	#Black
	STA	COLUBK
    NOP
.violet2
	LDA	#Violet
	STA	COLUBK
    NOP
.black3
	LDA	#Black
	STA	COLUBK
    NOP
.cyan2	
	LDA	#Cyan
	STA	COLUBK
    NOP
.black4
	LDA	#Black
	STA	COLUBK
    NOP
.lightgray2
	LDA	#LightGray
	STA	COLUBK
    NOP
.black5
	LDA	#Black
	STA	COLUBK
    JMP .area2loop

.area3
    LDY #$00
.area3loop
    STA WSYNC           ; attendi Horizontal Blank
	INY
	IF SYSTEM == NTSC
		; 34 WSYNC
		CPY #$22
	ELSE
		; 48 WSYNC
		CPY #$30
	ENDIF
	BEQ	.exit
	
    NOP
    NOP
    NOP
    NOP
    NOP
.darkblue	
	LDA	#DarkBlue
	STA	COLUBK
	NOP
    NOP
    NOP
.white	
	LDA	#White
	STA	COLUBK
	NOP
	NOP
    NOP
.darkviolet
	LDA	#DarkViolet
	STA	COLUBK
	NOP
	NOP
    NOP
.black6
	LDA	#Black
	STA	COLUBK
	JMP	.area3loop

.exit
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