const_value set 2
	const ROUTE36_YOUNGSTER1
	const ROUTE36_YOUNGSTER2
	const ROUTE36_WEIRD_TREE
	const ROUTE36_LASS1
	const ROUTE36_FISHER
	const ROUTE36_FRUIT_TREE
	const ROUTE36_ARTHUR
	const ROUTE36_FLORIA
	const ROUTE36_SUICUNE

Route36_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw UnknownScript_0x19400d, 0
	dw UnknownScript_0x19400e, 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_OBJECTS, ArthurCallback

UnknownScript_0x19400d:
	end

UnknownScript_0x19400e:
	end

ArthurCallback:
	checkcode VAR_WEEKDAY
	if_equal THURSDAY, .ArthurAppears
	disappear ROUTE36_ARTHUR
	return

.ArthurAppears
	appear ROUTE36_ARTHUR
	return

Route36SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	spriteface PLAYER, UP
	applymovement ROUTE36_SUICUNE, MovementData_0x194262
	disappear ROUTE36_SUICUNE
	spriteface PLAYER, DOWN
	pause 10
	dotrigger $0
	clearevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	domaptrigger CIANWOOD_CITY, $1
	end

SudowoodoScript:
	checkitem SQUIRTBOTTLE
	iftrue .Fight

	waitsfx
	playsound SFX_SANDSTORM
	applymovement ROUTE36_WEIRD_TREE, SudowoodoShakeMovement
	end

.Fight
	opentext
	writetext UseSquirtbottleText
	yesorno
	iffalse DidntUseSquirtbottleScript
	closetext
	; fallthrough

WateredWeirdTreeScript:: ; export (for when you use Squirtbottle from pack)
	opentext
	writetext UsedSquirtbottleText
	waitbutton
	closetext
	waitsfx
	playsound SFX_SANDSTORM
	applymovement ROUTE36_WEIRD_TREE, SudowoodoShakeMovement
	opentext
	writetext SudowoodoAttackedText
	waitbutton
	closetext
	loadwildmon SUDOWOODO, 20
	startbattle
	setevent EVENT_FOUGHT_SUDOWOODO
	if_equal $2, UnknownScript_0x19407b
	disappear ROUTE36_WEIRD_TREE
	variablesprite SPRITE_WEIRD_TREE, SPRITE_TWIN
	reloadmapafterbattle
	end

DidntUseSquirtbottleScript:
	closetext
	end

UnknownScript_0x19407b:
	reloadmapafterbattle
	applymovement ROUTE36_WEIRD_TREE, MovementData_0x19424b
	disappear ROUTE36_WEIRD_TREE
	variablesprite SPRITE_WEIRD_TREE, SPRITE_TWIN
	special RunCallback_04
	special RefreshSprites
	end

Route36FloriaScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	iftrue .SecondTimeTalking
	setevent EVENT_MET_FLORIA
	writetext FloriaText1
	waitbutton
	closetext
	clearevent EVENT_FLORIA_AT_FLOWER_SHOP
	checkcode VAR_FACING
	if_equal UP, .Up
	applymovement ROUTE36_FLORIA, FloriaMovement1
	disappear ROUTE36_FLORIA
	end

.Up
	applymovement ROUTE36_FLORIA, FloriaMovement2
	disappear ROUTE36_FLORIA
	end

.SecondTimeTalking
	writetext FloriaText2
	waitbutton
	closetext
	end

FisherScript_0x1940b9:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM08_ROCK_SMASH
	iftrue UnknownScript_0x1940da
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue UnknownScript_0x1940cd
	writetext UnknownText_0x19446f
	waitbutton
	closetext
	end

UnknownScript_0x1940cd:
	writetext UnknownText_0x1944d0
	buttonsound
	verbosegiveitem TM_ROCK_SMASH
	iffalse UnknownScript_0x1940de
	setevent EVENT_GOT_TM08_ROCK_SMASH
UnknownScript_0x1940da:
	writetext UnknownText_0x19452c
	waitbutton
UnknownScript_0x1940de:
	closetext
	end

LassScript_0x1940e0:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue UnknownScript_0x1940ee
	writetext UnknownText_0x194626
	waitbutton
	closetext
	end

