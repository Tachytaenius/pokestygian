KrissHouse1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

KrissHouse1F_MapEventHeader:
	; filler
	db 0, 0
	
.Warps:
	db 2
	warp_def $3, $7, 1, KRISS_HOUSE_2F
	warp_def $5, $3, 1, NEW_BARK_TOWN

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 3, 7, SIGNPOST_READ, .warp1read
	signpost 6, 3, SIGNPOST_READ, .warp2read
	
.PersonEvents:
	db 8
	person_event SPRITE_PAPER, 2, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, .map1Actions, EVENT_GOT_OLD_ROD ;done
	person_event SPRITE_POKEDEX, 3, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, .magicBookActions, EVENT_GOT_A_POKEMON_FROM_ELM ;done
	person_event SPRITE_POKE_BALL, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_RED, PERSONTYPE_SCRIPT, 0, .firstMonActions, EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE ;done
	person_event SPRITE_PAPER, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, .note1Actions, EVENT_GOT_KINGS_ROCK_IN_SLOWPOKE_WELL ;done
	person_event SPRITE_BOULDER, 5, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, .blockedActions, EVENT_GOT_SUPER_ROD ;done
	person_event SPRITE_N64, 5, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, .ItemFragment_PokerusInfectionDevice1Actions, EVENT_MOUNT_MORTAR_2F_INSIDE_MAX_POTION ;done
	person_event SPRITE_VIRTUAL_BOY, 1, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, .pushButtonHealMonActions, -1 ;done
	person_event SPRITE_FISHING_GURU, 2, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_OW_TREE, PERSONTYPE_SCRIPT, 0, .crystalBallActions, -1 

.warp1read
	jumptext .warp1text
.warp2read
	jumptext .warp2text
.warp1text
	text "Ladder up to"
	line "initial room."
	done
.warp2text
	text "Opening to"
	line "square."
	done
.NotePalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00
.PokeballPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/poke.pal"
	RGB 00, 00, 00
.boulderPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/boulder.pal"
	RGB 00, 00, 00
.GelPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/gel.pal"
	RGB 00, 00, 00
.lookAtNote
	lb bc, BANK(NotePic), 6*7
	ld hl, NotePic
	
	ld hl, .NotePalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a

	ld a, BANK(.NotePalette)
	ld [wPaletteBankBuffer], a
	
	jp .ok
.lookAtBall
	lb bc, BANK(BallPic), 6*7
	ld hl, BallPic
	
	ld hl, .GelPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a

	ld a, BANK(.GelPalette)
	ld [wPaletteBankBuffer], a
	
	jr .ok
.lookAtPoke
	lb bc, BANK(PokePic), 6*7
	ld hl, PokePic
	ld hl, .PokeballPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a

	ld a, BANK(.PokeballPalette)
	ld [wPaletteBankBuffer], a
	
	jr .ok
.lookAtBoulder
	lb bc, BANK(BoulderPic), 6*7
	ld hl, BoulderPic
	
	ld hl, .boulderPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a

	ld a, BANK(.boulderPalette)
	ld [wPaletteBankBuffer], a
	
	jr .ok
.lookAtButton
	lb bc, BANK(ButtonPic), 6*7
	ld hl, ButtonPic
	
	ld hl, .boulderPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a

	ld a, BANK(.boulderPalette)
	ld [wPaletteBankBuffer], a
	
	jr .ok
.lookAtBook
	lb bc, BANK(BookPic), 6*7
	ld hl, BookPic
	
	ld hl, .NotePalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a

	ld a, BANK(.NotePalette)
	ld [wPaletteBankBuffer], a
	
	jr .ok
