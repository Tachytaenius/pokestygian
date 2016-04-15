const_value set 2
	const CELADONPOKECENTER1F_NURSE
	const CELADONPOKECENTER1F_GENTLEMAN
	const CELADONPOKECENTER1F_PHARMACIST
	const CELADONPOKECENTER1F_COOLTRAINER_F
	const CELADONPOKECENTER1F_SUPER_NERD

CeladonPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x71e22:
	jumpstd pokecenternurse

GentlemanScript_0x71e25:
	jumpstd happinesschecknpc

CooltrainerFScript_0x71e28:
	jumptextfaceplayer UnknownText_0x71e70

PharmacistScript_0x71e2b:
	jumptextfaceplayer UnknownText_0x71ec1

SuperNerdScript_0x71e2e:
	faceplayer
	opentext
	writetext UnknownText_0x71f22
	buttonsound
	writebyte SUICUNE
	special SpecialMonCheck
	iffalse UnknownScript_0x71e46
	special SpecialBeastsCheck
	iftrue UnknownScript_0x71e48
	writetext UnknownText_0x7201a
	waitbutton
UnknownScript_0x71e46:
	closetext
	end

UnknownScript_0x71e48:
	writetext UnknownText_0x71f65
	waitbutton
	closetext
	checkcode VAR_FACING
	if_equal $1, UnknownScript_0x71e5a
	applymovement CELADONPOKECENTER1F_SUPER_NERD, MovementData_0x71e6b
	jump UnknownScript_0x71e5e

UnknownScript_0x71e5a:
	applymovement CELADONPOKECENTER1F_SUPER_NERD, MovementData_0x71e65
UnknownScript_0x71e5e:
	disappear CELADONPOKECENTER1F_SUPER_NERD
	playsound SFX_EXIT_BUILDING
	waitsfx
	end

MovementData_0x71e65:
	step_left
	step_down
	step_down
	step_down
	step_down
	step_end

MovementData_0x71e6b:
	step_down
	step_down
	step_down
	step_down
	step_end

UnknownText_0x71e70:
	text "ERIKA is a master"
	line "of grass #mon."

	para "She'll make you"
	line "pay if you don't"
	cont "watch yourself."
	done

UnknownText_0x71ec1:
	text "TEAM ROCKET's"
	line "hideout is in the"

	para "basement of the"
	line "GAME CORNER."

	para "Oh, wait. That was"
	line "three years ago."
	done

UnknownText_0x71f22:
	text "EUSINE: Hi!"

	para "I'm back visiting"
	line "my hometown."

	para "It's been quite a"
	line "while."
	done

UnknownText_0x71f65:
	text "<PLAYER>, have you"
	line "heard?"

	para "There have been"
	line "fresh rumors of a"

	para "rainbow-colored"
	line "#mon appearing"
	cont "at TIN TOWER."

	para "I've just had my"
	line "party healed, so"

	para "now I'm headed to"
	line "ECRUTEAK."

	para "I'll be seeing"
	line "you, <PLAYER>!"
	done

UnknownText_0x7201a:
	text "Oh, by the way,"
	line "<PLAYER>."

	para "Have you caught"
	line "the legendary"

	para "#mon RAIKOU and"
	line "ENTEI?"

	para $56, $56, $56

	para "Okay…"

	para "If you catch even"
	line "one, I hope that"
	cont "you'll inform me."

	para "I'm counting on"
	line "you, <PLAYER>!"
	done

CeladonPokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $3, 5, CELADON_CITY
	warp_def $7, $4, 5, CELADON_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_NURSE, 1, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x71e22, -1
	person_event SPRITE_GENTLEMAN, 5, 1, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x71e25, -1
	person_event SPRITE_PHARMACIST, 3, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PharmacistScript_0x71e2b, -1
	person_event SPRITE_COOLTRAINER_F, 6, 8, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x71e28, -1
	person_event SPRITE_SUPER_NERD, 3, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x71e2e, EVENT_SET_WHEN_FOUGHT_HO_OH
