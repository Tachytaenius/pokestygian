CeladonGym_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonGym_MapEventHeader:: db 0, 0

.Warps: db 1
	warp_def 15, 7, 3, BLACKTHORN_CITY

.CoordEvents: db 0

.BGEvents: db 1
	signpost 16, 7, SIGNPOST_READ, .ruins

.ObjectEvents: db 5
	person_event SPRITE_MISTY, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .JuliaScript, -1
	person_event SPRITE_COOLTRAINER_M, 5, 3, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, stdHuman, -1
	person_event SPRITE_COOLTRAINER_M, 8, 2, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, stdHuman, -1
	person_event SPRITE_COOLTRAINER_M, 7, 7, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, stdHuman, -1
	person_event SPRITE_COOLTRAINER_M, 13, 6, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, stdHuman, -1

.ruins
	jumptext .ruins_
.ruins_
	text "Passage to ruins."
	done

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
.notice
	text "The human notices"
	line "you."
	prompt
.name
	text "???: Greetings."
	line "I am Julia."
	prompt
.go
	faceplayer
	opentext
	writetext .notice
	writetext .name
	closetext
	setevent EVENT_10F
	jump .back
.JuliaScript
	showemote EMOTE_SAD, LAST_TALKED, 15
	checkevent EVENT_10F
	iffalse .go
.back
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
	text "The human is in"
	line "reach. Touch it?"
	prompt
.VernixWhat
	text "Julia: [Hey!]"
	done
.LOKVernix
	callasm .lookAtVernix
	waitbutton
	jumptext .lookVernix
.lookVernix
	text "You see see a"
	line "friendly human."
	done
.greetingsFromVernix
	text "Julia: [Hi.]"
	done
.anyMore
	text "Julia: [Anything"
	line "else?]"
	prompt
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
	if_equal 3, .WhatOne
	if_equal 4, .WhatFour
	; WhatFive
	jumptext .ohokthen
.WhatFour
	writetext .floorTwo
	jump .loopVernix
.floorTwo
	text "Julia: [I do not"
	line "know what lies"
	para "beyond this level,"
	line "but I know where"
	para "the ladder to the"
	line "second level is;"
	para "simply leave our"
	line "settlement and"
	para "walk straight on."
	done
.WhatOne
	writetext .iKnowNothing
	jump .loopVernix
.iKnowNothing
	text "Julia: [Of this I"
	line "know nothing."
	cont "Sorry.]"
	prompt
.WhatTwo
	writetext .ohokthen3
	callasm .martNameLanugo
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE
	jump .loopVernix
.martNameLanugo
	ld b, 6
	ld hl, StringBuffer3
	ld de, .NameLanugo
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop
	ret
.NameLanugo
	db "Julia@"
.ohokthen
	text "Julia: [Bye.]"
	done
.ohokthen3
	text "Julia: [Sure.]"
	prompt
.Greet
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Greet2
	db 1 ; default option
.Greet2
	db $81 ; flags
	db 2 ; items
	db "[Greetings.]@"
	db "Cancel@"
.What
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .What2
	db 1 ; default option
.What2
	db $81 ; flags
	db 5 ; items
	db "[Gems?]@"
	db "[Trade?]@"
	db "[Ruins?]@"
	db "[Level 2?]@"
	db "[Thanks.]@"
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
	lb bc, BANK(HumanFemalePic), 6*8
	ld hl, HumanFemalePic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	callba Personpic
	ret
.goblinPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/erika.pal"
	RGB 00, 00, 00
stdHuman
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
	text "The human is in"
	line "reach. Touch it?"
	prompt
.VernixWhat
	text "???: [Gah!]"
	done
.LOKVernix
	callasm .lookAtVernix
	waitbutton
	jumptext .lookVernix
.lookVernix
	text "You see see a"
	line "friendly human."
	done
.greetingsFromVernix
	text "???: ['Lo.]"
	done
.anyMore
	text "???: [May I help"
	line "you with anything"
	cont "else?]"
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
	text "???: [See you.]"
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
	text "???: [Ah, yes."
	line "Julia is the one"
	para "you want. She can"
	line "be found by the"
	para "furthest wall.]"
	done
.abyss
	text "???: [I don't know"
	line "anything about the"
	para "Abyss, I only just"
	line "moved in.]"
	done
.armageddon
	text "???: [I don't want"
	line "to talk about it.]"
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
	db "[Hi.]@"
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
	lb bc, BANK(HumanPic), 6*8
	ld hl, HumanPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	callba Personpic
	ret
.goblinPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/hiker.pal"
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