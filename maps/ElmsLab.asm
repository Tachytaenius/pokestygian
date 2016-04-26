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
skipPrompt
	call GetJoypad
	ld a, [hJoyPressed]
	cp 0
	jr z, skipPrompt
	bit 1, a
	jr nz, .yes
	ld a, FALSE
	ld [ScriptVar], a
	ret
.yes
	ld a, TRUE
	ld [ScriptVar], a
	ret
startshrineintro
	opentext
	writetext .skipInstructions
	buttonsound
	callasm skipPrompt
	iftrue .skip
	closetext
	setlasttalked 4
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	pause 15
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .moeSurprise
	closetext
	pause 10
	applymovement 4, .down
	pause 10
	applymovement 4, .approach
	showemote EMOTE_FISH, LAST_TALKED, 15
	opentext
	writetext .introduceMoe
	buttonsound
	loadmenudata .Wha
	verticalmenu
	closewindow
	writetext .greetingsPlayer
	buttonsound
	loadmenudata .DidYouFind
	verticalmenu
	closewindow
	if_equal 1, .good
	if_equal 2, .didYouSeeIt
	if_equal 4, .directions
	writetext .thatWasStupid
	jump .back
.skipInstructions
	text "Push B to skip or"
	line "otherwise to play."
	done
.thatWasStupid
	text "Moe: [That was not"
	line "a good thing. Oh,"
	cont "well.]"
	prompt
.didYouSeeIt
	writetext .didYouSeeIt_
	buttonsound
	loadmenudata .yesno
	verticalmenu
	closewindow
	if_equal 1, .youShouldRead
.directions
	writetext .directions_
	jump .back
.youShouldRead
	writetext .youShouldRead_
	jump .back
.gud
	text "Moe: [Good.]"
	prompt
.didYouSeeIt_
	text "Moe: [Did you see"
	line "it?]"
	done
.yesno
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .yesno2
	db 1 ; default option
.yesno2
	db $81 ; flags
	db 2 ; items
	db "[Yes.]@"
	db "[No.]@"
.directions_
	text "Moe: [Leave this"
	line "shrine, through"
	para "the southern pass-"
	line "age, and continue"
	para "through the square"
	line "to the storage"
	para "cache. Climb the"
	line "ladder, to where"
	para "you awoke. It"
	line "should be there.]"
	prompt
.youShouldRead_
	text "Moe: [You should"
	line "read it.]"
	prompt
.good
	writetext .gud
.back
	writetext .intro1
	applymovement 4, .up
	pause 10
	applymovement 4, .depart
	pause 5
	applymovement 3, .isaacCome
	showemote EMOTE_FISH, 3, 15
	writetext .intro2
	loadmenudata .How
	verticalmenu
	closewindow
	writetext .intro3
	applymovement 3, .isaacGo
	pause 3
	applymovement 2, .lanugoCome
	showemote EMOTE_FISH, 2, 15
	writetext .gems
	applymovement 2, .lanugoGo
.skip
	closetext
	setevent EVENT_KURT_GAVE_YOU_LURE_BALL
	jump triggerswap

.lanugoCome
	turn_head_up
	step_up
	turn_head_right
	step_right
	step_right
	step_right
	turn_head_down
	step_down
	step_down
	step_down
	turn_head_left
	step_left
	turn_head_down
	step_end
.lanugoGo
	turn_head_right
	step_right
	turn_head_up
	step_up
	step_up
	step_up
	turn_head_left
	step_left
	step_left
	step_left
	turn_head_down
	step_down
	step_end
.intro3
	text "Isaac: [For this,"
	line "I will let Lanugo,"
	para "the green goblin,"
	line "explain.]"
	prompt
