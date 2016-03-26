ElmsLab_MapScriptHeader:
.MapTriggers:
	db 2
	
	dw .Trigger0, 0
	dw .Trigger1, 1

.MapCallbacks:
	db 0

.Trigger0:
	checkevent EVENT_KURT_GAVE_YOU_LURE_BALL
	iftrue .done
.done
	dotrigger 1
.Trigger1:
	end

ElmsLab_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $4, 1, NEW_BARK_TOWN
	warp_def $b, $5, 1, NEW_BARK_TOWN

.XYTriggers:
	db 0

.Signposts:
	db 2
	

.PersonEvents:
	db 6
	person_event SPRITE_ELM, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ProfElmScript, -1
	person_event SPRITE_SCIENTIST, 9, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ElmsAideScript, EVENT_ELMS_AIDE_IN_LAB
	person_event SPRITE_POKE_BALL, 3, 6, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	person_event SPRITE_POKE_BALL, 3, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	person_event SPRITE_POKE_BALL, 3, 8, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	person_event SPRITE_OFFICER, 3, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CopScript, EVENT_COP_IN_ELMS_LAB