UnknownScript_0x1940ee:
	writetext UnknownText_0x19469e
	waitbutton
	closetext
	end

TrainerSchoolboyAlan1:
	trainer EVENT_BEAT_SCHOOLBOY_ALAN, SCHOOLBOY, ALAN1, SchoolboyAlan1SeenText, SchoolboyAlan1BeatenText, 0, SchoolboyAlan1Script

SchoolboyAlan1Script:
	writecode VAR_CALLERID, PHONE_SCHOOLBOY_ALAN
	end_if_just_battled
	opentext
	checkflag ENGINE_ALAN
	iftrue UnknownScript_0x194140
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftrue UnknownScript_0x1941b4
	checkcellnum PHONE_SCHOOLBOY_ALAN
	iftrue UnknownScript_0x1941d5
	checkevent EVENT_ALAN_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x194129
	writetext UnknownText_0x1947aa
	buttonsound
	setevent EVENT_ALAN_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1941c9
	jump UnknownScript_0x19412c

UnknownScript_0x194129:
	scall UnknownScript_0x1941cd
UnknownScript_0x19412c:
	askforphonenumber PHONE_SCHOOLBOY_ALAN
	if_equal $1, UnknownScript_0x1941dd
	if_equal $2, UnknownScript_0x1941d9
	trainertotext SCHOOLBOY, ALAN1, $0
	scall UnknownScript_0x1941d1
	jump UnknownScript_0x1941d5

UnknownScript_0x194140:
	scall UnknownScript_0x1941e1
	winlosstext SchoolboyAlan1BeatenText, 0
	copybytetovar wAlanFightCount
	if_equal 4, .Fight4
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight4
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
.Fight3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
.Fight2
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .LoadFight2
.Fight1
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
.LoadFight0
	loadtrainer SCHOOLBOY, ALAN1
	startbattle
	reloadmapafterbattle
	loadvar wAlanFightCount, 1
	clearflag ENGINE_ALAN
	end

.LoadFight1
	loadtrainer SCHOOLBOY, ALAN2
	startbattle
	reloadmapafterbattle
	loadvar wAlanFightCount, 2
	clearflag ENGINE_ALAN
	end

.LoadFight2
	loadtrainer SCHOOLBOY, ALAN3
	startbattle
	reloadmapafterbattle
	loadvar wAlanFightCount, 3
	clearflag ENGINE_ALAN
	end

.LoadFight3
	loadtrainer SCHOOLBOY, ALAN4
	startbattle
	reloadmapafterbattle
	loadvar wAlanFightCount, 4
	clearflag ENGINE_ALAN
	end

.LoadFight4
	loadtrainer SCHOOLBOY, ALAN5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ALAN
	end

UnknownScript_0x1941b4:
	scall UnknownScript_0x1941e5
	verbosegiveitem FIRE_STONE
	iffalse UnknownScript_0x1941c6
	clearflag ENGINE_ALAN_HAS_FIRE_STONE
	setevent EVENT_ALAN_GAVE_FIRE_STONE
	jump UnknownScript_0x1941d5

UnknownScript_0x1941c6:
	jump UnknownScript_0x1941e9

UnknownScript_0x1941c9:
	jumpstd asknumber1m
	end

UnknownScript_0x1941cd:
	jumpstd asknumber2m
	end

UnknownScript_0x1941d1:
	jumpstd registerednumberm
	end

UnknownScript_0x1941d5:
	jumpstd numberacceptedm
	end

UnknownScript_0x1941d9:
	jumpstd numberdeclinedm
	end

UnknownScript_0x1941dd:
	jumpstd phonefullm
	end

UnknownScript_0x1941e1:
	jumpstd rematchm
	end

UnknownScript_0x1941e5:
	jumpstd giftm
	end

UnknownScript_0x1941e9:
	jumpstd packfullm
	end

TrainerPsychicMark:
	trainer EVENT_BEAT_PSYCHIC_MARK, PSYCHIC_T, MARK, PsychicMarkSeenText, PsychicMarkBeatenText, 0, PsychicMarkScript

PsychicMarkScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x19471e
	waitbutton
	closetext
	end

ArthurScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	iftrue ArthurThursdayScript
	checkcode VAR_WEEKDAY
	if_not_equal THURSDAY, ArthurNotThursdayScript
	checkevent EVENT_MET_ARTHUR_OF_THURSDAY
	iftrue .MetArthur
	writetext MeetArthurText
	buttonsound
	setevent EVENT_MET_ARTHUR_OF_THURSDAY
.MetArthur
	writetext ArthurGivesGiftText
	buttonsound
	verbosegiveitem HARD_STONE
	iffalse ArthurDoneScript
	setevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	writetext ArthurGaveGiftText
	waitbutton
	closetext
	end

ArthurThursdayScript:
	writetext ArthurThursdayText
	waitbutton
ArthurDoneScript:
	closetext
	end

ArthurNotThursdayScript:
	writetext ArthurNotThursdayText
	waitbutton
	closetext
	end

Route36Sign:
	jumptext Route36SignText

RuinsOfAlphNorthSign:
	jumptext RuinsOfAlphNorthSignText

Route36TrainerTips1:
	jumptext Route36TrainerTips1Text

Route36TrainerTips2:
	jumptext Route36TrainerTips2Text

FruitTreeScript_0x194247:
	fruittree FRUITTREE_ROUTE_36

SudowoodoShakeMovement:
	db $56 ; shake
	step_end

MovementData_0x19424b:
	fast_jump_step_up
	fast_jump_step_up
	step_end

FloriaMovement1:
	step_down
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

FloriaMovement2:
	step_left
	step_down
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

MovementData_0x194262:
	db $39 ; movement
	fast_jump_step_down
	fast_jump_step_down
	fast_jump_step_down
	fast_jump_step_right
	fast_jump_step_right
	fast_jump_step_right
	db $38 ; movement
	step_end

UseSquirtbottleText:
	text "It's a weird tree."
	line "Use SQUIRTBOTTLE?"
	done

UsedSquirtbottleText:
	text "<PLAYER> used the"
	line "SQUIRTBOTTLE."
	done

SudowoodoAttackedText:
	text "The weird tree"
	line "doesn't like the"
	cont "SQUIRTBOTTLE!"

	para "The weird tree"
	line "attacked!"
	done

FloriaText1:
	text "I'm the FLOWER"
	line "SHOP's FLORIA!"

	para "Listen, listen!"

	para "When I sprinkled"
	line "water on that"

	para "wiggly tree, it"
	line "jumped right up!"

	para "It just has to be"
	line "a #mon."

	para "I bet it would be"
	line "shocked out of its"

	para "disguise if you"
	line "soaked it!"

	para "I know! I'll tell"
	line "my sis and borrow"
	cont "her water bottle!"
	done

FloriaText2:
	text "When I told my sis"
	line "about the jiggly"

	para "tree, she said"
	line "it's dangerous."

	para "If I beat WHITNEY,"
	line "I wonder if she'll"

	para "lend me her water"
	line "bottle…"
	done

UnknownText_0x19446f:
	text "Wa-hey!"

	para "I was going to"
	line "snap that tree"

	para "with my straight-"
	line "arm punch."

	para "But I couldn't!"
	line "I'm a failure!"
	done

UnknownText_0x1944d0:
	text "Did you clear that"
	line "wretched tree?"

	para "I'm impressed!"
	line "I want you to"
	cont "have this."
	done

UnknownText_0x19451a:
	text "<PLAYER> received"
	line "TM08."
	done

UnknownText_0x19452c:
	text "That happens to be"
	line "ROCK SMASH."

	para "You can shatter"
	line "rocks with just a"

	para "single well-aimed"
	line "smack."

	para "If any rocks are"
	line "in your way, just"
	cont "smash 'em up!"
	done

UnknownText_0x1945b8:
	text "An odd tree is"
	line "blocking the way"
	cont "to GOLDENROD CITY."

	para "I wanted to go see"
	line "the huge #mon"

	para "CENTER they just"
	line "opened…"
	done

UnknownText_0x194626:
	text "An odd tree is"
	line "blocking the way"
	cont "to GOLDENROD CITY."

	para "It's preventing"
	line "me from shopping."

	para "Something should"
	line "be done about it."
	done

UnknownText_0x19469e:
	text "That odd tree dis-"
	line "appeared without a"
	cont "trace."

	para "Oh! That tree was"
	line "really a #mon?"
	done

PsychicMarkSeenText:
	text "I'm going to read"
	line "your thoughts!"
	done

PsychicMarkBeatenText:
	text "I misread you!"
	done

UnknownText_0x19471e:
	text "I'd be strong if"
	line "only I could tell"

	para "what my opponent"
	line "was thinking."
	done

SchoolboyAlan1SeenText:
	text "Thanks to my stud-"
	line "ies, I'm ready for"
	cont "any #mon!"
	done

SchoolboyAlan1BeatenText:
	text "Oops! Computation"
	line "error?"
	done

UnknownText_0x1947aa:
	text "Darn. I study five"
	line "hours a day too."

	para "There's more to"
	line "learning than just"
	cont "reading books."
	done

MeetArthurText:
	text "ARTHUR: Who are"
	line "you?"

	para "I'm ARTHUR of"
	line "Thursday."
	done

ArthurGivesGiftText:
	text "Here. You can have"
	line "this."
	done

ArthurGaveGiftText:
	text "ARTHUR: A #mon"
	line "that uses rock-"

	para "type moves should"
	line "hold on to that."

	para "It pumps up rock-"
	line "type attacks."
	done

ArthurThursdayText:
	text "ARTHUR: I'm ARTHUR"
	line "of Thursday. I'm"

	para "the second son out"
	line "of seven children."
	done

ArthurNotThursdayText:
	text "ARTHUR: Today's"
	line "not Thursday. How"
	cont "disappointing."
	done

Route36SignText:
	text "ROUTE 36"
	done

RuinsOfAlphNorthSignText:
	text "RUINS OF ALPH"
	line "NORTH ENTRANCE"
	done

Route36TrainerTips1Text:
	text "TRAINER TIPS"

	para "#mon stats"
	line "vary--even within"
	cont "the same species."

	para "Their stats may be"
	line "similar at first."

	para "However, differ-"
	line "ences will become"

	para "pronounced as the"
	line "#mon grow."
	done

Route36TrainerTips2Text:
	text "TRAINER TIPS"

	para "Use DIG to return"
	line "to the entrance of"
	cont "any place."

	para "It is convenient"
	line "for exploring"

	para "caves and other"
	line "landmarks."
	done

Route36_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $8, $12, 3, ROUTE_36_NATIONAL_PARK_GATE
	warp_def $9, $12, 4, ROUTE_36_NATIONAL_PARK_GATE
	warp_def $d, $2f, 1, ROUTE_36_RUINS_OF_ALPH_GATE
	warp_def $d, $30, 2, ROUTE_36_RUINS_OF_ALPH_GATE

.XYTriggers:
	db 2
	xy_trigger 1, $7, $14, $0, Route36SuicuneScript, $0, $0
	xy_trigger 1, $7, $16, $0, Route36SuicuneScript, $0, $0

.Signposts:
	db 4
	signpost 1, 29, SIGNPOST_READ, Route36TrainerTips2
	signpost 11, 45, SIGNPOST_READ, RuinsOfAlphNorthSign
	signpost 7, 55, SIGNPOST_READ, Route36Sign
	signpost 7, 21, SIGNPOST_READ, Route36TrainerTips1

.PersonEvents:
	db 9
	person_event SPRITE_YOUNGSTER, 13, 20, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerPsychicMark, -1
	person_event SPRITE_YOUNGSTER, 14, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerSchoolboyAlan1, -1
	person_event SPRITE_WEIRD_TREE, 9, 35, SPRITEMOVEDATA_SUDOWOODO, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SudowoodoScript, EVENT_ROUTE_36_SUDOWOODO
	person_event SPRITE_LASS, 8, 51, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LassScript_0x1940e0, -1
	person_event SPRITE_FISHER, 9, 44, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FisherScript_0x1940b9, -1
	person_event SPRITE_FRUIT_TREE, 4, 21, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x194247, -1
	person_event SPRITE_YOUNGSTER, 6, 46, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ArthurScript, EVENT_ROUTE_36_ARTHUR_OF_THURSDAY
	person_event SPRITE_LASS, 12, 33, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route36FloriaScript, EVENT_FLORIA_AT_SUDOWOODO
	person_event SPRITE_SUICUNE, 6, 21, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_36
