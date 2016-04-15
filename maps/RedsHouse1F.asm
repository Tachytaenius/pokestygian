RedsHouse1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RedsHouse1F_MapEventHeader:: db 0, 0

.Warps: db 1
	warp_def 5, 3, 2, PALLET_TOWN

.CoordEvents: db 0

.BGEvents: db 0

.ObjectEvents: db 1
	person_event SPRITE_CAL, 2, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, .VernixScript, -1

.USEno
	jumptext .cannotUse
.cannotUse
	text "There is no way"
	line "to use that."
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
.VernixScript
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKno
	if_equal 2, .TCHVernix
	if_equal 3, .TLKVernix
	if_equal 4, .LOKVernix
	if_equal 5, .INGno
	if_equal 6, .TKEno
	if_equal 7, .USEno
	end
.TCHVernix
	opentext
	writetext .withinReachVernix
	yesorno
	iffalse .Done
	faceplayer
	showemote EMOTE_FISH, LAST_TALKED, 15
	jumptext .VernixWhat
.withinReachVernix
	text "The green goblin"
	line "is within your"
	para "reach of touch."
	line "Touch it?"
	prompt
.VernixWhat
	text "Vernix: [Oi!]"
	done
.LOKVernix
	callasm .lookAtVernix
	waitbutton
	jumptext .lookVernix
.lookVernix
	text "You see see a"
	line "friendly green"
	cont "goblin."
	done
.greetingsFromVernix
	text "Vernix: [Hello.]"
	done
.anyMore
	text "Vernix: [What more"
	line "can I do for you?]"
	done
.loopVernix
	writetext .anyMore
	jump .loopReturn
.TLKVernix
	opentext
	loadmenudata .Greet
	verticalmenu
	closewindow
	if_equal 2, .Done
	faceplayer
	writetext .greetingsFromVernix
	buttonsound
.loopReturn
	loadmenudata .What
	verticalmenu
	closewindow
	if_equal 1, .WhatOne
	if_equal 2, .WhatTwo
	if_equal 3, .WhatThree
	; WhatFour
	jumptext .ohokthen
.ohokthen
	text "Vernix: [My pleas-"
	line "ure.]"
	done
.Greet
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Greet2
	db 1 ; default option
.Greet2
	db $81 ; flags
	db 2 ; items
	db "[Greetings.]@"
	db "Cancel@"
.Done
	closetext
	end
.raceMore
	text "Vernix: [Anything"
	line "else?"
	done
.lookAtVernix
	ld hl, .goblinPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	ld a, BANK(.goblinPalette)
	ld [wPaletteBankBuffer], a
	lb bc, BANK(GoblinPic), 6*8
	ld hl, GoblinPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	callba Personpic
	ret
.goblinPalette
	RGB 31, 31, 31
INCLUDE "gfx/trainers/will.pal"
	RGB 00, 00, 00
.loopRace
	writetext .raceMore
	buttonsound
	jump .loopRaceReturn
.WhatOne
	writetext .bastardGreys
	buttonsound
	jump .loopVernix
.WhatTwo
	writetext .describePeople
	buttonsound
	jump .loopVernix
.WhatThree
	writetext .tellAughtOfTheAbyss
	buttonsound
.loopRaceReturn
	loadmenudata .tellMeOf
	verticalmenu
	closewindow
	if_equal 1, .bastards
	if_equal 2, .us
	if_equal 3, .humans
	jump .loopVernix
.tellMeOf
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .tellMeOf2
	db 1 ; default option
.tellMeOf2
	db $81 ; flags
	db 4 ; items
	db "[Grey goblins?]@"
	db "[Green goblins?]@"
	db "[Humans?]@"
	db "[Never mind.]@"
.bastards
	writetext .bastardGreys
	buttonsound
	jump .loopRace
.us
	writetext .describePeople
	buttonsound
	jump .loopRace
.humans
	writetext .tellOfHumans
	buttonsound
	jump .loopRace
.tellOfHumans
	text "Vernix: [Ah, the"
	line "humans. There were"
	para "never many of them"
	line "in the Abyss, be-"
	para "fore recently. As"
	line "I'm sure you know,"
	para "people, and their"
	line "#mon, fled to"
	para "the Stygian Abyss"
	line "to escape from the"
	para "Armageddon. Most"
	line "of them settled up"
	para "north-east. Their"
	line "leader is called"
	para "Julia. She's got"
	line "ginger hair. You"
	para "should know when"
	line "you see her.]"
	done
.tellAughtOfTheAbyss
	text "Vernix: [The Abyss"
	line "is quite a place,"
	para "let me tell you"
	line "that. There aren't"
	para "many great wonders"
	line "on this level,"
	para "however it'd be"
	line "best to learn of"
	para "what does exist."
	line "There's us, the"
	para "green goblins,"
	line "the bastard grey"
	para "goblins, and an"
	line "enclave of humans"
	para "like you. To be"
	line "honest, I don't"
	para "know any more than"
	line "those things.]"
	done
.bastardGreys
	text "Vernix: [Oh, those"
	line "bastard greys."
	para "They love to come"
	line "to our settlement,"
	para "killing our people"
	line "and stealing our"
	para "items. Their"
	line "leader is called"
	para "Borg. He's got"
	line "a nasty wife,"
	para "Lerp. You'd"
	line "best stay away,"
	para "unless you intend"
	line "to slay them."
	para "Their settlement"
	line "is to the north.]"
	done
.describePeople
	text "Vernix: [Well,"
	line "there's my body-"
	para "guard, Lanugo… uh,"
	line "the guard of the"
	para "treasury; Bill,"
	line "an untalkative"
	para "type of person."
	line "Then there's the"
	para "population of the"
	line "settlement. I,"
	para "Vernix, am the"
	line "king of the green"
	cont "goblins.]"
	done
.What
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .What2
	db 1 ; default option
.What2
	db $81 ; flags
	db 4 ; items
	db "[Grey goblins?]@"
	db "[Your people?]@"
	db "[The Abyss?]@"
	db "[Thank you.]@"