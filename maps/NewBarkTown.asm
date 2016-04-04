NewBarkTown_MapScriptHeader:
.MapTriggers:
	db 0
	
.MapCallbacks:
	db 0
	
NewBarkTown_MapEventHeader:
	; filler
	db 0, 0
	
.Warps:
	db 2
	warp_def $d, $11, 2, KRISS_HOUSE_1F
	warp_def 9, 3, 1, ELMS_LAB
	
.XYTriggers:
	db 1
	xy_trigger 0, 15, 14, 0, .encounterBoris, 0, 0

.Signposts:
	db 4
	signpost 13, 17, SIGNPOST_READ, .gate
	signpost 9, 3, SIGNPOST_READ, .gate2
	signpost 5, 2, SIGNPOST_READ, .rockHammer
	signpost 4, 3, SIGNPOST_READ, .pokeBit
	
.PersonEvents:
	db 12
	person_event SPRITE_SNES, 13, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, .ItemFragment_MoneySix1actions, EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	person_event SPRITE_CAL, 14, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, .goblinborisscriptactions, EVENT_ROUTE_30_YOUNGSTER_JOEY
	person_event SPRITE_N64, 14, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, firstpokeballsactions, EVENT_GOT_CYNDAQUIL_FROM_ELM
	person_event SPRITE_MORTY, 13, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, bonesScript, EVENT_BEAT_YOUNGSTER_JOEY
	person_event SPRITE_FISHING_GURU, 14, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, bloodGreenScript, EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	person_event SPRITE_FISHING_GURU, 2, 16, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, bloodRedScript, -1
	person_event SPRITE_MORTY, 14, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, skullScript, EVENT_GOT_TOTODILE_FROM_ELM
	person_event SPRITE_BILL, 8, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, plantScript2, -1
	person_event SPRITE_BILL, 3, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, plantScript2, -1
	person_event SPRITE_BILL, 10, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, plantScript2, -1
	person_event SPRITE_MORTY, 11, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, skullScript2, EVENT_GOT_KENYA
	person_event SPRITE_MORTY, 10, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, bonesScript2, EVENT_GAVE_KENYA
.gate:
	jumptext .gateread
.gateread
	text "Opening to"
	line "storage cache."
	prompt
.rockHammer
	checkevent EVENT_106
	iftrue .neverMind
	opentext
	writetext .whatsthis
	yesorno
	iffalse .Done
	setevent EVENT_106
	giveitem CARD_KEY, 1
	jumptext .takehammernothing
.Done:
	closetext
.neverMind
	end
.takehammernothing
	text "Nothing happens"
	line "as you take the"
	cont "rock hammer."
	done
.whatsthis
	text "What's this? A"
	line "rock hammer was"
	para "hidden in-between"
	line "the rocks! Take"
	cont "it?"
	prompt
.GreyGoblinBoris1SeenText:
	text "???: <``>Heh… heh…"
	line "heh…<''>"
	prompt
	
.GreyGoblinBoris1BeatenText:
	text "???: [Ack!!]"
	prompt
	
.ggbWhiteout:
	text "???: [Ha-ha!]"
	prompt
.pokeBit
	checkevent EVENT_107
	iftrue .neverMind
	opentext
	writetext .whatsthis2
	yesorno
	iffalse .Done
	setevent EVENT_107
	giveitem FAST_BALL, 3
	jumptext .takehammernothing2
	closetext
	end
.takehammernothing2
	text "Nothing happens"
	line "as you take the"
	cont "# bits."
	done
.whatsthis2
	text "What's this? 3"
	line "chunks of #"
	para "bits were hidden"
	line "in-between the"
	cont "rocks! Take them?"
	prompt
.gate2:
	jumptext .g2t
.g2t:
	text "Passage to"
	line "shrine."
	done


	
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
.TLKmap
	jumptext .talkmap
.talkmap
	text "No response."
	done
.ATKitem
	opentext
	writetext .destroyItemQuestion
	yesorno
	iffalse .Done
	setevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	disappear 2
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
	setevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	disappear 2
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
.goblinborisscriptactions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKgob
	if_equal 2, .TCHgob
	if_equal 3, .TLKgob
	if_equal 4, .LOKgob
	if_equal 5, .INGmap
	if_equal 6, .TKEno
	if_equal 7, .USEitem
	end
.TLKgob
	opentext
	loadmenudata .Provoke
	verticalmenu
	closewindow
	if_equal 1, .ATKgob
	closetext
	end
.Provoke
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Greet2
	db 1 ; default option
.Greet2
	db $81 ; flags
	db 2 ; items
	db "Provoke@"
	db "Cancel@"
.borisHuh
	text "???: <``>Huh!??!<''>"
	prompt
.borisDead
	text "???: [Ack!!]"
	done
.borisWins
	text "???: [Ha-ha!!]"
	done
.withinReachBoris
	text "The grey goblin"
	line "is within your"
	para "reach of touch."
	line "Touch it?"
	prompt
