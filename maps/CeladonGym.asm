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

.ObjectEvents: db 0

.ruins
	jumptext .ruins_
.ruins_
	text "Passage to ruins."
	done