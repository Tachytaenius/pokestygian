const_value set 2
	const CIANWOODGYM_CHUCK
	const CIANWOODGYM_BLACK_BELT1
	const CIANWOODGYM_BLACK_BELT2
	const CIANWOODGYM_BLACK_BELT3
	const CIANWOODGYM_BLACK_BELT4
	const CIANWOODGYM_BOULDER1
	const CIANWOODGYM_BOULDER2
	const CIANWOODGYM_BOULDER3
	const CIANWOODGYM_BOULDER4

CianwoodGym_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ChuckScript_0x9d60f:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CHUCK
	iftrue .FightDone
	writetext UnknownText_0x9d6f9
	waitbutton
	closetext
	spriteface CIANWOODGYM_CHUCK, RIGHT
	opentext
	writetext UnknownText_0x9d76f
	waitbutton
	closetext
	applymovement CIANWOODGYM_BOULDER1, MovementData_0x9d6f3
	playsound SFX_STRENGTH
	earthquake 80
	disappear CIANWOODGYM_BOULDER1
	pause 30
	faceplayer
	opentext
	writetext UnknownText_0x9d78a
	waitbutton
	closetext
	winlosstext UnknownText_0x9d7f6, 0
	loadtrainer CHUCK, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CHUCK
	opentext
	writetext UnknownText_0x9d835
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_STORMBADGE
	checkcode VAR_BADGES
	scall CianwoodGymTriggerRockets
.FightDone
	checkevent EVENT_GOT_TM01_DYNAMICPUNCH
	iftrue UnknownScript_0x9d67b
	setevent EVENT_BEAT_BLACKBELT_YOSHI
	setevent EVENT_BEAT_BLACKBELT_LAO
	setevent EVENT_BEAT_BLACKBELT_NOB
	setevent EVENT_BEAT_BLACKBELT_LUNG
	writetext UnknownText_0x9d84d
	buttonsound
	verbosegiveitem TM_DYNAMICPUNCH
	iffalse UnknownScript_0x9d67f
	setevent EVENT_GOT_TM01_DYNAMICPUNCH
	writetext UnknownText_0x9d8da
	waitbutton
	closetext
	end

UnknownScript_0x9d67b:
	writetext UnknownText_0x9d930
	waitbutton
UnknownScript_0x9d67f:
	closetext
	end

CianwoodGymTriggerRockets:
	if_equal 7, .RadioTowerRockets
	if_equal 6, .GoldenrodRockets
	end

.GoldenrodRockets
	jumpstd goldenrodrockets

.RadioTowerRockets
	jumpstd radiotowerrockets

TrainerBlackbeltYoshi:
	trainer EVENT_BEAT_BLACKBELT_YOSHI, BLACKBELT_T, YOSHI, BlackbeltYoshiSeenText, BlackbeltYoshiBeatenText, 0, BlackbeltYoshiScript

BlackbeltYoshiScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x9d9fa
	waitbutton
	closetext
	end

TrainerBlackbeltLao:
	trainer EVENT_BEAT_BLACKBELT_LAO, BLACKBELT_T, LAO, BlackbeltLaoSeenText, BlackbeltLaoBeatenText, 0, BlackbeltLaoScript

BlackbeltLaoScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x9da61
	waitbutton
	closetext
	end

TrainerBlackbeltNob:
	trainer EVENT_BEAT_BLACKBELT_NOB, BLACKBELT_T, NOB, BlackbeltNobSeenText, BlackbeltNobBeatenText, 0, BlackbeltNobScript

BlackbeltNobScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x9dac0
	waitbutton
	closetext
	end

TrainerBlackbeltLung:
	trainer EVENT_BEAT_BLACKBELT_LUNG, BLACKBELT_T, LUNG, BlackbeltLungSeenText, BlackbeltLungBeatenText, 0, BlackbeltLungScript

BlackbeltLungScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x9db14
	waitbutton
	closetext
	end

CianwoodGymBoulder:
	jumpstd strengthboulder

CianwoodGymStatue:
	checkflag ENGINE_STORMBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten
	trainertotext CHUCK, 1, $1
	jumpstd gymstatue2