.TKEno
	jumptext .noTake
.noTake
	text "You are unable"
	line "to take that."
	prompt
.lookUp
	turn_head_up
	step_end
.ATKgob
	faceplayer
	showemote EMOTE_FISH, 3, 15
	opentext
	writetext .borisHuh
	winlosstext .borisDead, .borisWins
	closetext
	loadtrainer YOUNGSTER, JOEY1
	callasm .LoadDeadGrey
	startbattle
	reloadmapafterbattle
	disappear 3
	setevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	appear 4
	clearevent EVENT_BEAT_YOUNGSTER_JOEY
	appear 5
	clearevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	appear 6
	clearevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	appear 8
	clearevent EVENT_GOT_TOTODILE_FROM_ELM
.leave
	end
.LoadDeadGrey
	ld hl, DeadGoblinPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	ret
.TCHgob
	opentext
	writetext .withinReachBoris
	yesorno
	iffalse .Done
	jump .ATKgob
.LOKgob
	callasm .lookAtGGob
	waitbutton
	jumptext .lookAtBoris
.lookAtBoris
	text "You see a"
	line "hostile grey"
	cont "goblin."
	done
.encounterBoris:
	checkevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	iftrue .leave
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	applymovement PLAYER, .lookUp
	jump .ATKgob
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
.lookAtGGob
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
.MoneyPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00
.BonesPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00
.GGobPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/youngster.pal"
	RGB 00, 00, 00
firstpokeballsactions
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
.ATKitem
	opentext
	writetext .destroyItemQuestion
	yesorno
	iffalse .Done
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	disappear 4
	jumptext .itemDestroyed
.destroyItemQuestion
	text "You're able to"
	line "destroy the"
	cont "potions. Do so?"
	prompt
.itemDestroyed
	text "You destroy the"
	line "potions."
	done
.TCHitem
	opentext
	writetext .touchItemQuestion
	yesorno
	iffalse .Done
	jumptext .touchItemText
.touchItemQuestion
	text "The potions are"
	line "within reach."
	cont "Touch them?"
	prompt
.touchItemText
	text "You feel some"
	line "smooth, round"
	cont "glass bottles."
	done

.PotionPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/gel.pal"
	RGB 00, 00, 00	

.lookAtPotion
	lb bc, BANK(GelPic), 6*7
	ld hl, GelPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .PotionPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.PotionPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.LOKitem
	callasm .lookAtPotion
	waitbutton
	jumptext .lookAtItem
.lookAtItem
	text "You see 3"
	line "potions."
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
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	disappear 4
	giveitem POTION, 3
	iffalse .oops
	jumptext .takeitemtext
.oops
	jumptext .packfull
.packfull
	text "But your pack is"
	line "full."
	done
.takeitemquestion
	text "You are able to"
	line "take the potions."
	prompt
.takeitemtext
	text "Nothing happens"
	line "as you take"
	cont "the potions."
	done
.doSo
	text "Do so?"
	prompt
.Done
	closetext
	end
.INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
.TLKmap
	jumptext .talkmap
.talkmap
	text "No response."
	done
bloodGreenScript
	jumpstd daytotext
bloodRedScript
	jumpstd goldenrodrockets
skullScript
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
.ATKitem
	opentext
	writetext .destroyItemQuestion
	yesorno
	iffalse .Done
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	disappear 8
	jumptext .itemDestroyed
.destroyItemQuestion
	text "You're able to"
	line "destroy the"
	cont "skull. Do so?"
	prompt
.itemDestroyed
	text "You destroy the"
	line "skull."
	done
.TCHitem
	opentext
	writetext .touchItemQuestion
	yesorno
	iffalse .Done
	jumptext .touchItemText
.touchItemQuestion
	text "The skull is"
	line "within reach."
	cont "Touch it?"
	prompt
.touchItemText
	text "You feel a"
	line "skull."
	done

.PotionPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00	

.lookAtPotion
	lb bc, BANK(SkullPic), 6*7
	ld hl, SkullPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .PotionPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.PotionPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.LOKitem
	callasm .lookAtPotion
	waitbutton
	jumptext .lookAtItem
.lookAtItem
	text "You see a skull."
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
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	disappear 8
	giveitem FULL_HEAL, 1
	iffalse .oops
	jumptext .takeitemtext
.oops
	jumptext .packfull
.packfull
	text "But your pack is"
	line "full."
	done
.takeitemquestion
	text "You are able to"
	line "take the skull."
	prompt
.takeitemtext
	text "Nothing happens"
	line "as you take"
	cont "the skull."
	done
.doSo
	text "Do so?"
	prompt
.Done
	closetext
	end
.INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
.TLKmap
	jumptext .talkmap
.talkmap
	text "No response."
	done
skullScript2
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
.ATKitem
	opentext
	writetext .destroyItemQuestion
	yesorno
	iffalse .Done
	setevent EVENT_GOT_KENYA
	disappear 12
	jumptext .itemDestroyed
