BlackthornGym1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

BlackthornGym1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def 15, 3, 2, BLACKTHORN_CITY

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 16, 3, SIGNPOST_READ, .ruins

.PersonEvents:
	db 0

.ruins
	jumptext .ruins_
.ruins_
	text "Passage to ruins."
	done
dummy
	end
LoadDeadGrey
	ld hl, DeadGoblinPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	ret
encounterggob1
	setlasttalked 2
	checkevent EVENT_110
	iftrue .leave
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	applymovement PLAYER, .lookUp
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
	setevent EVENT_ROUTE_30_YOUNGSTER_JOEY
.leave
	end
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