.lookAtGel
	lb bc, BANK(GelPic), 6*7
	ld hl, GelPic

	ld hl, .GelPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a

	ld a, BANK(.GelPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
	;jr .ok ;fallthrough
.ok
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	callba Itempic
	ret
.map1Actions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKmap
	if_equal 2, .TCHmap
	if_equal 3, .TLKmap
	if_equal 4, .LOKmap
	if_equal 5, .INGmap
	if_equal 6, .TKEmap
	if_equal 7, .USEmap
	end
	
.TLKmap
	jumptext .talkmap
.talkmap
	text "No response."
	done

.LOKmap
	callasm .lookAtNote
	waitbutton
	jumptext .lookmap
.lookmap
	text "You see a"
	line "fresh piece of"
	cont "reed parchment."
	done

.INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
	
.ATKmap
	opentext
	writetext .destroymapQuestion
	yesorno
	iffalse .Done
	setevent EVENT_GOT_OLD_ROD
	disappear 2
	writetext .mapDestroyed
	closetext
	end
	
.destroymapQuestion
	text "You are able to"
	line "destroy the note."
	cont "Do so?"
	prompt

.mapDestroyed
	text "You destroy"
	line "the note."
	done

.TCHmap
	opentext
	writetext .touchmapQuestion
	yesorno
	iffalse .Done
	jumptext .touchmapText
.touchmapText
	text "You feel a"
	line "fresh piece of"
	cont "reed parchment."
	done
	
.touchmapQuestion
	text "The note is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.USEmap
	opentext
	callasm .GoGreatBall
	closetext
	end
.GoGreatBall
	callba GreatBall
	ret

.readmapQuestion
	text "Read the note?"
	line "It's quite short."
	prompt

.TKEmap
	opentext
	writetext .takemapquestion
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_GOT_OLD_ROD
	disappear 2
	giveitem POKE_BALL, 1
	iffalse .oops
	jumptext .takemaptext
.takemapquestion
	text "You're able to"
	line "take the note."
	prompt
.takemaptext
	text "Nothing happens"
	line "as you take"
	cont "the note."
	done

.note1Actions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKnote
	if_equal 2, .TCHnote
	if_equal 3, .TLKnote
	if_equal 4, .LOKnote
	if_equal 5, .INGnote
	if_equal 6, .TKEnote
	if_equal 7, .USEnote
	end
	
.TLKnote
	jumptext .talkNote
.talkNote
	text "No response."
	done

.LOKnote
	callasm .lookAtNote
	waitbutton
	jumptext .lookNote
.lookNote
	text "You see a"
	line "fresh piece of"
	cont "reed parchment."
	done

.INGnote
	jumptext .ingestNoteNo
.ingestNoteNo
	text "That is not"
	line "edible."
	done
	
.ATKnote
	opentext
	writetext .destroyNoteQuestion
	yesorno
	iffalse .Done
	setevent EVENT_HEALED_MOOMOO
	disappear 5
	jumptext .noteDestroyed
	
.destroyNoteQuestion
	text "You are able to"
	line "destroy the note."
	cont "Do so?"
	prompt

.noteDestroyed
	text "You destroy"
	line "the note."
	done

.classicNothing
	text "Nothing happens."
	done

.TCHnote
	opentext
	writetext .touchNoteQuestion
	yesorno
	iffalse .Done
	jumptext .touchNoteText
.touchNoteText
	text "You feel a"
	line "fresh piece of"
	cont "reed parchment."
	done
	
.touchNoteQuestion
	text "The note is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.USEnote
	opentext
	callasm .GoPokeBall
	closetext
	end
.GoPokeBall
	callba PokeBall
	ret
.Done
	closetext
	end

.TKEnote
	opentext
	writetext .takenotequestion
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_GOT_KINGS_ROCK_IN_SLOWPOKE_WELL
	disappear 5
	giveitem GREAT_BALL, 1
	iffalse .oops
	jumptext .takenotetext
.takenotequestion
	text "You are able to"
	line "take the note."
	prompt
.takenotetext
	text "Nothing happens"
	line "as you take"
	cont "the note."
	done
	
.firstMonActions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKmon
	if_equal 2, .TCHmon
	if_equal 3, .TLKmap
	if_equal 4, .LOKmon
	if_equal 5, .INGmon
	if_equal 6, .TKEmon
	if_equal 7, .USEmon
	end

.alreadyGotDex
	text "You already"
	line "have a #dex."
	done

.USEmon
	jumptext .cannotUse

.ATKmon
	jumptext .noAtk
.noAtk
	text "No! You may"
	line "not! You are"
	cont "able, though."
	done

.TCHmon
	opentext
	writetext .touchMonQuestion
	yesorno
	iffalse .Done
	jumptext .touchedMon
.touchedMon
	text "You feel a"
	line "smooth #"
	para "ball. It seems to"
	line "contain a level 5"
	cont "larvitar."
	done
	
.touchMonQuestion
	text "The ball is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
	
.LOKmon
	callasm .lookAtPoke
	waitbutton
	jumptext .lookMonText
.lookMonText
	text "You see a"
	line "metallic #"
	cont "ball."
	done

.INGmon
	jumptext .ingestmonNo
.ingestmonNo
	text "That is not"
	line "edible."
	done

.TKEmon
	opentext
	writetext .monAble
	checkcode VAR_PARTYCOUNT
	if_equal PARTY_LENGTH, .partyfull
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	disappear 4
	givepoke LARVITAR, 5
	clearevent EVENT_GOT_KINGS_ROCK_IN_SLOWPOKE_WELL
	appear 5
	writetext .noteFound
	closetext
	jump .check
.monAble
	text "You are able to"
	line "take the #"
	cont "ball."
	prompt
.partyfull
	jumptext .partytoofull
.partytoofull
	text "But your party is"
	line "full!"
	done
	
.noteFound
	text "There's a note."
	done
	
.magicBookActions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKbook
	if_equal 2, .TCHbook
	if_equal 3, .TLKbook
	if_equal 4, .LOKbook
	if_equal 5, .INGbook
	if_equal 6, .TKEbook
	if_equal 7, .USEitem
	end
.ATKbook
	jumptext .noAtk
.TCHbook
	opentext
	writetext .touchBookQuestion
	yesorno
	iffalse .Done
	jumptext .touchBookDesc
.touchBookQuestion
	text "The #dex is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.touchBookDesc
	text "You feel the rough"
	line "edges of a #-"
	cont "dex."
	done
.TLKbook
	jumptext .talkmap
.LOKbook
	callasm .lookAtBook
	waitbutton
	jumptext .lookBook
.lookBook
	text "You see a"
	line "#dex."
	done
.INGbook
	jumptext .ingestmapNo
.TKEbook
	opentext
	writetext .ablebook
	checkflag ENGINE_POKEDEX
	iftrue .alreadyGotDex
	writetext .doSo
	yesorno
	iffalse .Done
	setflag ENGINE_POKEDEX
	disappear 3
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	closetext
	callasm .dexID
	jump .check
.oops
	jumptext .packfull
.packfull
	text "But your pack is"
	line "full."
	done
.ablebook
	text "You are able to"
	line "take the #dex."
	prompt
	
.dexID
	ld a, 1
	ld [ScriptVar], a
	ret
	
.blockedActions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKblock
	if_equal 2, .TCHblock
	if_equal 3, .TLKmap
	if_equal 4, .LOKblock
	if_equal 5, .INGmap
	if_equal 6, .TKEblock
	if_equal 7, .USEblock
	end

.ATKblock
	jumptext .reckon
.reckon
	text "You reckon you"
	line "would not be able"
	para "to break this"
	line "boulder."
	done
.TCHblock
	opentext
	writetext .touchquestion
	yesorno
	iffalse .Done
	jumptext .touchBlockedDesc
.touchquestion
	text "The boulder is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.touchBlockedDesc
	text "You feel a"
	line "hard, craggy"
	cont "rock's surface."
	done
.LOKblock
	callasm .lookAtBoulder
	waitbutton
	jumptext .lookAtIt
.lookAtIt
	text "You see a"
	line "giant boulder."
	para "It blocks the way"
	line "through the pass-"
	cont "age behind it."
	done

.touchBlockReach
	text "You are able to"
	line "try to take the"
	cont "boulder."
	prompt

.TKEblock
	opentext
	writetext .touchBlockReach
	writetext .doSo
	yesorno
	iffalse .Done
	jumptext .failedToDoSo
.failedToDoSo
	text "It is too heavy"
	line "to pick up."
	done
.USEblock
	jumptext .cannotUse
.cannotUse
	text "There is no way"
	line "to use that."
	done
.reachBlock
	text "The boulder is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.ItemFragment_PokerusInfectionDevice1Actions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKitem
	if_equal 2, .TCHitem
	if_equal 3, .TLKmap
	if_equal 4, .LOKitem
	if_equal 5, .INGmap
	if_equal 6, .TKEitem
	if_equal 7, .USEitem
	end
.ATKitem
	opentext
	writetext .destroyItemQuestion
	yesorno
	iffalse .Done
	setevent EVENT_MOUNT_MORTAR_2F_INSIDE_MAX_POTION
	disappear 7
	jumptext .itemDestroyed
.destroyItemQuestion
	text "You are able to"
	line "destroy the #-"
	cont "rus gels. Do so?"
	prompt
.itemDestroyed
	text "You destroy"
	line "the #rus gels."
	done
.TCHitem
	opentext
	writetext .touchItemQuestion
	yesorno
	iffalse .Done
	jumptext .touchItemText
.touchItemQuestion
	text "The #rus gels"
	line "are within reach."
	cont "Touch them?"
	prompt
.touchItemText
	text "You feel"
	line "the smooth, wet"
	para "and wobbly jelly-"
	line "like surface of"
	cont "the #rus gels."
	done
.LOKitem
	callasm .lookAtGel
	waitbutton
	jumptext .lookAtItem
.lookAtItem
	text "You see 2"
	line "#rus gels."
	done
.USEitem
	jumptext .pickUpFirst
.pickUpFirst
	text "You must"
	line "pick that up"
	cont "first."
	done
.TKEitem
	opentext
	writetext .takeitemquestion
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_MOUNT_MORTAR_2F_INSIDE_MAX_POTION
	disappear 7
	giveitem MAX_POTION, 2
	iffalse .oops
	jumptext .takeitemtext
.takeitemquestion
	text "You're able to"
	line "take the #rus"
	cont "gels."
	prompt
.takeitemtext
	text "Nothing happens"
	line "as you take"
	cont "the #rus gels."
	done
.pushButtonHealMonActions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKmon
	if_equal 2, .TCHbutton
	if_equal 3, .TLKmap
	if_equal 4, .LOKbutton
	if_equal 5, .INGmap
	if_equal 6, .TKEno
	if_equal 7, .USEbutton
	end
.TCHbutton
	opentext
	writetext .inReachButton
	yesorno
	iffalse .Done
	jumptext .buttonTouch
.inReachButton
	text "The button is"
	line "within reach."
	cont "Touch it?"
	prompt
.buttonTouch
	text "You feel a"
	line "makeshift stone"
	cont "button."
	done
.LOKbutton
	callasm .lookAtButton
	waitbutton
	jumptext .lookButton
.lookButton
	text "You see a"
	line "makeshift stone"
	cont "button."
	done
.TKEno
	jumptext .noAtk
.USEbutton
	opentext
	writetext .buttonAble
	yesorno
	iffalse .Done
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalse .noMon
	special HealParty
	jumptext .thyPartyWasHealed
.noMon
	jumptext .butThereIsNoParty
.butThereIsNoParty
	text "But you have"
	line "no party to"
	cont "heal."
	done
.buttonAble
	text "The button is"
	line "within reach."
	cont "Press it?"
	prompt
.thyPartyWasHealed
	text "Thy party was"
	line "healed."
	done
.crystalBallActions
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKmon
	if_equal 2, .TCHball
	if_equal 3, .TLKmap
	if_equal 4, .LOKball
	if_equal 5, .INGmap
	if_equal 6, .TKEno
	if_equal 7, .USEball
	end
.TCHball
	opentext
	writetext .inReachBall
	yesorno
	iffalse .Done
	jumptext .ballTouch
.inReachBall
	text "The ball is"
	line "within reach."
	cont "Touch it?"
	prompt
.ballTouch
	text "You feel a"
	line "smooth crystal"
	cont "ball's surface."
	done
.LOKball
	callasm .lookAtBall
	waitbutton
	jumptext .lookBall
.lookBall
	text "You see a"
	line "smooth crystal"
	cont "ball."
	done
.USEball
	opentext
	writetext .ballAble
	writetext .doSo
	yesorno
	iffalse .Done
	writetext .activate
	special PokemonCenterPC
	jump .Done
.ballAble
	text "You able to"
	line "activate the"
	cont "crystal ball."
	prompt
.activate
	text "You activ-"
	line "ate the crystal"
	cont "ball."
	prompt
.doSo
	text "Do so?"
	prompt
.check
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .check2
.end
	end
.check2
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalse .end
	setevent EVENT_GOT_SUPER_ROD
	disappear 6
	jumptext .okB
.okB
	text "The boulder dis-"
	line "appeared!"
	done