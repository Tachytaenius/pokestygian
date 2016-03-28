KrissHouse2F_MapScriptHeader:
.MapTriggers:
	db 2
	
	dw .Trigger1, 0
	dw off2, 1

.MapCallbacks:
	db 1

	; callbacks
	dbw 1, SetSpawn

.Trigger1:
	checkevent EVENT_KRISS_HOUSE_MOM_1
	iffalse StartGameIntro
triggerswap2
	dotrigger 1
off2:
	end
StartGameIntro:
	pause 30
	showemote EMOTE_SHOCK, PLAYER, 30
	showemote EMOTE_FISH, PLAYER, 15
	opentext
	writetext .StartGameIntroText1
	closetext
	applymovement PLAYER, .Left
	pause 20
	applymovement PLAYER, .Right
	pause 20
	applymovement PLAYER, .Up
	pause 20
	applymovement PLAYER, .Right
	pause 20
	showemote EMOTE_QUESTION, PLAYER, 30
	setevent EVENT_KRISS_HOUSE_MOM_1
	setevent EVENT_GOT_KINGS_ROCK_IN_SLOWPOKE_WELL
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	setevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	setevent EVENT_BEAT_YOUNGSTER_JOEY
	jump triggerswap2

.StartGameIntroText1
	text "<PLAYER>: Huh…?"
	prompt

.Left
	turn_head_left
	step_end
	
.Right
	turn_head_right
	step_end
	
.Up
	turn_head_up
	step_end

.SkipInizialization
	return
	
SetSpawn
	return


	db 0, 0, 0 ; filler
	
.Warp
	warp NONE, $0, $0
	end

KrissHouse2F_MapEventHeader
	; filler
	db 0, 0
	
.Warps
	db 1
	warp_def $3, $5, 1, KRISS_HOUSE_1F

.XYTriggers
	db 0

.Signposts
	db 1
	signpost 3, 5, SIGNPOST_READ, .warp_1Read

.PersonEvents
	db 1
	person_event SPRITE_PAPER, 3, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, .noteActions, EVENT_HEALED_MOOMOO

.lookAtNote
	lb bc, BANK(NotePic), 8*7
	ld hl, NotePic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a
	ld hl, .NotePalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.NotePalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.noteActions
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
	disappear 2
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
	callasm .GoMasterBall
	closetext
	end
.GoMasterBall
	callba MasterBall
	ret

.NotePalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bones.pal"
	RGB 00, 00, 00

.readNoteQuestion
	text "Read the note?"
	line "It's very long."
	prompt
	
.Done
	closetext
	end

.takenotequestion
	text "You are able to"
	line "take the note."
	cont "Do so?"
	prompt
.takenotetext
	text "Nothing happens"
	line "as you take"
	cont "the note."
	done
.oops
	jumptext .packfull
.packfull
	text "Your pack is"
	line "full."
	done

.TKEnote
	opentext
	writetext .takemapquestion
	callstd pokecenternurse ; now checks if the pack is full. true is yes. false is, well... no.
	iftrue .oops
	writetext .doSo
	yesorno
	iffalse .Done
	setevent EVENT_HEALED_MOOMOO
	disappear 2
	giveitem MASTER_BALL, 1
	iffalse .oops
	jumptext .takenotetext
	
.warp_1Read
	jumptext .warp_1ReadText
	
.warp_1ReadText
	text "Ladder down to"
	line "storage cache."
	done

.takemapquestion
	text "You are able to"
	line "take the note."
	prompt
.doSo
	text "Do so?"
	prompt