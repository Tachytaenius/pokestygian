PalletTown_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PalletTown_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def 15, 5, 2, LAKE_OF_RAGE
	warp_def 1, 11, 1, REDS_HOUSE_1F
	warp_def 1, 3, 1, GOLDENROD_DEPT_STORE_ELEVATOR

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 16, 5, SIGNPOST_READ, .cavern
	signpost 1, 11, SIGNPOST_READ, .king
	signpost 1, 3, SIGNPOST_READ, .loo

.PersonEvents:
	db 5
	person_event SPRITE_BILL, 2, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_CAL, 6, 4, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 0, -1, -1, PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, .stdGoblin, -1
	person_event SPRITE_CAL, 15, 11, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 0, -1, -1, PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, .stdGoblin, -1
	person_event SPRITE_CAL, 7, 16, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 0, -1, -1, PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, .stdGoblin, -1
	person_event SPRITE_CAL, 8, 17, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, bill, -1
.cavern
	jumptext .cavern_
.cavern_
	text "Passage to cavern."
	done
.king
	jumptext .king_
.king_
	text "Passage to king's"
	line "quarters."
	done
.loo
	jumptext .loo_
.loo_
	text "Passage to loo."
	done
.plantScript
	jumpstd elevatorbutton
.USEno
	jumptext .cannotUse
.cannotUse
	text "There is no way"
	line "to use that."
	done
.INGno
	jumptext .ingestNo
.ingestNo
	text "That is not"
	line "edible."
	done
.TKEno
	jumptext .noTke
.noTke
	text "You are unable"
	line "to take that."
	prompt
.ATKno
	jumptext .noAtk
.noAtk
	text "No! You may"
	line "not! You are"
	cont "able, though."
	done
.stdGoblin
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKno
	if_equal 2, .TCHVernix
	if_equal 3, .TLKVernix
	if_equal 4, .LOKVernix
	if_equal 5, .INGno
	if_equal 6, .TKEno
	if_equal 7, .USEno
	end
.TCHVernix
	opentext
	writetext .withinReachVernix
	yesorno
	iffalse .Done
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	jumptext .VernixWhat
.withinReachVernix
	text "The green goblin"
	line "is within your"
	para "reach of touch."
	line "Touch it?"
	prompt
.VernixWhat
	text "???: [Eh!?]"
	done
.LOKVernix
	callasm .lookAtVernix
	waitbutton
	jumptext .lookVernix
.lookVernix
	text "You see see a"
	line "friendly green"
	cont "goblin."
	done
.greetingsFromVernix
	text "???: ['Ello.]"
	done
.anyMore
	text "???: [OK…]"
	done
.loopVernix
	writetext .anyMore
	buttonsound
	jump .loopReturn
.TLKVernix
	opentext
	loadmenudata .Greet
	verticalmenu
	closewindow
	if_equal 2, .Done
	faceplayer
	writetext .greetingsFromVernix
	buttonsound
.loopReturn
	loadmenudata .What
	verticalmenu
	closewindow
	if_equal 1, .WhatOne
	if_equal 2, .WhatTwo
	if_equal 3, .WhatThree
	; WhatFour
	jumptext .ohokthen
.ohokthen
	text "???: [OK, good-"
	line "bye.]"
	done
.WhatOne
	writetext .leader
	buttonsound
	jump .loopVernix
.WhatTwo
	writetext .abyss
	buttonsound
	jump .loopVernix
.WhatThree
	writetext .armageddon
	buttonsound
	jump .loopVernix
.leader
	text "???: [Oh, da lea-"
	line "der. Aye, Vernix"
	para "is da one ya want."
	line "Lives in da right"
	para "passageway, up"
	line "dere.]"
	done
.abyss
	text "???: [Uh, dere's…"
	line "da grey goblins, a"
	para "nasty bunch, us,"
	line "da green goblins,"
	para "who live inside"
	line "caves with banners"
	para "dat have funny"
	line "marks on dem, like"
	para "me, da other green"
	line "goblins-- da nasty"
	para "ones-- some hum-"
	line "ans, and dat's all"
	cont "I know.]"
	done
