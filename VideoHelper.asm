WaitTimer SUBROUTINE
	LDA	INTIM
	BNE	WaitTimer
	RTS

FrameStart SUBROUTINE
	LDA	#$02
	STA	VSYNC       ; avvia VSYNC

	STA	WSYNC       ; attesa 3 WSYNC
	STA	WSYNC
	STA	WSYNC

	LDA #$00
    STA	VSYNC       ; ferma VSYNC
	
    ;LDA	#T64VBlank  ; imposta timer per VBLANK
	;STA	TIM64T
	RTS

;*******************************************************************
; Attendi n WSYNC
; [IN] _nSync: numero di segnali di sincronizzazione
;*******************************************************************
WaitSync
	LDX #$00
.loop
	STA WSYNC	
	INX
	CPX _nSync	
	BNE .loop
	RTS