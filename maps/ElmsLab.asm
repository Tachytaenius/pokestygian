ElmsLab_MapScriptHeader:
.MapTriggers:
	db 2
	
	dw .Trigger1, 0
	dw off, 1
	
.MapCallbacks:
	db 0

.Trigger1:
	checkevent EVENT_KURT_GAVE_YOU_LURE_BALL
	iffalse startshrineintro
triggerswap
	dotrigger 1
off
	end

startshrineintro
	setlasttalked 4
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	pause 15
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .moeSurprise
	pause 20
	closetext
	pause 10
	applymovement 4, .down
	pause 10
	applymovement 4, .approach
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .introduceMoe
	pause 20
	;
	applymovement 4, .up
	pause 10
	applymovement 4, .depart
	closetext
	setevent EVENT_KURT_GAVE_YOU_LURE_BALL
	jump triggerswap
	end

.Wha
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Wha2
	db 1 ; default option
.Wha2
	db $81 ; flags
	db 3 ; items
	db "<``>Greetings, Moe.<''>@"
	db "<``>Um… hello?<''>@"
	db "<``>Was I summoned?<''>@"

.introduceMoe
	text "???: My name is"
	line "Moe."
	done

.down
	turn_head_down
	step_end
.up
	turn_head_up
	step_end
.approach
	step_down
	step_down
	step_end
.depart
	step_up
	step_up
	step_end
.getThemInView
	step_up
	step_end

.moeSurprise:
	text "???: <``>You have"
	line "come.<''>"
	done

ElmsLab_MapEventHeader:: db 0, 0

.Warps: db 1
	warp_def 9, 5, 2, NEW_BARK_TOWN

.CoordEvents: db 0

.BGEvents: db 1
	signpost 10, 5, SIGNPOST_READ, .leavetext

.ObjectEvents: db 6
	person_event SPRITE_CAL, 6, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, .lanugoScript, EVENT_JASMINE_RETURNED_TO_GYM
	person_event SPRITE_SAGE, 7, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .isaacScript, -1
	person_event SPRITE_JANINE, 6, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .moeScript, -1
	person_event SPRITE_FISHING_GURU, 6, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_PINK, PERSONTYPE_SCRIPT, 0, .ankhScript, -1
	person_event SPRITE_SILVER, 1, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .bannerScript, -1
	person_event SPRITE_SILVER, 1, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .bannerScript, -1