.armageddon
	text "???: [Y'wot? No"
	line "idea what dat is.]"
	done
.Greet
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Greet2
	db 1 ; default option
.Greet2
	db $81 ; flags
	db 2 ; items
	db "[Hello.]@"
	db "Cancel@"
.What
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .What2
	db 1 ; default option
.What2
	db $81 ; flags
	db 4 ; items
	db "[Your leader?]@"
	db "[The Abyss?]@"
	db "[The Armageddon?]@"
	db "[Bye.]@"
.Done
	closetext
	end
.lookAtVernix
	ld hl, .goblinPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	ld a, BANK(.goblinPalette)
	ld [wPaletteBankBuffer], a
	lb bc, BANK(GoblinPic), 6*8
	ld hl, GoblinPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	callba Personpic
	ret
.goblinPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/will.pal"
	RGB 00, 00, 00
bill
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKno
	if_equal 2, .TCHVernix
	if_equal 3, .TLKVernix
	if_equal 4, .LOKVernix
	if_equal 5, .INGno
	if_equal 6, .TKEno
	if_equal 7, .USEno
	end
.TCHVernix
	opentext
	writetext .withinReachVernix
	yesorno
	iffalse .Done
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	jumptext .VernixWhat
.withinReachVernix
	text "The green goblin"
	line "is within your"
	para "reach of touch."
	line "Touch it?"
	prompt
.VernixWhat
	text "???: [Huh!??!]"
	done
.LOKVernix
	callasm .lookAtVernix
	waitbutton
	jumptext .lookVernix
.lookVernix
	text "You see see a"
	line "friendly green"
	cont "goblin."
	done
.greetingsFromVernix
	text "???: […]"
	done
.anyMore
	text "???: […]"
	done
.loopVernix
	writetext .anyMore
	buttonsound
	jump .loopReturn
.TLKVernix
	opentext
	loadmenudata .Greet
	verticalmenu
	closewindow
	if_equal 2, .Done
	faceplayer
	writetext .greetingsFromVernix
	buttonsound
.loopReturn
	loadmenudata .What
	verticalmenu
	closewindow
	if_equal 1, .WhatOne
	if_equal 2, .WhatTwo
	if_equal 3, .WhatThree
	; WhatFour
	jumptext .ohokthen
.ohokthen
	text "???: […]"
	done
.WhatOne
	writetext .leader
	buttonsound
	jump .loopVernix
.WhatTwo
	writetext .abyss
	buttonsound
	jump .loopVernix
.WhatThree
	writetext .armageddon
	buttonsound
	jump .loopVernix
.leader
	text "???: […]"
	done
.abyss
	text "???: […]"
	done
.armageddon
	text "???: […]"
	done
.Greet
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Greet2
	db 1 ; default option
.Greet2
	db $81 ; flags
	db 2 ; items
	db "[Hello.]@"
	db "Cancel@"
.What
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .What2
	db 1 ; default option
.What2
	db $81 ; flags
	db 4 ; items
	db "[Your leader?]@"
	db "[The Abyss?]@"
	db "[The Armageddon?]@"
	db "[Bye.]@"
.Done
	closetext
	end
.lookAtVernix
	ld hl, .goblinPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	ld a, BANK(.goblinPalette)
	ld [wPaletteBankBuffer], a
	lb bc, BANK(GoblinPic), 6*8
	ld hl, GoblinPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	callba Personpic
	ret
.goblinPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/will.pal"
	RGB 00, 00, 00
.USEno
	jumptext .cannotUse
.cannotUse
	text "There is no way"
	line "to use that."
	done
.INGno
	jumptext .ingestNo
.ingestNo
	text "That is not"
	line "edible."
	done
.TKEno
	jumptext .noTke
.noTke
	text "You are unable"
	line "to take that."
	prompt
.ATKno
	jumptext .noAtk
.noAtk
	text "No! You may"
	line "not! You are"
	cont "able, though."
	done