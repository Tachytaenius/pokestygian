Pokepic:: ; 244e3
	ld hl, PokepicMenuDataHeader
	call CopyMenuDataHeader
	call MenuBox
	call UpdateSprites
	call ApplyTilemap
	ld b, SCGB_POKEPIC
	call GetSGBLayout
	xor a
	ld [hBGMapMode], a
	ld a, [CurPartySpecies]
	ld [CurSpecies], a
	call GetBaseData
	ld de, VTiles1
	predef GetFrontpic
	ld a, [wMenuBorderTopCoord]
	inc a
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	inc a
	ld c, a
	call Coord2Tile
	ld a, $80
	ld [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	call WaitBGMap
	ret

ClosePokepic:: ; 24528
	ld hl, PokepicMenuDataHeader
	call CopyMenuDataHeader
	call ClearMenuBoxInterior
	call WaitBGMap
	call GetMemSGBLayout
	xor a
	ld [hBGMapMode], a
	call OverworldTextModeSwitch
	call ApplyTilemap
	call UpdateSprites
	call LoadStandardFont
	ret

PokepicMenuDataHeader: ; 0x24547
	db $40 ; flags
	db 04, 06 ; start coords
	db 13, 14 ; end coords
	dw NULL
	db 1 ; default option

PaletteSetSeven::
	ld a, [rSVBK]
	push af
	ld a, 1
	ld [rSVBK], a
	
	ld a, [wPaletteHighBuffer]
	ld h, a
	ld a, [wPaletteLowBuffer]
	ld l, a
	
	ld a, [wPaletteBankBuffer]
	push af
	ld de, BGPals + 7 palettes
	ld bc, 1 palettes
	ld a, 5
	ld [rSVBK], a
	ld bc, 1 palettes
	ld a, 5
	ld [rSVBK], a
	pop af
	call FarCopyBytes
	pop af
	ld [rSVBK], a
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
	
Itempic:: ; 244e3
	call LoadStandardFont
	ld hl, MenuDataHeader_0x24547
	call CopyMenuDataHeader
	ld hl, MenuDataHeader_0x24547
	call CopyMenuDataHeader
	call MenuBox
	xor a
	ld de, VTiles1
	ld a, [rSVBK]
	push af
	
	ld hl, VTiles1
	ld a, [ItempicPointer]
	ld d, a
	ld a, [ItempicPointer + 1]
	ld e, a
	ld c, 6 * 7
	ld a, BANK(NotePic) ;please don't move any pictures that'll use this routine out of the same bank as NotePic.
	ld b, a
	call Get2bpp
	
	pop af
	ld [rSVBK], a
	ld a, [wMenuBorderTopCoord]
	inc a
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	inc a
	ld c, a
	call Coord2Tile
	ld a, $80
	ld [hFillBox], a
	lb bc, 6, 7
	jp finishPics
Personpic:: ; 244e3
	call LoadStandardFont
	ld hl, MenuDataHeader_Person
	call CopyMenuDataHeader
	call MenuBox
	xor a
	ld de, VTiles1
	ld a, [rSVBK]
	push af
	
	call PaletteSetSeven
	ld hl, VTiles1
	ld a, [ItempicPointer]
	ld d, a
	ld a, [ItempicPointer + 1]
	ld e, a
	ld c, 6 * 8
	ld a, BANK(GoblinPic) ;please don't move any pictures that'll use this routine out of the same bank as GoblinPic.
	ld b, a
	call Get2bpp
	
	pop af
	ld [rSVBK], a
	ld a, [wMenuBorderTopCoord]
	inc a
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	inc a
	ld c, a
	call Coord2Tile
	ld a, $80
	ld [hFillBox], a
	lb bc, 6, 8
	;fallthrough, no need to jp

finishPics
	ld a, 0
	ld [wc2c6], a
	predef FillBox
	call UpdateSprites
	call ApplyTilemap
	call WaitBGMap
	ret