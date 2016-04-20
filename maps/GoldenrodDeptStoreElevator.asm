GoldenrodDeptStoreElevator_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

GoldenrodDeptStoreElevator_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def 5, 3, 3, PALLET_TOWN
	
.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 6, 3, SIGNPOST_READ, .gobset

.PersonEvents:
	db 1
	person_event SPRITE_BILL, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, .plantScript, -1
.plantScript
	jumpstd elevatorbutton
.gobset
	jumptext .gobset_
.gobset_
	text "Passage to green"
	line "goblin settlement."
	done