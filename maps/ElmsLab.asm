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
	text "???: <``>My name is"
	line "Moe.<''>"
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

ElmsLab_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def 9, 5, 2, NEW_BARK_TOWN
	warp_def 1, 5, 1, LAKE_OF_RAGE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 10, 5, SIGNPOST_READ, .leavetext
	signpost 1, 5, SIGNPOST_READ, .leavetext2

.PersonEvents:
	db 7
	person_event SPRITE_CAL, 6, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, .lanugoScript, EVENT_JASMINE_RETURNED_TO_GYM
	person_event SPRITE_SAGE, 7, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .isaacScript, -1
	person_event SPRITE_JANINE, 6, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .moeScript, -1
	person_event SPRITE_FISHING_GURU, 6, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_PINK, PERSONTYPE_SCRIPT, 0, .ankhScript, -1
	person_event SPRITE_SILVER, 1, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .bannerScript, -1
	person_event SPRITE_SILVER, 1, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, .bannerScript, -1
	person_event SPRITE_BILL, 2, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, plantScript, -1
.leavetext2
	jumptext .textleave2
.textleave2
	text "Passage to cavern."
	done
.lanugoScript
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKno
	if_equal 2, .TCHlanugo
	if_equal 3, .TLKlanugo
	if_equal 4, .LOKlanugo
	if_equal 5, .INGno
	if_equal 6, .TKEno
	if_equal 7, .USEno
	end
.TCHlanugo
	opentext
	writetext .withinReachlanugo
	yesorno
	iffalse .Done
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	jumptext .lanugoWhat
.withinReachlanugo
	text "The green goblin"
	line "is within your"
	para "reach of touch."
	line "Touch it?"
	prompt
.lanugoWhat
	text "Lanugo: <``>Hey!<''>"
	done
.LOKlanugo
	callasm .lookAtLanugo
	waitbutton
	jumptext .lookLanugo
.lookLanugo
	text "You see see a"
	line "friendly green"
	cont "goblin."
	done
.greetingsFromlanugo
	text "Lanugo: <``>'Ello.<''>"
	done
.TLKlanugo
	opentext
	loadmenudata .Greet
	verticalmenu
	closewindow
	if_equal 2, .Done
.startTalkingTolanugo
	faceplayer
	writetext .greetingsFromlanugo
	buttonsound
.looplanugo2
	loadmenudata .What3
	verticalmenu
	closewindow
	if_equal 1, .WhatOne3
	if_equal 2, .WhatTwo3
	if_equal 3, .WhatThree3
	; WhatFour
	writetext .ohokthen3
	closetext
	end
.WhatOne3
	writetext .greys
	jump .looplanugo
.greys
	text "Lanugo: <``>Oh, yeah,"
	line "them goblins. Not"
	para "good, ya see--"
	line "evil group, they"
	cont "are. Stay away.<''>"
	prompt
.WhatTwo3
	writetext .myNameIslanugo
	jump .looplanugo
.WhatThree3
	writetext .ohokthen3
	callasm .martNameLanugo
	pokemart MARTTYPE_STANDARD, MART_CHERRYGROVE
	jump .looplanugo
.martNameLanugo
	ld b, 7
	ld hl, StringBuffer3
	ld de, .NameLanugo
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop
	ret
.NameLanugo
	db "Lanugo@"
.ohokthen3
	text "Lanugo: <``>OK.<''>"
	prompt
.myNameIslanugo
	text "Lanugo: <``>Me name's"
	line "Lanugo!<''>"
	prompt
.looplanugo
	writetext .anythingElselanugo
	jump .looplanugo2
.anythingElselanugo
	text "Lanugo: <``>D'you"
	line "need any more?<''>"
	prompt
.What3
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .What3a
	db 1 ; default option
.What3a
	db $81 ; flags
	db 4 ; items
	db "<``>Grey goblins…?<''>@"
	db "<``>Your name?<''>@"
	db "<``>May we trade?<''>@"
	db "<``>That is all.<''>@"
	