.gems
	text "Lanugo: [OK… y'see,"
	line "the sixteen gems"
	para "of greater travel"
	line "are ancient arte-"
	para "facts, left by the"
	line "unknown creators"
	para "of the Abyss. We"
	line "only know that"
	para "they are the key"
	line "to leaving Maac"
	para "for Rollennia."
	line "However, there is"
	para "a holy ghost of"
	line "sorts, Eidolon,"
	para "that does know"
	line "what to do with"
	para "them. But it is"
	line "currently dormant."
	para "You will need to"
	line "gather the sixteen"
	para "gems first for it"
	line "to appear on the"
	para "seventh level of"
	line "the Abyss. As for"
	para "actually acquiring"
	line "the gems, we do"
	para "have some leads to"
	line "two of them, on"
	para "levels one and two"
	line "of the Abyss. We"
	para "think that a group"
	line "of nasty goblins;"
	para "grey ones (on this"
	line "level) hold one of"
	para "the gems of grea-"
	line "ter travel. They"
	para "are truly virtue-"
	line "less, deserving"
	para "death. If you can"
	line "kill them all,"
	para "not only will you"
	line "avenge the deaths"
	para "of many innocent"
	line "people, you might"
	para "find one of the"
	line "gems. You'll know"
	para "that it is a gem"
	line "because it is lit-"
	para "erally unseeable."
	line "You will see void,"
	para "but that's fine,"
	line "because of the"
	para "contrast against"
	line "the objects that"
	para "surround it. You"
	line "will have to take"
	para "it. As for the"
	line "other gem, we do"
	para "think that a nice"
	line "group of creatures"
	para "called lizardmen"
	line "have one. If you"
	para "can communicate"
	line "with them, and"
	para "reason with them,"
	line "I'm sure they'll"
	para "give it to you."
	line "Also, you want to"
	para "know why you, spe-"
	line "cifically, are the"
	para "one to embark on"
	line "this quest, yes?"
	para "Isaac, our mystic,"
	line "sensed that you"
	para "bear the arcane"
	line "mark of Eula. This"
	para "means that you are"
	line "a pillar of exist-"
	para "ence, an entity"
	line "that we literally"
	para "could not exist"
	line "without. Your soul"
	para "always has subsi-"
	line "sted, does now,"
	para "and always will."
	line "Because of this"
	para "random occurence"
	line "choosing you, your"
	para "soul, while alive,"
	line "is able to manipu-"
	para "late existence in"
	line "such a way that"
	para "Maac's population"
	line "may leave through"
	para "the Abyss to Roll-"
	line "ennia. Now go, and"
	cont "save us all!]"
	prompt
.isaacCome
	turn_head_right
	step_right
	turn_head_down
	step_down
	step_end
.isaacGo
	turn_head_up
	step_up
	turn_head_left
	step_left
	turn_head_up
	step_end
.intro2
	text "Isaac: [So far,"
	line "no-one knows what"
	para "may have caused"
	line "the Armageddon. We"
	para "do, however, think"
	line "we may have a sol-"
	para "ution to this cri-"
	line "sis. We move to"
	para "another world."
	line "I have scanned the"
	para "inner planes of"
	line "existence, and all"
	para "of the worlds ins-"
	line "ide are suffering"
	para "from the corrupt"
	line "forces of the Arm-"
	para "ageddon. I can"
	line "still scan the"
	para "outer planes of"
	line "existence, and it"
	para "seems that none of"
	line "them do suffer it."
	para "Thus, we have dec-"
	line "ided that the pop-"
	para "ulation of Maac"
	line "shall leave this"
	para "world to travel to"
	line "a promising one in"
	para "the outer planes"
	line "called Rollennia."
	para "However, it is not"
	line "possible to travel"
	para "there by convent-"
	line "ional means."
	para "You will have to"
	line "collect sixteen"
	para "gems, to craft two"
	line "orbs, one for a"
	para "source, Maac, and"
	line "one for a destina-"
	para "tion, Rollennia."
	line "At the bottom of"
	para "the Stygian Abyss"
	line "is a great orb of"
	para "arcanite-- the"
	line "Stygian Sun. This,"
	para "along with the"
	line "sixteen gems of"
	para "greater travel, is"
	line "the key to our"
	cont "salvation.]"
	done
.intro1
	text "Moe: [Anyway… the"
	line "Armageddon started"
	para "two days ago. It"
	line "reduced all life"
	para "on the surface to"
	line "a foul-smelling"
	para "pool of blood,"
	line "within a matter of"
	para "hours. Some people"
	line "managed to get to"
	para "the Stygian Abyss,"
	line "only suffering"
	para "minor burns."
	line "Others had bits of"
	para "their heads sma-"
	line "shed off by the"
	para "deluge of hail-"
	line "stones, or were"
	para "eviscerated by the"
	line "evil fiends that"
	para "came up out of the"
	line "earth. Those part-"
	para "icular people are"
	line "all dead. Before"
	para "the Armageddon,"
	line "you were an appre-"
	para "ntice tinker,"
	line "working for the"
	para "blacksmith in the"
	line "village of Ambon."
	para "A giant hailstone"
	line "hit you on your"
	para "head, only making"
	line "you unconscious."
	para "Isaac, one of"
	line "Ambon's mystics--"
	para "present here right"
	line "now-- sensed that"
	para "the trauma had"
	line "caused your high-"
	para "level memory to be"
	line "mostly destroyed."
	para "Thus, you cannot"
	line "recall any of what"
	para "we are telling you"
	line "had happened. We"
	para "carried you down"
	line "to the first level"
	para "of the Stygian"
	line "Abyss. Our attem-"
	para "ts to wake you up"
	line "all failed, as"
	para "you, even while"
	line "unconscious, atta-"
	para "cked us, in your"
	line "temporary madness."
	para "Thus, we left you"
	line "above the storage"
	para "cache, where you"
	line "could wake up and"
	para "find a few items."
	line "We placed a magic"
	para "boulder, blocking"
	line "the exit out of"
	para "the storage cache,"
	line "that would disa-"
	para "ppear once you had"
	line "acquired the items"
	para "we deemed impor-"
	line "tant, to make sure"
	para "you wouldn't leave"
	line "unprepared. Isaac"
	para "will talk to you"
	line "now.]"
	prompt
