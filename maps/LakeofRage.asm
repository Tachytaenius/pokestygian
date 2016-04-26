LakeofRage_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_TILES, x6y6Clear

x6y6Clear
	checkevent EVENT_105
	iffalse Continue
	changeblock 12, 12, 2
; y16x4Clear
Continue
	checkevent EVENT_108
	iffalse Return
	changeblock 8, 32, 2
Return
	return

LakeofRage_MapEventHeader:: db 0, 0

.Warps: db 3
	warp_def 31, 15, 2, ELMS_LAB
	warp_def 17, 23, 1, PALLET_TOWN
	warp_def 11, 13, 1, BLACKTHORN_CITY

.CoordEvents: db 0

.BGEvents: db 7
	signpost 32, 15, SIGNPOST_READ, .shrine
	signpost 32, 9, SIGNPOST_READ, y16x4
	signpost 33, 9, SIGNPOST_READ, y16x4
	signpost 13, 13, SIGNPOST_READ, x6y6
	signpost 12, 13, SIGNPOST_READ, x6y6
	signpost 17, 23, SIGNPOST_READ, .gobset
	signpost 11, 13, SIGNPOST_READ, .ruins

.ObjectEvents: db 15
	person_event SPRITE_POKE_BALL, 30, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, monactions, EVENT_109
	person_event SPRITE_CHRIS_BIKE, 20, 37, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, armourActions, EVENT_10A
	person_event SPRITE_BILL, 18, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_BILL, 30, 17, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_BILL, 15, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_BILL, 12, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_BILL, 18, 16, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_BILL, 24, 34, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_BILL, 30, 30, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_BILL, 30, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
	person_event SPRITE_MORTY, 28, 10, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, bones1, EVENT_10B
	person_event SPRITE_MORTY, 30, 36, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, bones2, EVENT_10C
	person_event SPRITE_MORTY, 25, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, skull1, EVENT_10D
	person_event SPRITE_FISHING_GURU, 10, 29, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, .re, -1
	person_event SPRITE_SILVER, 17, 22, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .bannerScript, -1
.gobset
	jumptext .gobset_
.gobset_
	text "Passage to green"
	line "goblin settlement."
	done
.ruins
	jumptext .ruins_
.ruins_
	text "Passage to ruins."
	done
.bannerScript
	jumpstd trashcan
.gr
	jumpstd daytotext
.re
	jumpstd goldenrodrockets
.plantScript
	jumpstd elevatorbutton
.shrine
	jumptext .intoShrine
.intoShrine
	text "Entrance to"
	line "shrine."
	done
Done
	end
x6y6
	checkevent EVENT_105
	iftrue Done
	checkitem CARD_KEY
	iffalse Done
	opentext
	writetext breakable
	yesorno
	iffalse finish
	setevent EVENT_105
	changeblock 12, 12, 2
	reloadmappart
	jumptext broken
finish
	closetext
	end
y16x4
	checkevent EVENT_108
	iftrue Done
	checkitem CARD_KEY
	iffalse Done
	opentext
	writetext breakable
	yesorno
	iffalse .finish
	setevent EVENT_108
	changeblock 8, 32, 2
	reloadmappart
	jumptext broken
.finish
	closetext
	end
broken
	text "You break the rock"
	line "into smaller bits."
	done
breakable
	text "This boulder looks"
	line "breakable! Break"
	para "it with your rock"
	line "hammer?"
	prompt
monactions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKmon
	if_equal 2, .TCHmon
	if_equal 3, .TLKmon
	if_equal 4, .LOKmon
	if_equal 5, .INGmon
	if_equal 6, .TKEmon
	if_equal 7, .USEmon
	end

.USEmon
	jumptext .cannotUse
.cannotUse
	text "There is no way to"
	line "use that."
	prompt
.TLKmon
	jumptext .noresponse
.noresponse
	text "That cannot talk."
	done
.ATKmon
	jumptext .noAtk
.noAtk
	text "No! You may"
	line "not! You are"
	cont "able, though."
	done

