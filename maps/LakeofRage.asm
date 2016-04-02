LakeofRage_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_TILES, x6y6Clear

x6y6Clear
	checkevent EVENT_105
	iffalse Return
	changeblock 12, 12, 2
Return
	return

LakeofRage_MapEventHeader:: db 0, 0

.Warps: db 1
	warp_def 31, 15, 2, ELMS_LAB

.CoordEvents: db 0

.BGEvents: db 3
	signpost 32, 15, SIGNPOST_READ, .shrine
	signpost 13, 13, SIGNPOST_READ, x6y6
	signpost 12, 13, SIGNPOST_READ, x6y6

.ObjectEvents: db 0

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
	writetext .breakable
	yesorno
	iffalse .finish
	setevent EVENT_105
	changeblock 12, 12, 2
	reloadmappart
	jumptext .broken
.finish
	closetext
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