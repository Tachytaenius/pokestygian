BlackthornCity_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

BlackthornCity_MapEventHeader:: db 0, 0

.Warps: db 3
	warp_def 31, 11, 3, LAKE_OF_RAGE
	warp_def 1, 15, 1, BLACKTHORN_GYM_1F
	warp_def 21, 37, 1, CELADON_GYM

.CoordEvents: db 0

.BGEvents: db 3
	signpost 32, 11, SIGNPOST_READ, cavern
	signpost 1, 15, SIGNPOST_READ, grey_goblins
	signpost 21, 37, SIGNPOST_READ, humans

.ObjectEvents: db 0



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