.greetingsPlayer
	text "Moe: [Greetings,"
	line "<PLAYER>. Did you"
	cont "read our note?]"
	done
.Wha
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Wha2
	db 1 ; default option
.Wha2
	db $81 ; flags
	db 2 ; items
	db "[I am <PLAYER>.]@"
	db "[It's <PLAYER>.]@"
.How
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .How2
	db 1 ; default option
.How2
	db $81 ; flags
	db 2 ; items
	db "[How?]@"
	db "[By what means?]@"
.DidYouFind
	db $40
	db 00, 00
	db 11, 19
	dw .DidYouFind2
	db 1
.DidYouFind2
	db $81
	db 4
	db "[Ah, yes. I did.]@"
	db "[No, I did not.]@"
	db "[I destroyed it.]@"
	db "[What note?]@"
.introduceMoe
	text "???: [My name is"
	line "Moe. What's yours?]"
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
	turn_head_left
	step_end

.moeSurprise:
	text "???: [You have"
	line "come.]"
	prompt

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
.signActions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKno
	if_equal 2, .TCHsign
	if_equal 3, .TLKno
	if_equal 4, .LOKsign
	if_equal 5, .INGno
	if_equal 6, .TKEno
	if_equal 7, .USEno
.TCHsign
.LOKsign
	end

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
	text "Lanugo: [Hey!]"
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
	text "Lanugo: ['Ello.]"
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
	text "Lanugo: [Oh, yeah,"
	line "them goblins. Not"
	para "good, ya see--"
	line "evil group, they"
	cont "are. Stay away.]"
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
	text "Lanugo: [OK.]"
	prompt
.myNameIslanugo
	text "Lanugo: [Me name's"
	line "Lanugo!]"
	prompt
.looplanugo
	writetext .anythingElselanugo
	jump .looplanugo2
.anythingElselanugo
	text "Lanugo: [D'you"
	line "need any more?]"
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
	db "[Grey goblins…?]@"
	db "[Your name?]@"
	db "[May we trade?]@"
	db "[That is all.]@"
	
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
	text "Moe: [Don't do"
	line "that!]"
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
	text "Moe: [Greetings!]"
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
	text "Moe: [OK, then.]"
	prompt
.loopMoe
	writetext .anythingElseMoe
	jump .loopMoe2
.anythingElseMoe
	text "Moe: [Do you"
	line "need any more?]"
	prompt
.whatIsAnAnkhResponse
	text "Moe: [The symbol"
	line "of the Stygian"
	para "Sun, an entity"
	line "that lies at the"
	para "bottom of the"
	line "Abyss, providing"
	para "ambient light and"
	line "energy.]"
	prompt
.whatIsAnAnkhResponse2
	text "Isaac: [The logo"
	line "of the Stygian"
	para "Sun, an entity"
	line "that lies at the"
	para "bottom of the"
	line "Abyss, providing"
	para "ambient light and"
	line "energy.]"
	prompt
.myNameIsMoe
	text "Moe: [My name is"
	line "Moe.]"
	prompt
.cannotTrade
	text "Moe: [I have nowt"
	line "to barter with.]"
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
	db "[Hello!!]@"
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
	db "[What's an ankh?]@"
	db "[Your name?]@"
	db "[May we trade?]@"
	db "[That is all.]@"
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
	text "Isaac: [Oi!]"
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
	text "Isaac: [Hello!]"
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
	text "Isaac: [All right,"
	line "then.]"
	prompt
.anythingElseIsaac
	text "Isaac: [Will that"
	line "be all, <PLAYER>?]"
	prompt
.myNameIsIsaac
	text "Isaac: [My name is"
	line "Isaac.]"
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
	db "[Greetings.]@"
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
	db "[What's an ankh?]@"
	db "[Your name?]@" 
	db "[May we trade?]@"
	db "[That is all.]@"
.LOKIsaac
	callasm .lookAtIsaac
	waitbutton
	jumptext .lookIsaac
.lookIsaac
	text "You see a"
	line "friendly elf."
	done
.cannotTrade2
	text "Isaac: [I have"
	line "nowt to barter"
	cont "with.]"
	prompt
.TLKno
	jumptext .noResponse
.noResponse
	text "That cannot talk."
	done
.ankhScript
	jumpstd tv
.bannerScript
	jumpstd trashcan
plantScript
	jumpstd elevatorbutton