.destroyItemQuestion
	text "You're able to"
	line "destroy the"
	cont "skull. Do so?"
	prompt
.itemDestroyed
	text "You destroy the"
	line "skull."
	done
.TCHitem
	opentext
	writetext .touchItemQuestion
	yesorno
	iffalse .Done
	jumptext .touchItemText
.touchItemQuestion
	text "The skull is"
	line "within reach."
	cont "Touch it?"
	prompt
.touchItemText
	text "You feel a"
	line "skull."
	done

.PotionPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00	

.lookAtPotion
	lb bc, BANK(SkullPic), 6*7
	ld hl, SkullPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .PotionPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.PotionPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.LOKitem
	callasm .lookAtPotion
	waitbutton
	jumptext .lookAtItem
.lookAtItem
	text "You see a skull."
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
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_GOT_KENYA
	disappear 12
	giveitem FULL_HEAL, 1
	iffalse .oops
	jumptext .takeitemtext
.oops
	jumptext .packfull
.packfull
	text "But your pack is"
	line "full."
	done
.takeitemquestion
	text "You are able to"
	line "take the skull."
	prompt
.takeitemtext
	text "Nothing happens"
	line "as you take"
	cont "the skull."
	done
.doSo
	text "Do so?"
	prompt
.Done
	closetext
	end
.INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
.TLKmap
	jumptext .talkmap
.talkmap
	text "No response."
	done
bonesScript
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
.ATKitem
	opentext
	writetext .destroyItemQuestion
	yesorno
	iffalse .Done
	setevent EVENT_BEAT_YOUNGSTER_JOEY
	disappear 5
	jumptext .itemDestroyed
.destroyItemQuestion
	text "You're able to"
	line "destroy the"
	cont "bones. Do so?"
	prompt
.itemDestroyed
	text "You destroy the"
	line "bones."
	done
.TCHitem
	opentext
	writetext .touchItemQuestion
	yesorno
	iffalse .Done
	jumptext .touchItemText
.touchItemQuestion
	text "The bones are"
	line "within reach."
	cont "Touch them?"
	prompt
.touchItemText
	text "You feel some"
	line "bones."
	done

.PotionPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00	

.lookAtPotion
	lb bc, BANK(BonesPic), 6*7
	ld hl, BonesPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .PotionPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.PotionPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.LOKitem
	callasm .lookAtPotion
	waitbutton
	jumptext .lookAtItem
.lookAtItem
	text "You see a pile of"
	line "3 bones."
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
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_BEAT_YOUNGSTER_JOEY
	disappear 5
	giveitem FULL_RESTORE, 3
	iffalse .oops
	jumptext .takeitemtext
.oops
	jumptext .packfull
.packfull
	text "But your pack is"
	line "full."
	done
.takeitemquestion
	text "You are able to"
	line "take the bones."
	prompt
.takeitemtext
	text "Nothing happens"
	line "as you take"
	cont "the bones."
	done
.doSo
	text "Do so?"
	prompt
.Done
	closetext
	end
.INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
.TLKmap
	jumptext .talkmap
.talkmap
	text "No response."
	done
bonesScript2
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
.ATKitem
	opentext
	writetext .destroyItemQuestion
	yesorno
	iffalse .Done
	setevent EVENT_GAVE_KENYA
	disappear 13
	jumptext .itemDestroyed
.destroyItemQuestion
	text "You're able to"
	line "destroy the"
	cont "bones. Do so?"
	prompt
.itemDestroyed
	text "You destroy the"
	line "bones."
	done
.TCHitem
	opentext
	writetext .touchItemQuestion
	yesorno
	iffalse .Done
	jumptext .touchItemText
.touchItemQuestion
	text "The bones are"
	line "within reach."
	cont "Touch them?"
	prompt
.touchItemText
	text "You feel some"
	line "bones."
	done

.PotionPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00	

.lookAtPotion
	lb bc, BANK(BonesPic), 6*7
	ld hl, BonesPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .PotionPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.PotionPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.LOKitem
	callasm .lookAtPotion
	waitbutton
	jumptext .lookAtItem
.lookAtItem
	text "You see a pile of"
	line "3 bones."
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
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_GAVE_KENYA
	disappear 13
	giveitem FULL_RESTORE, 3
	iffalse .oops
	jumptext .takeitemtext
.oops
	jumptext .packfull
.packfull
	text "But your pack is"
	line "full."
	done
.takeitemquestion
	text "You are able to"
	line "take the bones."
	prompt
.takeitemtext
	text "Nothing happens"
	line "as you take"
	cont "the bones."
	done
.doSo
	text "Do so?"
	prompt
.Done
	closetext
	end
.INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
.TLKmap
	jumptext .talkmap
.talkmap
	text "No response."
	done
bannerScript
	jumpstd trashcan
plantScript2
	jumpstd elevatorbutton