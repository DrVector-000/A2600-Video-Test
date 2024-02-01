;************************************************************************
;* Video Test v. 1.03
;* Banco 1
;************************************************************************

	SEG		CODE
	ORG		$0000
	RORG	$F000

;************************************************************************
;* Inizializzazione
;************************************************************************
Start
	SEI
	CLD

	LDA	#$00
	LDX	#$00
ClearMem_Loop
	STA	$00,x
	DEX
	BNE	ClearMem_Loop

ClearSR
	LDX	#$FF
	TXS

InitVars
	STA _pageNr
	STA _colorIndex
	STA _indexFirstColor

;************************************************************************
;* Loop principale
;************************************************************************
MainLoop
	LDY _pageNr
	CPY #$00
	BEQ Page0
	CPY #$01
	BEQ Page1
	CPY #$02
	BEQ Page2
	CPY #$03
	BEQ Page3
	CPY #$04
	BEQ Page4
	CPY #$05
	BEQ Page5
	CPY #$06
	BEQ Page6
	JMP Continue
Page0
	JSR TitleScreen
	JMP Continue
Page1
	JSR VColorBars
	JMP Continue
Page2
	JSR GrayScale
	JMP Continue	
Page3
	JSR Grid
	JMP Continue	
Page4
	JSR RedScale
	JMP Continue	
Page5
	JSR GreenScale
	JMP Continue	
Page6
	JSR BlueScale
	JMP Continue	
Continue
	INC _frameCounter
	JSR CheckSWCHB
	JMP MainLoop

;************************************************************************
;* Include Code
;************************************************************************
	include "VideoHelper.asm"
	include "TitleScreen.asm"
	include "VColorBars.asm"
	include "GrayScale.asm"
	include "RedScale.asm"
	include "GreenScale.asm"
	include "BlueScale.asm"
	include "Grid.asm"

;************************************************************************
;* Include Data
;************************************************************************
	include "Colors.asm"

;************************************************************************
;* Verifica pressione tasti RESET/SELECT
;************************************************************************
CheckSWCHB SUBROUTINE
	LDA	SWCHB
	STA _swchStat
	
; Verifica pressione tasto reset
.checkReset
	AND	#$01
	BEQ .checksel
	LDA	_oldSwchStat
	AND	#$01
	BNE	.checksel
	INC _pageNr
	LDA _pageNr
	CMP	#$07
	BCC	.continue
	LDA	#$00
.continue
	STA	_pageNr

; Verifica pressione tasto select
.checksel
	LDA _swchStat
	AND #$02
	BEQ .exit
	LDA	_oldSwchStat
	AND	#$02
	BNE	.exit
	DEC _pageNr
	BPL .exit
	LDA #$06
	STA _pageNr

.exit
	LDA _swchStat
	STA _oldSwchStat
	RTS

;************************************************************************
;* Interrupt Vectors
;************************************************************************
	SEG		IVECT
	ORG		$0FFA
	RORG	$FFFA

	.word Start
	.word Start
	.word Start