MovementData_0x9d6f3:
	db $39 ; movement
	big_step_left
	big_step_up
	fast_jump_step_right
	db $38 ; movement
	step_end

UnknownText_0x9d6f9:
	text "WAHAHAH!"

	para "So you've come"
	line "this far!"

	para "Let me tell you,"
	line "I'm tough!"

	para "My #mon will"
	line "crush stones and"
	cont "shatter bones!"

	para "Watch this!"
	done

UnknownText_0x9d76f:
	text "CHUCK: Urggh!"
	line "…"

	para "Oooarrgh!"
	done

UnknownText_0x9d78a:
	text "There! Scared now,"
	line "are you?"

	para "What?"
	line "It has nothing to"

	para "do with #mon?"
	line "That's true!"

	para "Come on. We shall"
	line "do battle!"
	done

UnknownText_0x9d7f6:
	text "Wha? Huh?"
	line "I lost?"

	para "How about that!"
	line "You're worthy of"
	cont "STORMBADGE!"
	done

UnknownText_0x9d835:
	text "<PLAYER> received"
	line "STORMBADGE."
	done

UnknownText_0x9d84d:
	text "STORMBADGE makes"
	line "all #mon up to"

	para "L70 obey, even"
	line "traded ones."

	para "It also lets your"
	line "#mon use FLY"

	para "when you're not in"
	line "a battle."

	para "Here, take this"
	line "too!"
	done

UnknownText_0x9d8da:
	text "That is DYNAMIC-"
	line "PUNCH."

	para "It doesn't always"
	line "hit, but when it"

	para "does, it causes"
	line "confusion!"
	done

UnknownText_0x9d930:
	text "WAHAHAH! I enjoyed"
	line "battling you!"

	para "But a loss is a"
	line "loss!"

	para "From now on, I'm"
	line "going to train 24"
	cont "hours a day!"
	done

BlackbeltYoshiSeenText:
	text "My #mon and I"
	line "are bound togeth-"
	cont "er by friendship."

	para "Our bond will"
	line "never be broken!"
	done

BlackbeltYoshiBeatenText:
	text "This isn't real!"
	done

UnknownText_0x9d9fa:
	text "You seem to have a"
	line "strong bond with"
	cont "your #mon too!"
	done

BlackbeltLaoSeenText:
	text "We martial artists"
	line "fear nothing!"
	done

BlackbeltLaoBeatenText:
	text "That's shocking!"
	done

UnknownText_0x9da61:
	text "Fighting #mon"
	line "are afraid of psy-"
	cont "chics…"
	done

BlackbeltNobSeenText:
	text "Words are useless."
	line "Let your fists do"
	cont "the talking!"
	done

BlackbeltNobBeatenText:
	text "…"
	done

UnknownText_0x9dac0:
	text "I lost! "
	line "I'm speechless!"
	done

BlackbeltLungSeenText:
	text "My raging fists"
	line "will shatter your"
	cont "#mon!"
	done

BlackbeltLungBeatenText:
	text "I got shattered!"
	done

UnknownText_0x9db14:
	text "My #mon lost…"
	line "My… my pride is"
	cont "shattered…"
	done

CianwoodGym_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $11, $4, 2, CIANWOOD_CITY
	warp_def $11, $5, 2, CIANWOOD_CITY

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 15, 3, SIGNPOST_READ, CianwoodGymStatue
	signpost 15, 6, SIGNPOST_READ, CianwoodGymStatue

.PersonEvents:
	db 9
	person_event SPRITE_CHUCK, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ChuckScript_0x9d60f, -1
	person_event SPRITE_BLACK_BELT, 12, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerBlackbeltYoshi, -1
	person_event SPRITE_BLACK_BELT, 12, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerBlackbeltLao, -1
	person_event SPRITE_BLACK_BELT, 9, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerBlackbeltNob, -1
	person_event SPRITE_BLACK_BELT, 5, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerBlackbeltLung, -1
	person_event SPRITE_BOULDER, 1, 5, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	person_event SPRITE_BOULDER, 7, 3, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	person_event SPRITE_BOULDER, 7, 4, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	person_event SPRITE_BOULDER, 7, 5, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