.TCHmon
	opentext
	writetext .touchMonQuestion
	yesorno
	iffalse .Done
	jumptext .touchedMon
.touchedMon
	text "You feel a"
	line "smooth #"
	para "ball. It seems to"
	line "contain a level 5"
	cont "eevee."
	done
	
.touchMonQuestion
	text "The ball is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
	
.LOKmon
	callasm .lookAtPoke
	waitbutton
	jumptext .lookMonText
.lookMonText
	text "You see a"
	line "metallic #"
	cont "ball."
	done
.INGmon
	jumptext .ingestmonNo
.ingestmonNo
	text "That is not"
	line "edible."
	done
.doSo
	text "Do so?"
	prompt
.TKEmon
	opentext
	writetext .monAble
	checkcode VAR_PARTYCOUNT
	if_equal PARTY_LENGTH, .partyfull
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_109
	disappear 2
	givepoke EEVEE, 5
	closetext
	jumptext .nothingHappensMon
.Done
	closetext
	end
.PokeballPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/poke.pal"
	RGB 00, 00, 00
.lookAtPoke
	ld hl, .PokeballPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a

	ld a, BANK(.PokeballPalette)
	ld [wPaletteBankBuffer], a
	
	lb bc, BANK(PokePic), 6*7
	ld hl, PokePic
	
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	callba Itempic
	ret
.nothingHappensMon
	text "Nothing happens as"
	line "you take the #"
	cont "ball."
	done
.monAble
	text "You are able to"
	line "take the #"
	cont "ball."
	prompt
.partyfull
	jumptext .partytoofull
.partytoofull
	text "But your party is"
	line "full!"
	done
armourActions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKarmour
	if_equal 2, .TCHarmour
	if_equal 3, .TLKarmour
	if_equal 4, .LOKarmour
	if_equal 5, .INGarmour
	if_equal 6, .TKEarmour
	if_equal 7, .USEarmour
	end

.ATKarmour
	jumptext .noAtk
.noAtk
	text "No! You may"
	line "not! You are"
	cont "able, though."
	done

.TCHarmour
	opentext
	writetext .reachOfTouch
	yesorno
	iffalse finish
	jumptext .feel
.feel
	text "You feel a hard"
	line "suit of armour."
	done
.TLKarmour
	jumptext .no
.no
	text "That cannot talk."
	done

.LOKarmour
	callasm .lokarmour
	waitbutton
	jumptext .seenArmour
.seenArmour
	text "You see a suit of"
	line "armour."
	done
.lokarmour
	lb bc, BANK(ArmourPic), 6*7
	ld hl, ArmourPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	
	ld hl, .ArmourPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.ArmourPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.ArmourPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/armour.pal"
	RGB 00, 00, 00
.INGarmour
	jumptext .inedible
.inedible
	text "That is inedible."
	done
.TKEarmour
	opentext
	writetext .armourQ
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse finish
	setevent EVENT_10A
	disappear 3
	giveitem BICYCLE, 1
	iffalse .oops
	jumptext .nowt
.armourQ
	text "You're able to"
	line "take the armour."
	prompt
.doSo
	text "Do so?"
	prompt
.nowt
	text "Nothing happens"
	line "as you take"
	cont "the armour."
	done
.reachOfTouch
	text "The armour is"
	line "within reach."
	cont "Touch it?"
	prompt
.oops
	jumptext .packfull
.packfull
	text "But your pack is"
	line "full."
	done
.USEarmour
	jumptext .noCanDo
.noCanDo
	text "There is no way to"
	line "use that."
	done
bones1
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
	setevent EVENT_10B
	disappear 12
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
	setevent EVENT_10B
	disappear 12
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
	text "That cannot talk."
	done
bones2
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
	setevent EVENT_10C
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
	line "2 bones."
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
	setevent EVENT_10C
	disappear 13
	giveitem FULL_RESTORE, 2
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
	text "That cannot talk."
	done
skull1
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
	setevent EVENT_10D
	disappear 14
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
	setevent EVENT_10D
	disappear 14
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
	text "That cannot talk."
	done