.leavetext:
	jumptext .leavetextactual
.leavetextactual:
	text "Passage to"
	line "square."
	done
.moeScript
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKno
	if_equal 2, .TCHmoe
	if_equal 3, .TLKmoe
	if_equal 4, .LOKmoe
	if_equal 5, .INGno
	if_equal 6, .TKEno
	if_equal 7, .USEno
.leave
	end
.USEno
	jumptext .cannotUse
.cannotUse
	text "There is no way"
	line "to use that."
	done
.TCHmoe
	opentext
	writetext .withinReachMoe
	yesorno
	iffalse .Done
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	jumptext .moeWhat
.moeWhat
	text "Moe: <``>Don't do"
	line "that!<''>"
	done
.withinReachMoe
	text "The human is"
	line "within your reach"
	para "of touch. Touch"
	line "it?"
	prompt
.TLKmoe
	opentext
	loadmenudata .Greet
	verticalmenu
	closewindow
	if_equal 1, .startTalkingToMoe
.Done
	closetext
	end
.greetingsFromMoe
	text "Moe: <``>Greetings!<''>"
	done
.startTalkingToMoe
	faceplayer
	writetext .greetingsFromMoe
	buttonsound
.loopMoe2
	loadmenudata .What
	verticalmenu
	closewindow
	if_equal 1, .WhatOne
	if_equal 2, .WhatTwo
	if_equal 3, .WhatThree
	; WhatFour
	writetext .ohokthen
	closetext
	end
.WhatOne
	writetext .whatIsAnAnkhResponse
	jump .loopMoe
.WhatTwo
	writetext .myNameIsMoe
	jump .loopMoe
.WhatThree
	writetext .cannotTrade
	jump .loopMoe
.ohokthen
	text "Moe: <``>OK, then.<''>"
	prompt
.loopMoe
	writetext .anythingElseMoe
	jump .loopMoe2
.anythingElseMoe
	text "Moe: <``>Do you"
	line "need any more?<''>"
	prompt
.whatIsAnAnkhResponse
	text "Moe: <``>The symbol"
	line "of the Stygian"
	para "Sun, an entity"
	line "that lies at the"
	para "bottom of the"
	line "Abyss, providing"
	para "ambient light and"
	line "energy.<''>"
	prompt
.whatIsAnAnkhResponse2
	text "Isaac: <``>The logo"
	line "of the Stygian"
	para "Sun, an entity"
	line "that lies at the"
	para "bottom of the"
	line "Abyss, providing"
	para "ambient light and"
	line "energy.<''>"
	prompt
.myNameIsMoe
	text "Moe: <``>My name is"
	line "Moe.<''>"
	prompt
.cannotTrade
	text "Moe: <``>I have nowt"
	line "to barter with.<''>"
	prompt
.Greet
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Greet2
	db 1 ; default option
.Greet2
	db $81 ; flags
	db 2 ; items
	db "<``>Hello!!<''>@"
	db "Cancel@"
.What
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .What2
	db 1 ; default option
.What2
	db $81 ; flags
	db 4 ; items
	db "<``>What's an ankh?<''>@"
	db "<``>Your name?<''>@"
	db "<``>May we trade?<''>@"
	db "<``>That is all.<''>@"
.humanPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/hiker.pal"
	RGB 00, 00, 00
.elfPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/erika.pal"
	RGB 00, 00, 00
.goblinPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/will.pal"
	RGB 00, 00, 00
.lookAtMoe
	ld hl, .humanPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	ld a, BANK(.humanPalette)
	ld [wPaletteBankBuffer], a
	lb bc, BANK(HumanPic), 6*8
	ld hl, HumanPic
	jr .ok
.lookAtLanugo
	ld hl, .goblinPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	ld a, BANK(.goblinPalette)
	ld [wPaletteBankBuffer], a
	lb bc, BANK(GoblinPic), 6*8
	ld hl, GoblinPic
	jr .ok
.lookAtIsaac
	ld hl, .elfPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	ld a, BANK(.elfPalette)
	ld [wPaletteBankBuffer], a
	lb bc, BANK(ElfPic), 6*8
	ld hl, ElfPic
	; jr .ok ; fallthrough, no need
.ok
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	callba Personpic
	ret
.LOKmoe
	callasm .lookAtMoe
	waitbutton
	jumptext .lookMoe
.lookMoe
	text "You see a"
	line "friendly human."
	done
.INGno
	jumptext .ingestNo
.ingestNo
	text "That is not"
	line "edible."
	done
.TKEno
	jumptext .noTke
.noTke
	text "You are unable"
	line "to take that."
	prompt
.ATKno
	jumptext .noAtk
.noAtk
	text "No! You may"
	line "not! You are"
	cont "able, though."
	done
.left
	turn_head_left
	step_end

.up
	turn_head_up
	step_end

.right
	turn_head_right
	step_end
.isaacScript
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKno
	if_equal 2, .TCHIsaac
	if_equal 3, .TLKIsaac
	if_equal 4, .LOKIsaac
	if_equal 5, .INGno
	if_equal 6, .TKEno
	if_equal 7, .USEno
	end
.TCHIsaac
	opentext
	writetext .withinReachIsaac
	yesorno
	iffalse .Done
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	jumptext .IsaacWhat
.IsaacWhat
	text "Isaac: <``>Oi!<''>"
	done
.withinReachIsaac
	text "The elf is"
	line "within your reach"
	para "of touch. Touch"
	line "it?"
	prompt
.TLKIsaac
	opentext
	loadmenudata .Greet2s
	verticalmenu
	closewindow
	if_equal 1, .startTalkingToIsaac
	closetext
	end
.greetingsFromIsaac
	text "Isaac: <``>Hello!<''>"
	done
.startTalkingToIsaac
	faceplayer
	writetext .greetingsFromIsaac
	buttonsound
.loopIsaac2
	opentext
	loadmenudata .What2s
	verticalmenu
	closewindow
	if_equal 1, .WhatOne2
	if_equal 2, .WhatTwo2
	if_equal 3, .WhatThree2
	; WhatFour
	writetext .ohokthen2
	closetext
	end
.loopIsaac
	writetext .anythingElseIsaac
	jump .loopIsaac2
.WhatOne2
	writetext .whatIsAnAnkhResponse2
	jump .loopIsaac
.WhatTwo2
	writetext .myNameIsIsaac
	jump .loopIsaac
.WhatThree2
	writetext .cannotTrade2
	jump .loopIsaac
.ohokthen2
	text "Isaac: <``>All right,"
	line "then.<''>"
	prompt
.anythingElseIsaac
	text "Isaac: <``>Will that"
	line "be all, <PLAYER>?<''>"
	prompt
.loopi
	writetext .anythingElseIsaac
	jump .loopi
.myNameIsIsaac
	text "Isaac: <``>My name is"
	line "Isaac.<''>"
	prompt
.Greet2s
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Greet2a
	db 1 ; default option
.Greet2a
	db $81 ; flags
	db 2 ; items
	db "<``>Greetings.<''>@"
	db "Cancel@"
.What2s
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .What2a
	db 1 ; default option
.What2a
	db $81 ; flags
	db 4 ; items
	db "<``>What's an ankh?<''>@"
	db "<``>May we trade?<''>@"
	db "<``>Your name?" 
	db "<``>That is all.<''>@"
.LOKIsaac
	callasm .lookAtIsaac
	waitbutton
	jumptext .lookIsaac
.lookIsaac
	text "You see a"
	line "friendly elf."
	done
.cannotTrade2
	text "Isaac: <``>I have nowt"
	line "to barter with.<''>"
	prompt
.TLKno
	jumptext .noResponse
.noResponse
	text "No response."
	done
.ankhScript
	jumpstd tv
.bannerScript
	jumpstd trashcan
plantScript
	jumpstd elevatorbutton