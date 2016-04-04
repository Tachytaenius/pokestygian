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

.Warps: db 1
	warp_def 31, 15, 2, ELMS_LAB

.CoordEvents: db 0

.BGEvents: db 5
	signpost 32, 15, SIGNPOST_READ, .shrine
	signpost 32, 9, SIGNPOST_READ, y16x4
	signpost 33, 9, SIGNPOST_READ, y16x4
	signpost 13, 13, SIGNPOST_READ, x6y6
	signpost 12, 13, SIGNPOST_READ, x6y6

.ObjectEvents: db 1
	person_event SPRITE_POKE_BALL, 30, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, monactions, EVENT_109

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
	iffalse .finish
	setevent EVENT_105
	changeblock 12, 12, 2
	reloadmappart
	jumptext broken
.finish
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
	text "No response."
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
