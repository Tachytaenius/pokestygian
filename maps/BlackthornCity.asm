BlackthornCity_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_TILES, clear
	
clear
	checkevent EVENT_202
	iffalse .Return
	changeblock 28, 30, 2
.Return
	return

BlackthornCity_MapEventHeader:: db 0, 0

.Warps: db 3
	warp_def 31, 11, 3, LAKE_OF_RAGE
	warp_def 1, 15, 1, BLACKTHORN_GYM_1F
	warp_def 21, 37, 1, CELADON_GYM

.CoordEvents: db 0

.BGEvents: db 4
	signpost 32, 11, SIGNPOST_READ, cavern
	signpost 1, 15, SIGNPOST_READ, grey_goblins
	signpost 21, 37, SIGNPOST_READ, humans
	signpost 31, 29, SIGNPOST_READ, break
.ObjectEvents: db 1

	person_event SPRITE_BUGSY, 32, 24, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, gem2, EVENT_201

break
	checkevent EVENT_202
	iftrue Done
	checkitem CARD_KEY
	iffalse .Done
	opentext
	writetext .breakable
	yesorno
	iffalse .finish
	setevent EVENT_202
	changeblock 28, 30, 2
	reloadmappart
	jumptext .broken
.finish
	closetext
	end
.Done
	end
.broken
	text "You break the rock"
	line "into smaller bits."
	done
.breakable
	text "This boulder looks"
	line "breakable! Break"
	para "it with your rock"
	line "hammer?"
	prompt
cavern
	jumptext .text
.text
	text "Passage to cavern."
	done
grey_goblins
	jumptext .text
.text
	text "Passage to grey"
	line "goblin settlement."
	done
humans
	jumptext .text
.text
	text "Passage to human"
	line "settlement."
	done
gem2
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKno
	if_equal 2, .TCHitem
	if_equal 3, .TLKmap
	if_equal 4, .LOKitem
	if_equal 5, .INGmap
	if_equal 6, .TKEitem
	if_equal 7, .USEitem
	end
.INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
.Done
	closetext
	end
.ATKno
	jumptext .noAtk
.noAtk
	text "No! You may"
	line "not! You are"
	cont "able, though."
	done
.TLKmap
	jumptext .talkmap
.talkmap
	text "That cannot talk."
	done
.TCHitem
	opentext
	writetext .touchItemQuestion
	yesorno
	iffalse .Done
	jumptext .touchItemText
.touchItemQuestion
	text "The gem is within"
	line "reach. Touch it?"
	prompt
.touchItemText
	text "You feel the conf-"
	line "using surface of a"
	para "gem of greater"
	line "travel."
	done
.LOKitem
	callasm .lookAtMoney
	waitbutton
	jumptext .lookAtItem
.lookAtItem
	text "You see void."
	done
.USEitem
	jumptext .pickUpFirst
.pickUpFirst
	text "There is no way"
	line "to use that."
	done
.TKEitem
	opentext
	writetext .takeitemquestion
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_201
	disappear 2
	callasm .givegem
	jumptext .takeitemtext
.takeitemquestion
	text "You are able to"
	line "take the gem."
	prompt
.takeitemtext
	text "Nothing happens"
	line "as you take"
	cont "the gem."
	done
.doSo
	text "Do so?"
	prompt
.givegem
	ld hl, DestinationGems
	set 0, [hl]
	ret
.MoneyPalette
	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 10, 10, 10
	RGB 00, 00, 00
.lookAtMoney
	lb bc, BANK(GemPic), 6*7
	ld hl, GemPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	
	ld hl, .MoneyPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.MoneyPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret