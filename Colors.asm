	IF SYSTEM == NTSC
RedScaleCols
    .byte #$40,#$42,#$44,#$46,#$48,#$4A,#$4C,#$4E
GreenScaleCols
    .byte #$C0,#$C2,#$C4,#$C6,#$C8,#$CA,#$CC,#$CE
BlueScaleCols
    .byte #$80,#$82,#$84,#$86,#$88,#$8A,#$8C,#$8E
GrayScaleCols
    .byte #$00,#$02,#$04,#$06,#$08,#$0A,#$0C,#$0E	
	ELSE
RedScaleCols
    .byte #$60,#$62,#$64,#$66,#$68,#$6A,#$6C,#$6E
GreenScaleCols
    .byte #$50,#$52,#$54,#$56,#$58,#$5A,#$5C,#$5E
BlueScaleCols
    .byte #$B0,#$B2,#$B4,#$B6,#$B8,#$BA,#$BC,#$BE
GrayScaleCols
    .byte #$00,#$02,#$04,#$06,#$08,#$0A,#$0C,#$0E	
    ENDIF
