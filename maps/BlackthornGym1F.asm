BlackthornGym1F_MapScriptHeader:
.MapTriggers:
	db 0
.MapCallbacks:
	db 1
	dbw MAPCALLBACK_OBJECTS, .InitEvents
.InitEvents
	checkevent EVENT_130
	iftrue .finish
	setevent EVENT_113
	setevent EVENT_114
	setevent EVENT_115
	setevent EVENT_116
	setevent EVENT_117
	setevent EVENT_118
	setevent EVENT_130
.finish
	return

BlackthornGym1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def 15, 3, 2, BLACKTHORN_CITY

.XYTriggers:
	db 5
	xy_trigger 0, 13, 6, 0, encounterggob1, 0, 0
	xy_trigger 0, 12, 5, 0, encounterggob2, 0, 0
	xy_trigger 0, 9, 3, 0, encounterggob3, 0, 0
	xy_trigger 0, 5, 6, 0, encounterborg, 0, 0
	xy_trigger 0, 3, 4, 0, encounterlerp, 0, 0

.Signposts:
	db 1
	signpost 16, 3, SIGNPOST_READ, .ruins

.PersonEvents:
	db 11
	person_event SPRITE_CAL, 13, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, dummy, EVENT_110
	person_event SPRITE_CAL, 11, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, dummy, EVENT_111
	person_event SPRITE_CAL, 9, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, dummy, EVENT_112
	person_event SPRITE_FISHING_GURU, 13, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, blood, EVENT_113
	person_event SPRITE_FISHING_GURU, 11, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, blood, EVENT_114
	person_event SPRITE_FISHING_GURU, 9, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, blood, EVENT_115
	person_event SPRITE_FISHING_GURU, 4, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, blood, EVENT_117
	person_event SPRITE_FISHING_GURU, 2, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, blood, EVENT_116
	person_event SPRITE_SNES, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, .ItemFragment_MoneySix1actions, EVENT_118
	person_event SPRITE_CAL, 4, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, dummy, EVENT_11A
	person_event SPRITE_CAL, 2, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, dummy, EVENT_119
.ItemFragment_MoneySix1actions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKitem
	if_equal 2, .TCHitem
	if_equal 3, .TLKmap
	if_equal 4, .LOKitem
	if_equal 5, .INGmap
	if_equal 6, .TKEitem
	if_equal 7, .USEitem
	end
.Done
	closetext
	end
.TLKmap
	jumptext .talkmap
.talkmap
	text "That cannot talk."
	done
.ATKitem
	opentext
	writetext .destroyItemQuestion
	yesorno
	iffalse .Done
	setevent EVENT_118
	disappear 10
	jumptext .itemDestroyed
.destroyItemQuestion
	text "You're able to"
	line "destroy the"
	cont "money bag. Do so?"
	prompt
.itemDestroyed
	text "You destroy"
	line "the money bag."
	done
.TCHitem
	opentext
	writetext .touchItemQuestion
	yesorno
	iffalse .Done
	jumptext .touchItemText
.touchItemQuestion
	text "The money bag is"
	line "within reach."
	cont "Touch it?"
	prompt
.touchItemText
	text "You feel a rough"
	line "leather bag and"
	para "some soild ¥"
	line "coins."
	done
.LOKitem
	callasm .lookAtMoney
	waitbutton
	jumptext .lookAtItem
.lookAtItem
	text "You see 6 ¥"
	line "coins."
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
	setevent EVENT_118
	disappear 10
	givemoney 0, 6
	iffalse .oops
	jumptext .takeitemtext
.takeitemquestion
	text "You are able to"
	line "take the money."
	prompt
.takeitemtext
	text "Nothing happens"
	line "as you take"
	cont "the money."
	done
.doSo
	text "Do so?"
	prompt
.INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
.oops
	jumptext .packfull
.packfull
	text "But your pack is"
	line "full."
	done

.MoneyPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00
.lookAtMoney
	lb bc, BANK(BagPic), 6*7
	ld hl, BagPic
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
.ruins
	jumptext .ruins_
.ruins_
	text "Passage to ruins."
	done
dummy
	end
blood
	jumpstd daytotext
LoadDeadGrey
	ld hl, DeadGoblinPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	ret
encounterggob2
	setlasttalked 3
	checkevent EVENT_111
	iftrue .leave
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	applymovement PLAYER, .look
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .huh
	winlosstext .enemyloses, .playerloses
	closetext
	loadtrainer YOUNGSTER, 3
	callasm LoadDeadGrey
	startbattle
	reloadmapafterbattle
	disappear 3
	setevent EVENT_111
	clearevent EVENT_114
	appear 6
.leave
	end
.look
	turn_head_up
	step_end
.huh
	text "???: [Spien!]"
	prompt
.enemyloses
	text "???: [Nein so"
	line "was!]"
	done
.playerloses
	text ""
	done
encounterggob3
	setlasttalked 4
	checkevent EVENT_112
	iftrue .leave
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	applymovement PLAYER, .look
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .huh
	winlosstext .enemyloses, .playerloses
	closetext
	loadtrainer YOUNGSTER, 4
	callasm LoadDeadGrey
	startbattle
	reloadmapafterbattle
	disappear 4
	setevent EVENT_112
	clearevent EVENT_115
	appear 7
.leave
	end
.look
	turn_head_left
	step_end
.huh
	text "???: [Shutzsta-"
	line "ffel.]"
	prompt
.enemyloses
	text "???: [Mein leben!]"
	done
.playerloses
	text ""
	done
lookAtGGob
	lb bc, BANK(GoblinPic), 6*8
	ld hl, GoblinPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .GGobPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.GGobPalette)
	ld [wPaletteBankBuffer], a
	
	callba Personpic
	ret
.GGobPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/youngster.pal"
	RGB 00, 00, 00
encounterggob1
	setlasttalked 2
	checkevent EVENT_110
	iftrue .leave
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	applymovement PLAYER, .look
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .huh
	winlosstext .enemyloses, .playerloses
	closetext
	loadtrainer YOUNGSTER, MIKEY
	callasm LoadDeadGrey
	startbattle
	reloadmapafterbattle
	disappear 2
	setevent EVENT_110
	clearevent EVENT_113
	appear 5
.leave
	end
.look
	turn_head_right
	step_end
.huh
	text "???: [Achtung!]"
	prompt
.enemyloses
	text "???: [Aiieee!!]"
	done
.playerloses
	text ""
	done
encounterborg
	setlasttalked 11
	checkevent EVENT_11A
	iftrue .leave
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	applymovement PLAYER, .look
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .huh
	winlosstext .enemyloses, .playerloses
	closetext
	loadtrainer YOUNGSTER, 5
	callasm LoadDeadGrey
	startbattle
	reloadmapafterbattle
	disappear 11
	setevent EVENT_11A
	clearevent EVENT_117
	appear 8
.leave
	end
.look
	turn_head_up
	step_end
.huh
	text "???: [Die,"
	line "schweinehund.]"
	prompt
.enemyloses
	text "???: [Lerp,"
	line "auf wiedersehen.]"
	done
.playerloses
	text ""
	done
encounterlerp
	setlasttalked 12
	checkevent EVENT_119
	iftrue .leave
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	applymovement PLAYER, .look
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .huh
	winlosstext .enemyloses, .playerloses
	closetext
	loadtrainer YOUNGSTER, 6
	callasm LoadDeadGrey
	startbattle
	reloadmapafterbattle
	disappear 12
	setevent EVENT_119
	clearevent EVENT_116
	appear 9
	clearevent EVENT_118
	appear 10
.leave
	end
.look
	turn_head_up
	step_end
.huh
	text "???: [You killed"
	line "Borg! Die!!]"
	prompt
.enemyloses
	text "???: [What a"
	line "pity…]"
	done
.playerloses
	text ""
	done