StdScripts::
	dba PokeCenterNurseScript
	dba DifficultBookshelfScript
	dba PictureBookshelfScript
	dba MagazineBookshelfScript
	dba TeamRocketOathScript
	dba IncenseBurnerScript
	dba MerchandiseShelfScript
	dba TownMapScript
	dba WindowScript
	dba TVScript
	dba HomepageScript
	dba Radio1Script
	dba Radio2Script
	dba TrashCanScript
	dba StrengthBoulderScript
	dba SmashRockScript
	dba PokeCenterSignScript
	dba MartSignScript
	dba GoldenrodRocketsScript
	dba RadioTowerRocketsScript
	dba ElevatorButtonScript
	dba DayToTextScript
	dba BugContestResultsWarpScript
	dba BugContestResultsScript
	dba InitializeEventsScript
	dba AskNumber1MScript
	dba AskNumber2MScript
	dba RegisteredNumberMScript
	dba NumberAcceptedMScript
	dba NumberDeclinedMScript
	dba PhoneFullMScript
	dba RematchMScript
	dba GiftMScript
	dba PackFullMScript
	dba RematchGiftMScript
	dba AskNumber1FScript
	dba AskNumber2FScript
	dba RegisteredNumberFScript
	dba NumberAcceptedFScript
	dba NumberDeclinedFScript
	dba PhoneFullFScript
	dba RematchFScript
	dba GiftFScript
	dba PackFullFScript
	dba RematchGiftFScript
	dba GymStatue1Script
	dba GymStatue2Script
	dba ReceiveItemScript
	dba ReceiveTogepiEggScript
	dba PCScript
	dba GameCornerCoinVendorScript
	dba HappinessCheckScript

PokeCenterNurseScript:
	; now it's an item overflow check
	callasm .check
	end
.check
	ld a, [NumItems]
	cp MAX_ITEMS
	jr nc, .yes
	ld a, 0
	ld [ScriptVar], a
	ret
.yes
	ld a, 1
	ld [ScriptVar], a
	ret
DifficultBookshelfScript:
	farjumptext DifficultBookshelfText

PictureBookshelfScript:
	farjumptext PictureBookshelfText

MagazineBookshelfScript:
	farjumptext MagazineBookshelfText

TeamRocketOathScript:
	farjumptext TeamRocketOathText

IncenseBurnerScript:
	farjumptext IncenseBurnerText

MerchandiseShelfScript:
	farjumptext MerchandiseShelfText

TownMapScript:
	opentext
	farwritetext TownMapText
	waitbutton
	special Special_TownMap
	closetext
	end

WindowScript:
	farjumptext WindowText

TVScript:
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, ATKno
	if_equal 2, .TCHankh
	if_equal 3, TLKno
	if_equal 4, .LOKankh
	if_equal 5, INGno
	if_equal 6, TKEno
	if_equal 7, .USEankh
	end

.Done
	closetext
	end
.TCHankh
	opentext
	writetext .reachAnkh
	yesorno
	iffalse .Done
	jumptext .touchAnkh
.touchAnkh
	text "You feel an ankh"
	line "shrine's smooth"
	cont "metal surface."
	done
.reachAnkh
	text "The ankh shrine"
	line "is within your"
	para "reach of touch."
	line "Touch it?"
	prompt
.LOKankh
	callasm .lookAtAnkh
	waitbutton
	jumptext .seeAnAnkh
.seeAnAnkh
	text "You see an"
	line "ankh shrine."
	done
.lookAtAnkh
	lb bc, BANK(AnkhPic), 6*8
	ld hl, AnkhPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .BloodGreenPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.BloodGreenPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.BloodGreenPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/ankh.pal"
	RGB 00, 00, 00
.USEankh
	opentext
returnLoop
	callasm .prepareForWhat
	writetext .what
	loadmenudata .What
	verticalmenu
	closewindow
	if_equal 1, .money
	if_equal 2, .candies
	if_equal 3, .manyCandies
	if_equal 4, .advice
	closetext
	end
.prepareForWhat
	ld a, "@"
	ld hl, wSeerCaughtLevelString
	ld bc, 4
	call ByteFill

	ld hl, wSeerCaughtLevelString
	ld de, WalkLVLCounter
	lb bc, PRINTNUM_RIGHTALIGN | 1, 3
	call PrintNum
	ret
.sure
	text "Are you sure?"
	prompt
.What
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .What2
	db 1 ; default option
.What2
	db $81 ; flags
	db 5 ; items
	db "¥255 (1LV)@"
	db "1 <PO><KE> orb (1LV)@"
	db "5 <PO><KE> orbs (5LVs)@"
	db "Advice (2LVs)@"
	db "Cancel@"

.what
	text "Pray for what?"
	line "Levels: @"
	text_from_ram wSeerCaughtLevelString
	text "."
	prompt
.money
	callasm .moneyTry
	iffalse failAndReturn
	writetext .sure
	yesorno
	iffalse returnLoop
	callasm .moneyYes
	givemoney 0, 255
	writetext .prayedForMoney
	jump returnLoop
.prayedForMoney
	text "You get ¥255."
	prompt
.moneyYes
	ld b, 1
	callba DeductLevels
	ret
.moneyTry
	ld a, FALSE
	ld [ScriptVar], a
	ld b, 1
	callba TestLevelDeduction
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret

.candies
	callasm .candiesTry
	iffalse failAndReturn
	writetext .sure
	yesorno
	iffalse returnLoop
	callasm .candiesYes
	giveitem RARE_CANDY, 1
	writetext .prayedForCandies
	jump returnLoop
.prayedForCandies
	text "You get 1 #"
	line "orb."
	prompt
.candiesYes
	ld b, 1
	callba DeductLevels
	ret
.candiesTry
	ld a, FALSE
	ld [ScriptVar], a
	ld b, 1
	callba TestLevelDeduction
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret

.manyCandies
	callasm .many_candiesTry
	iffalse failAndReturn
	writetext .sure
	yesorno
	iffalse returnLoop
	callasm .many_candiesYes
	giveitem RARE_CANDY, 5
	writetext .prayedFormany_candies
	jump returnLoop
.prayedFormany_candies
	text "You get 5 #"
	line "orbs."
	prompt
.many_candiesYes
	ld b, 5
	callba DeductLevels
	ret
.many_candiesTry
	ld a, FALSE
	ld [ScriptVar], a
	ld b, 5
	callba TestLevelDeduction
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret
.advice
	callstd homepage
	jump returnLoop
HomepageScript:
	callasm .floor
	if_equal 1, .stygianAbyssFloor1
	jumptext .unknownFloor
.unknownFloor
	text "Unknown floor."
	done
.AdviceYes
	ld b, 2
	callba DeductLevels
	ret
.TryAdvice
	ld a, FALSE
	ld [ScriptVar], a
	ld b, 2
	callba TestLevelDeduction
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret
.stygianAbyssFloor1
	opentext
	checkevent EVENT_63F
	iftrue .check1
	callasm .TryAdvice
	iffalse failAndReturn
	writetext .sure
	yesorno
	iffalse .done
	callasm .AdviceYes
	writetext .advice1
	setevent EVENT_63F
.done
	end
.sure
	text "Are you sure?"
	prompt
.check1
	writetext .sure
	yesorno
	iffalse .done
	writetext .advice1
	writetext .levelsBack
	end
.floor
	ld a, [AnkhFloorBuffer]
	ld [ScriptVar], a
	ret
.advice1
	text "Ankh: [If you are"
	line "having trouble"
	para "finding your way"
	line "through the cavern"
	para "to get to the"
	line "ruins, look for a"
	para "dead end path in"
	line "the square. Search"
	cont "around there.]"
	prompt
.levelsBack
	text "Ankh: [That piece"
	line "of advice was free"
	para "because you had"
	line "already heard it.]"
	prompt
failAndReturn::
	writetext .notEnoughLevels
	jump returnLoop
.notEnoughLevels
	text "You do not have"
	line "enough levels."
	prompt
Radio1Script:
	opentext
	writebyte MAPRADIO_POKEMON_CHANNEL
	special MapRadio
	closetext
	end

Radio2Script:
; Lucky Channel
	opentext
	writebyte MAPRADIO_LUCKY_CHANNEL
	special MapRadio
	closetext
	end

TrashCanScript: ; ankh banner
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, ATKno
	if_equal 2, .TCHbanner
	if_equal 3, TLKno
	if_equal 4, .LOKbanner
	if_equal 5, INGno
	if_equal 6, TKEno
	if_equal 7, USEno
	end
.Done
	closetext
	end
.TCHbanner
	opentext
	writetext .reachbanner
	yesorno
	iffalse .Done
	jumptext .touchbanner
.touchbanner
	text "You feel a cloth"
	line "bannner."
	done
.reachbanner
	text "The ankh banner"
	line "is within your"
	para "reach of touch."
	line "Touch it?"
	prompt
.LOKbanner
	callasm .lookAtBanner
	waitbutton
	jumptext .seeABanner
.seeABanner
	text "You see an"
	line "ankh banner."
	done
.lookAtBanner
	lb bc, BANK(BannerPic), 6*8
	ld hl, BannerPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .BloodGreenPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.BloodGreenPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.BloodGreenPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/banner.pal"
	RGB 00, 00, 00

TLKno
	jumptext .noResponse
.noResponse
	text "That cannot talk."
	done
ATKno
	jumptext .noAtk
.noAtk
	text "No! You may"
	line "not! You are"
	cont "able, though."
	done
INGno
	jumptext .ingestNo
.ingestNo
	text "That is not"
	line "edible."
	done
TKEno
	jumptext .noTke
.noTke
	text "You are unable"
	line "to take that."
	prompt
USEno
	jumptext .cannotUse
.cannotUse
	text "There is no way"
	line "to use that."
	done

PCScript:
	opentext
	special PokemonCenterPC
	closetext
	end

ElevatorButtonScript: ; you're a plant now
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKblock
	if_equal 2, .TCHblock
	if_equal 3, .TLKplant
	if_equal 4, .LOKblock
	if_equal 5, .INGplant
	if_equal 6, .TKEblock
	if_equal 7, .USEblock
	end
 
.ATKblock
	jumptext .reckon
.reckon
	text "It's a very tough"
	line "plant, this."
	para "You reckon you'd"
	line "be unable to break"
	cont "it."
	done
.TCHblock
	opentext
	writetext .touchquestion
	yesorno
	iffalse .Done
	jumptext .touchBlockedDesc
.touchquestion
	text "The plant is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.touchBlockedDesc
	text "You feel a tough,"
	line "strong plant."
	done
.LOKblock
	callasm .lookAtBoulder
	waitbutton
	jumptext .lookAtIt
.lookAtIt
	text "You see a"
	line "plant."
	done

.touchBlockReach
	text "It is rooted deep"
	line "into the ground."
	prompt
.Done
	closetext
	end
.TKEblock
	opentext
	writetext .touchBlockReach
	closetext
	end
.USEblock
	jumptext .cannotUse
.cannotUse
	text "There is no way"
	line "to use that."
	done
.INGplant
	jumptext .inedible
.inedible
	text "That is inedible."
	done
.TLKplant
	jumptext .noResponse
.noResponse
	text "That cannot talk."
	done
.lookAtBoulder
	lb bc, BANK(PlantPic), 6*8
	ld hl, PlantPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .BloodGreenPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.BloodGreenPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.BloodGreenPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bloodGreen.pal"
	RGB 00, 00, 00
StrengthBoulderScript:
	farjump AskStrengthScript

SmashRockScript:
	farjump AskRockSmashScript

PokeCenterSignScript:
	farjumptext PokeCenterSignText

MartSignScript
	farjumptext MartSignText

DayToTextScript:
; green blood stain
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKblock
	if_equal 2, .TCHblock
	if_equal 3, TLKmap
	if_equal 4, .LOKblock
	if_equal 5, INGmap
	if_equal 6, .TKEblock
	if_equal 7, .USEblock
	end
.Done
	closetext
	end

.ATKblock
	jumptext .reckon
.reckon
	text "You reckon you"
	line "would not be able"
	para "to clean off this"
	line "blood stain."
	done
.TCHblock
	opentext
	writetext .touchquestion
	yesorno
	iffalse .Done
	jumptext .touchBlockedDesc
.touchquestion
	text "The stain is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.touchBlockedDesc
	text "You feel the"
	line "pebbly ground"
	para "that the blood"
	line "stained into."
	done
.LOKblock
	callasm .lookAtBoulder
	waitbutton
	jumptext .lookAtIt
.lookAtIt
	text "You see a green"
	line "blood stain."
	done

.touchBlockReach
	text "You reckon you"
	line "would not be able"
	para "to clean off this"
	line "blood stain."
	prompt

.TKEblock
	jumptext .touchBlockReach
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
	text "The stain is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.lookAtBoulder
	lb bc, BANK(BloodPic), 6*8
	ld hl, BloodPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .BloodGreenPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.BloodGreenPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.BloodGreenPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bloodGreen.pal"
	RGB 00, 00, 00

GoldenrodRocketsScript:
; red blood stain
	showemote EMOTE_SAD, LAST_TALKED, 15
	callasm StartMenuSecondary
	if_equal 1, .ATKblock
	if_equal 2, .TCHblock
	if_equal 3, TLKmap
	if_equal 4, .LOKblock
	if_equal 5, INGmap
	if_equal 6, .TKEblock
	if_equal 7, .USEblock
	end
.Done
	closetext
	end
.ATKblock
	jumptext .reckon
.reckon
	text "You reckon you"
	line "would not be able"
	para "to clean off this"
	line "blood stain."
	done
.TCHblock
	opentext
	writetext .touchquestion
	yesorno
	iffalse .Done
	jumptext .touchBlockedDesc
.touchquestion
	text "The stain is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.touchBlockedDesc
	text "You feel the"
	line "pebbly ground"
	para "that the blood"
	line "stained into."
	done
.LOKblock
	callasm .lookAtRedBlood
	waitbutton
	jumptext .lookAtIt
.lookAtIt
	text "You see a red"
	line "blood stain."
	done

.touchBlockReach
	text "You reckon you"
	line "would not be able"
	para "to clean off this"
	line "blood stain."
	prompt

.TKEblock
	jumptext .touchBlockReach
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
	text "The stain is in"
	line "your reach of"
	cont "touch. Touch it?"
	prompt
.lookAtRedBlood
	lb bc, BANK(BloodPic), 6*8
	ld hl, BloodPic
	ld a, h
	ld [ItempicPointer], a
	ld a, l
	ld [ItempicPointer + 1], a

	ld hl, .BloodRedPalette
	ld a, h
	ld [wPaletteHighBuffer], a
	ld a, l
	ld [wPaletteLowBuffer], a
	
	ld a, BANK(.BloodRedPalette)
	ld [wPaletteBankBuffer], a
	
	callba Itempic
	ret
.BloodRedPalette
	RGB 31, 31, 31
INCLUDE "gfx/stygian/bloodRed.pal"
	RGB 00, 00, 00
INGmap
	jumptext .ingestmapNo
.ingestmapNo
	text "That is not"
	line "edible."
	done
	
TLKmap
	jumptext .talkmap
.talkmap
	text "That cannot talk."
	done



RadioTowerRocketsScript:
	setflag ENGINE_ROCKETS_IN_RADIO_TOWER
	setevent EVENT_GOLDENROD_CITY_CIVILIANS
	setevent EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
	clearevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	clearevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	setevent EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_EAST
	specialphonecall SPECIALCALL_WEIRDBROADCAST
	domaptrigger MAHOGANY_TOWN, $1
	end

BugContestResultsWarpScript:
	special ClearBGPalettes
	scall BugContestResults_CopyContestantsToResults
	setevent EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	clearevent EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
	setevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	warp ROUTE_36_NATIONAL_PARK_GATE, $0, $4
	applymovement PLAYER, Movement_ContestResults_WalkAfterWarp

BugContestResultsScript:
	clearflag ENGINE_BUG_CONTEST_TIMER
	clearevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	clearevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	clearevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	clearevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	clearevent EVENT_CONTEST_OFFICER_HAS_BERRY
	opentext
	farwritetext ContestResults_ReadyToJudgeText
	waitbutton
	special BugContestJudging
	RAM2MEM $0
	if_equal 1, BugContestResults_FirstPlace
	if_equal 2, BugContestResults_SecondPlace
	if_equal 3, BugContestResults_ThirdPlace
	farwritetext ContestResults_ConsolationPrizeText
	buttonsound
	waitsfx
	verbosegiveitem BERRY
	iffalse BugContestResults_NoRoomForBerry

BugContestResults_DidNotWin
	farwritetext ContestResults_DidNotWinText
	buttonsound
	jump BugContestResults_FinishUp
; 0xbc2b1

BugContestResults_ReturnAfterWinnersPrize ; 0xbc2b1
	farwritetext ContestResults_JoinUsNextTimeText
	buttonsound

BugContestResults_FinishUp
	checkevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	iffalse BugContestResults_DidNotLeaveMons
	farwritetext ContestResults_ReturnPartyText
	waitbutton
	special ContestReturnMons
BugContestResults_DidNotLeaveMons
	special CheckPartyFullAfterContest
	if_equal $0, BugContestResults_CleanUp
	if_equal $2, BugContestResults_CleanUp
	farwritetext ContestResults_PartyFullText
	waitbutton
BugContestResults_CleanUp
	closetext
	dotrigger $0
	domaptrigger ROUTE_35_NATIONAL_PARK_GATE, $0
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setflag ENGINE_DAILY_BUG_CONTEST
	special PlayMapMusic
	end
; 0xbc31e

BugContestResults_FirstPlace ; 0xbc31e
	setevent EVENT_GAVE_KURT_APRICORNS
	itemtotext SUN_STONE, $1
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem SUN_STONE
	iffalse BugContestResults_NoRoomForSunStone
	jump BugContestResults_ReturnAfterWinnersPrize
; 0xbc332

BugContestResults_SecondPlace ; 0xbc332
	itemtotext EVERSTONE, $1
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem EVERSTONE
	iffalse BugContestResults_NoRoomForEverstone
	jump BugContestResults_ReturnAfterWinnersPrize
; 0xbc343

BugContestResults_ThirdPlace ; 0xbc343
	itemtotext GOLD_BERRY, $1
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	verbosegiveitem GOLD_BERRY
	iffalse BugContestResults_NoRoomForGoldBerry
	jump BugContestResults_ReturnAfterWinnersPrize
; 0xbc354

BugContestResults_NoRoomForSunStone ; 0xbc354
	farwritetext BugContestPrizeNoRoomText
	buttonsound
	setevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	jump BugContestResults_ReturnAfterWinnersPrize
; 0xbc35f

BugContestResults_NoRoomForEverstone ; 0xbc35f
	farwritetext BugContestPrizeNoRoomText
	buttonsound
	setevent EVENT_CONTEST_OFFICER_HAS_EVERSTONE
	jump BugContestResults_ReturnAfterWinnersPrize
; 0xbc36a

BugContestResults_NoRoomForGoldBerry ; 0xbc36a
	farwritetext BugContestPrizeNoRoomText
	buttonsound
	setevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	jump BugContestResults_ReturnAfterWinnersPrize
; 0xbc375

BugContestResults_NoRoomForBerry ; 0xbc375
	farwritetext BugContestPrizeNoRoomText
	buttonsound
	setevent EVENT_CONTEST_OFFICER_HAS_BERRY
	jump BugContestResults_DidNotWin
; 0xbc380

BugContestResults_CopyContestantsToResults ; 0xbc380
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftrue .skip1
	clearevent EVENT_BUG_CATCHING_CONTESTANT_1B
.skip1
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftrue .skip2
	clearevent EVENT_BUG_CATCHING_CONTESTANT_2B
.skip2
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftrue .skip3
	clearevent EVENT_BUG_CATCHING_CONTESTANT_3B
.skip3
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftrue .skip4
	clearevent EVENT_BUG_CATCHING_CONTESTANT_4B
.skip4
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftrue .skip5
	clearevent EVENT_BUG_CATCHING_CONTESTANT_5B
.skip5
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftrue .skip6
	clearevent EVENT_BUG_CATCHING_CONTESTANT_6B
.skip6
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftrue .skip7
	clearevent EVENT_BUG_CATCHING_CONTESTANT_7B
.skip7
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftrue .skip8
	clearevent EVENT_BUG_CATCHING_CONTESTANT_8B
.skip8
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftrue .skip9
	clearevent EVENT_BUG_CATCHING_CONTESTANT_9B
.skip9
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftrue .skip10
	clearevent EVENT_BUG_CATCHING_CONTESTANT_10B
.skip10
	end

InitializeEventsScript:
	setevent EVENT_EARLS_ACADEMY_EARL
	setevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	setevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	setevent EVENT_RADIO_TOWER_CIVILIANS_AFTER
	setevent EVENT_ILEX_FOREST_APPRENTICE
	setevent EVENT_ILEX_FOREST_FARFETCHD
	setevent EVENT_ILEX_FOREST_CHARCOAL_MASTER
	setevent EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_GRUNT_WITH_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_DRAGONITE
	setevent EVENT_RIVAL_TEAM_ROCKET_BASE
	setevent EVENT_BLACKTHORN_CITY_SUPER_NERD_DOES_NOT_BLOCK_GYM
	setevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setevent EVENT_RIVAL_AZALEA_TOWN
	setevent EVENT_RIVAL_UNDERGROUND_PATH
	setevent EVENT_AZALEA_TOWN_SLOWPOKES
	setevent EVENT_KURTS_HOUSE_SLOWPOKE
	setevent EVENT_GUIDE_GENT_VISIBLE_IN_CHERRYGROVE
	setevent EVENT_ELMS_AIDE_IN_VIOLET_POKEMON_CENTER
	setevent EVENT_COP_IN_ELMS_LAB
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST
	setevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	setevent EVENT_BOULDER_IN_ICE_PATH_1A
	setevent EVENT_BOULDER_IN_ICE_PATH_2A
	setevent EVENT_BOULDER_IN_ICE_PATH_3A
	setevent EVENT_BOULDER_IN_ICE_PATH_4A
	setevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setevent EVENT_FAST_SHIP_1F_GENTLEMAN
	setevent EVENT_FAST_SHIP_B1F_SAILOR_RIGHT
	setevent EVENT_FAST_SHIP_CABINS_NNW_NNE_NE_SAILOR
	setevent EVENT_LAKE_OF_RAGE_CIVILIANS
	setevent EVENT_MAHOGANY_MART_OWNERS
	setevent EVENT_TIN_TOWER_ROOF_HO_OH
	setevent EVENT_WHIRL_ISLAND_LUGIA_CHAMBER_LUGIA
	setevent EVENT_KRISS_HOUSE_2F_CONSOLE
	setevent EVENT_KRISS_HOUSE_2F_DOLL_1
	setevent EVENT_KRISS_HOUSE_2F_DOLL_2
	setevent EVENT_KRISS_HOUSE_2F_BIG_DOLL
	setevent EVENT_DECO_BED_1
	setevent EVENT_DECO_PLANT_4
	setevent EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
	setevent EVENT_OLIVINE_GYM_JASMINE
	setevent EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	setevent EVENT_MET_BILL
	setevent EVENT_ECRUTEAK_POKE_CENTER_BILL
	setevent EVENT_MYSTERY_GIFT_DELIVERY_GUY
	setevent EVENT_LAKE_OF_RAGE_LANCE
	setevent EVENT_WAREHOUSE_LAYOUT_1
	setevent EVENT_WAREHOUSE_BLOCKED_OFF
	setevent EVENT_DRAGONS_DEN_CLAIR
	setevent EVENT_RIVAL_OLIVINE_CITY
	setevent EVENT_RIVAL_VICTORY_ROAD
	setevent EVENT_RIVAL_DRAGONS_DEN
	setevent EVENT_LANCES_ROOM_OAK_AND_MARY
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	setevent EVENT_BURNED_TOWER_B1F_BEASTS_1
	setevent EVENT_RED_IN_MT_SILVER
	setevent EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	setevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	setevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	setevent EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M
	setevent EVENT_KURTS_HOUSE_KURT_2
	setevent EVENT_KURTS_HOUSE_GRANDDAUGHTER_2
	setevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_FLORIA_AT_FLOWER_SHOP
	setevent EVENT_FLORIA_AT_SUDOWOODO
	setevent EVENT_GOLDENROD_CITY_MOVE_TUTOR
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_FISHER
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	setevent EVENT_DRAGON_SHRINE_CLAIR
	setevent EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	setevent EVENT_KRISS_NEIGHBORS_HOUSE_NEIGHBOR
	setevent EVENT_AZALEA_TOWN_KURT
	setevent EVENT_AZALEA_TOWN_KURT
	setevent EVENT_ILEX_FOREST_KURT
	setevent EVENT_ROUTE_34_ILEX_FOREST_GATE_TEACHER_IN_WALKWAY
	setevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_GOLDENROD_SALE_OFF
	setevent EVENT_ECRUTEAK_CITY_GRAMPS
	setevent EVENT_EUSINE_IN_BURNED_TOWER
	setevent EVENT_KRISS_HOUSE_MOM_2
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	setevent EVENT_CIANWOOD_CITY_EUSINE
	setevent EVENT_TIN_TOWER_1F_EUSINE
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_1
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_2
	setevent EVENT_SET_WHEN_FOUGHT_HO_OH
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	setevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setevent EVENT_BATTLE_TOWER_OUTSIDE_SAILOR
	setflag ENGINE_ROCKET_SIGNAL_ON_CH20
	setflag ENGINE_ROCKETS_IN_MAHOGANY
	variablesprite SPRITE_WEIRD_TREE, SPRITE_SUDOWOODO
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_SILVER
	variablesprite SPRITE_AZALEA_ROCKET, SPRITE_ROCKET
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_JANINE
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_LASS
	setevent EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	setevent EVENT_CERULEAN_GYM_ROCKET
	setevent EVENT_ROUTE_24_ROCKET
	setevent EVENT_ROUTE_25_MISTY_BOYFRIEND
	setevent EVENT_TRAINERS_IN_CERULEAN_GYM
	setevent EVENT_COPYCATS_HOUSE_2F_DOLL
	setevent EVENT_VIRIDIAN_GYM_BLUE
	setevent EVENT_SEAFOAM_GYM_GYM_GUY
	setevent EVENT_MT_MOON_SQUARE_CLEFAIRY
	setevent EVENT_SAFFRON_TRAIN_STATION_POPULATION
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	setevent EVENT_INITIALIZED_EVENTS
	return

AskNumber1MScript:
	special RandomPhoneMon
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack
	farwritetext JackAskNumber1Text
	end
.Huey
	farwritetext HueyAskNumber1Text
	end
.Gaven
	farwritetext GavenAskNumber1Text
	end
.Jose
	farwritetext JoseAskNumber1Text
	end
.Joey
	farwritetext JoeyAskNumber1Text
	end
.Wade
	farwritetext WadeAskNumber1Text
	end
.Ralph
	farwritetext RalphAskNumber1Text
	end
.Anthony
	farwritetext AnthonyAskNumber1Text
	end
.Todd
	farwritetext ToddAskNumber1Text
	end
.Irwin
	farwritetext IrwinAskNumber1Text
	end
.Arnie
	farwritetext ArnieAskNumber1Text
	end
.Alan
	farwritetext AlanAskNumber1Text
	end
.Chad
	farwritetext ChadAskNumber1Text
	end
.Derek
	farwritetext DerekAskNumber1Text
	end
.Tully
	farwritetext TullyAskNumber1Text
	end
.Brent
	farwritetext BrentAskNumber1Text
	end
.Vance
	farwritetext VanceAskNumber1Text
	end
.Wilton
	farwritetext WiltonAskNumber1Text
	end
.Kenji
	farwritetext KenjiAskNumber1Text
	end
.Parry
	farwritetext ParryAskNumber1Text
	end

AskNumber2MScript:
	special RandomPhoneMon
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack
	farwritetext JackAskNumber2Text
	end
.Huey
	farwritetext HueyAskNumber2Text
	end
.Gaven
	farwritetext GavenAskNumber2Text
	end
.Jose
	farwritetext JoseAskNumber2Text
	end
.Joey
	farwritetext JoeyAskNumber2Text
	end
.Wade
	farwritetext WadeAskNumber2Text
	end
.Ralph
	farwritetext RalphAskNumber2Text
	end
.Anthony
	farwritetext AnthonyAskNumber2Text
	end
.Todd
	farwritetext ToddAskNumber2Text
	end
.Irwin
	farwritetext IrwinAskNumber2Text
	end
.Arnie
	farwritetext ArnieAskNumber2Text
	end
.Alan
	farwritetext AlanAskNumber2Text
	end
.Chad
	farwritetext ChadAskNumber2Text
	end
.Derek
	farwritetext DerekAskNumber2Text
	end
.Tully
	farwritetext TullyAskNumber2Text
	end
.Brent
	farwritetext BrentAskNumber2Text
	end
.Vance
	farwritetext VanceAskNumber2Text
	end
.Wilton
	farwritetext WiltonAskNumber2Text
	end
.Kenji
	farwritetext KenjiAskNumber2Text
	end
.Parry
	farwritetext ParryAskNumber2Text
	end

RegisteredNumberMScript:
	farwritetext RegisteredNumber1Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	buttonsound
	end

NumberAcceptedMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack
	farwritetext JackNumberAcceptedText
	waitbutton
	closetext
	end
.Huey
	farwritetext HueyNumberAcceptedText
	waitbutton
	closetext
	end
.Gaven
	farwritetext GavenNumberAcceptedText
	waitbutton
	closetext
	end
.Jose
	farwritetext JoseNumberAcceptedText
	waitbutton
	closetext
	end
.Joey
	farwritetext JoeyNumberAcceptedText
	waitbutton
	closetext
	end
.Wade
	farwritetext WadeNumberAcceptedText
	waitbutton
	closetext
	end
.Ralph
	farwritetext RalphNumberAcceptedText
	waitbutton
	closetext
	end
.Anthony
	farwritetext AnthonyNumberAcceptedText
	waitbutton
	closetext
	end
.Todd
	farwritetext ToddNumberAcceptedText
	waitbutton
	closetext
	end
.Irwin
	farwritetext IrwinNumberAcceptedText
	waitbutton
	closetext
	end
.Arnie
	farwritetext ArnieNumberAcceptedText
	waitbutton
	closetext
	end
.Alan
	farwritetext AlanNumberAcceptedText
	waitbutton
	closetext
	end
.Chad
	farwritetext ChadNumberAcceptedText
	waitbutton
	closetext
	end
.Derek
	farwritetext DerekNumberAcceptedText
	waitbutton
	closetext
	end
.Tully
	farwritetext TullyNumberAcceptedText
	waitbutton
	closetext
	end
.Brent
	farwritetext BrentNumberAcceptedText
	waitbutton
	closetext
	end
.Vance
	farwritetext VanceNumberAcceptedText
	waitbutton
	closetext
	end
.Wilton
	farwritetext WiltonNumberAcceptedText
	waitbutton
	closetext
	end
.Kenji
	farwritetext KenjiNumberAcceptedText
	waitbutton
	closetext
	end
.Parry
	farwritetext ParryNumberAcceptedText
	waitbutton
	closetext
	end

NumberDeclinedMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack
	farwritetext JackNumberDeclinedText
	waitbutton
	closetext
	end
.Huey
	farwritetext HueyNumberDeclinedText
	waitbutton
	closetext
	end
.Gaven
	farwritetext GavenNumberDeclinedText
	waitbutton
	closetext
	end
.Jose
	farwritetext JoseNumberDeclinedText
	waitbutton
	closetext
	end
.Joey
	farwritetext JoeyNumberDeclinedText
	waitbutton
	closetext
	end
.Wade
	farwritetext WadeNumberDeclinedText
	waitbutton
	closetext
	end
.Ralph
	farwritetext RalphNumberDeclinedText
	waitbutton
	closetext
	end
.Anthony
	farwritetext AnthonyNumberDeclinedText
	waitbutton
	closetext
	end
.Todd
	farwritetext ToddNumberDeclinedText
	waitbutton
	closetext
	end
.Irwin
	farwritetext IrwinNumberDeclinedText
	waitbutton
	closetext
	end
.Arnie
	farwritetext ArnieNumberDeclinedText
	waitbutton
	closetext
	end
.Alan
	farwritetext AlanNumberDeclinedText
	waitbutton
	closetext
	end
.Chad
	farwritetext ChadNumberDeclinedText
	waitbutton
	closetext
	end
.Derek
	farwritetext DerekNumberDeclinedText
	waitbutton
	closetext
	end
.Tully
	farwritetext TullyNumberDeclinedText
	waitbutton
	closetext
	end
.Brent
	farwritetext BrentNumberDeclinedText
	waitbutton
	closetext
	end
.Vance
	farwritetext VanceNumberDeclinedText
	waitbutton
	closetext
	end
.Wilton
	farwritetext WiltonNumberDeclinedText
	waitbutton
	closetext
	end
.Kenji
	farwritetext KenjiNumberDeclinedText
	waitbutton
	closetext
	end
.Parry
	farwritetext ParryNumberDeclinedText
	waitbutton
	closetext
	end

PhoneFullMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack
	farwritetext JackPhoneFullText
	waitbutton
	closetext
	end
.Huey
	farwritetext HueyPhoneFullText
	waitbutton
	closetext
	end
.Gaven
	farwritetext GavenPhoneFullText
	waitbutton
	closetext
	end
.Jose
	farwritetext JosePhoneFullText
	waitbutton
	closetext
	end
.Joey
	farwritetext JoeyPhoneFullText
	waitbutton
	closetext
	end
.Wade
	farwritetext WadePhoneFullText
	waitbutton
	closetext
	end
.Ralph
	farwritetext RalphPhoneFullText
	waitbutton
	closetext
	end
.Anthony
	farwritetext AnthonyPhoneFullText
	waitbutton
	closetext
	end
.Todd
	farwritetext ToddPhoneFullText
	waitbutton
	closetext
	end
.Irwin
	farwritetext IrwinPhoneFullText
	waitbutton
	closetext
	end
.Arnie
	farwritetext ArniePhoneFullText
	waitbutton
	closetext
	end
.Alan
	farwritetext AlanPhoneFullText
	waitbutton
	closetext
	end
.Chad
	farwritetext ChadPhoneFullText
	waitbutton
	closetext
	end
.Derek
	farwritetext DerekPhoneFullText
	waitbutton
	closetext
	end
.Tully
	farwritetext TullyPhoneFullText
	waitbutton
	closetext
	end
.Brent
	farwritetext BrentPhoneFullText
	waitbutton
	closetext
	end
.Vance
	farwritetext VancePhoneFullText
	waitbutton
	closetext
	end
.Wilton
	farwritetext WiltonPhoneFullText
	waitbutton
	closetext
	end
.Kenji
	farwritetext KenjiPhoneFullText
	waitbutton
	closetext
	end
.Parry
	farwritetext ParryPhoneFullText
	waitbutton
	closetext
	end

RematchMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack
	farwritetext JackRematchText
	waitbutton
	closetext
	end
.Huey
	farwritetext HueyRematchText
	waitbutton
	closetext
	end
.Gaven
	farwritetext GavenRematchText
	waitbutton
	closetext
	end
.Jose
	farwritetext JoseRematchText
	waitbutton
	closetext
	end
.Joey
	farwritetext JoeyRematchText
	waitbutton
	closetext
	end
.Wade
	farwritetext WadeRematchText
	waitbutton
	closetext
	end
.Ralph
	farwritetext RalphRematchText
	waitbutton
	closetext
	end
.Anthony
	farwritetext AnthonyRematchText
	waitbutton
	closetext
	end
.Todd
	farwritetext ToddRematchText
	waitbutton
	closetext
	end
.Arnie
	farwritetext ArnieRematchText
	waitbutton
	closetext
	end
.Alan
	farwritetext AlanRematchText
	waitbutton
	closetext
	end
.Chad
	farwritetext ChadRematchText
	waitbutton
	closetext
	end
.Tully
	farwritetext TullyRematchText
	waitbutton
	closetext
	end
.Brent
	farwritetext BrentRematchText
	waitbutton
	closetext
	end
.Vance
	farwritetext VanceRematchText
	waitbutton
	closetext
	end
.Wilton
	farwritetext WiltonRematchText
	waitbutton
	closetext
	end
.Parry
	farwritetext ParryRematchText
	waitbutton
	closetext
	end

GiftMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji

.Jose
	farwritetext JoseGiftText
	buttonsound
	end
.Wade
	farwritetext WadeGiftText
	buttonsound
	end
.Alan
	farwritetext AlanGiftText
	buttonsound
	end
.Derek
	farwritetext DerekGiftText
	buttonsound
	end
.Tully
	farwritetext TullyGiftText
	buttonsound
	end
.Wilton
	farwritetext WiltonGiftText
	buttonsound
	end
.Kenji
	farwritetext KenjiGiftText
	buttonsound
	end

PackFullMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Huey
	farwritetext HueyPackFullText
	waitbutton
	closetext
	end
.Jose
	farwritetext JosePackFullText
	waitbutton
	closetext
	end
.Joey
	farwritetext JoeyPackFullText
	waitbutton
	closetext
	end
.Wade
	farwritetext WadePackFullText
	waitbutton
	closetext
	end
.Alan
	farwritetext AlanPackFullText
	waitbutton
	closetext
	end
.Derek
	farwritetext DerekPackFullText
	waitbutton
	closetext
	end
.Tully
	farwritetext TullyPackFullText
	waitbutton
	closetext
	end
.Vance
	farwritetext VancePackFullText
	waitbutton
	closetext
	end
.Wilton
	farwritetext WiltonPackFullText
	waitbutton
	closetext
	end
.Kenji
	farwritetext KenjiPackFullText
	waitbutton
	closetext
	end
.Parry
	farwritetext ParryPackFullText
	waitbutton
	closetext
	end

RematchGiftMScript:
	opentext
	checkcode VAR_CALLERID
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_HIKER_PARRY, .Parry

.Huey
	farwritetext HueyRematchGiftText
	buttonsound
	end
.Joey
	farwritetext JoeyRematchGiftText
	buttonsound
	end
.Vance
	farwritetext VanceRematchGiftText
	buttonsound
	end
.Parry
	farwritetext ParryRematchGiftText
	buttonsound
	end

AskNumber1FScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly
	farwritetext BeverlyAskNumber1Text
	end
.Beth
	farwritetext BethAskNumber1Text
	end
.Reena
	farwritetext ReenaAskNumber1Text
	end
.Liz
	farwritetext LizAskNumber1Text
	end
.Gina
	farwritetext GinaAskNumber1Text
	end
.Dana
	farwritetext DanaAskNumber1Text
	end
.Tiffany
	farwritetext TiffanyAskNumber1Text
	end
.Erin
	farwritetext ErinAskNumber1Text
	end

AskNumber2FScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly
	farwritetext BeverlyAskNumber2Text
	end
.Beth
	farwritetext BethAskNumber2Text
	end
.Reena
	farwritetext ReenaAskNumber2Text
	end
.Liz
	farwritetext LizAskNumber2Text
	end
.Gina
	farwritetext GinaAskNumber2Text
	end
.Dana
	farwritetext DanaAskNumber2Text
	end
.Tiffany
	farwritetext TiffanyAskNumber2Text
	end
.Erin
	farwritetext ErinAskNumber2Text
	end

RegisteredNumberFScript:
	farwritetext RegisteredNumber2Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	buttonsound
	end

NumberAcceptedFScript: ; 0xbcbd3
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly
	farwritetext BeverlyNumberAcceptedText
	waitbutton
	closetext
	end
.Beth
	farwritetext BethNumberAcceptedText
	waitbutton
	closetext
	end
.Reena
	farwritetext ReenaNumberAcceptedText
	waitbutton
	closetext
	end
.Liz
	farwritetext LizNumberAcceptedText
	waitbutton
	closetext
	end
.Gina
	farwritetext GinaNumberAcceptedText
	waitbutton
	closetext
	end
.Dana
	farwritetext DanaNumberAcceptedText
	waitbutton
	closetext
	end
.Tiffany
	farwritetext TiffanyNumberAcceptedText
	waitbutton
	closetext
	end
.Erin
	farwritetext ErinNumberAcceptedText
	waitbutton
	closetext
	end

NumberDeclinedFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly
	farwritetext BeverlyNumberDeclinedText
	waitbutton
	closetext
	end
.Beth
	farwritetext BethNumberDeclinedText
	waitbutton
	closetext
	end
.Reena
	farwritetext ReenaNumberDeclinedText
	waitbutton
	closetext
	end
.Liz
	farwritetext LizNumberDeclinedText
	waitbutton
	closetext
	end
.Gina
	farwritetext GinaNumberDeclinedText
	waitbutton
	closetext
	end
.Dana
	farwritetext DanaNumberDeclinedText
	waitbutton
	closetext
	end
.Tiffany
	farwritetext TiffanyNumberDeclinedText
	waitbutton
	closetext
	end
.Erin
	farwritetext ErinNumberDeclinedText
	waitbutton
	closetext
	end

PhoneFullFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly
	farwritetext BeverlyPhoneFullText
	waitbutton
	closetext
	end
.Beth
	farwritetext BethPhoneFullText
	waitbutton
	closetext
	end
.Reena
	farwritetext ReenaPhoneFullText
	waitbutton
	closetext
	end
.Liz
	farwritetext LizPhoneFullText
	waitbutton
	closetext
	end
.Gina
	farwritetext GinaPhoneFullText
	waitbutton
	closetext
	end
.Dana
	farwritetext DanaPhoneFullText
	waitbutton
	closetext
	end
.Tiffany
	farwritetext TiffanyPhoneFullText
	waitbutton
	closetext
	end
.Erin
	farwritetext ErinPhoneFullText
	waitbutton
	closetext
	end

RematchFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beth
	farwritetext BethRematchText
	waitbutton
	closetext
	end
.Reena
	farwritetext ReenaRematchText
	waitbutton
	closetext
	end
.Liz
	farwritetext LizRematchText
	waitbutton
	closetext
	end
.Gina
	farwritetext GinaRematchText
	waitbutton
	closetext
	end
.Dana
	farwritetext DanaRematchText
	waitbutton
	closetext
	end
.Tiffany
	farwritetext TiffanyRematchText
	waitbutton
	closetext
	end
.Erin
	farwritetext ErinRematchText
	waitbutton
	closetext
	end

GiftFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany

.Beverly
	farwritetext BeverlyGiftText
	buttonsound
	end
.Gina
	farwritetext GinaGiftText
	buttonsound
	end
.Dana
	farwritetext DanaGiftText
	buttonsound
	end
.Tiffany
	farwritetext TiffanyGiftText
	buttonsound
	end

PackFullFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly
	farwritetext BeverlyPackFullText
	waitbutton
	closetext
	end
.Gina
	farwritetext GinaPackFullText
	waitbutton
	closetext
	end
.Dana
	farwritetext DanaPackFullText
	waitbutton
	closetext
	end
.Tiffany
	farwritetext TiffanyPackFullText
	waitbutton
	closetext
	end
.Erin
	farwritetext ErinPackFullText
	waitbutton
	closetext
	end

RematchGiftFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Erin
	opentext
	farwritetext ErinRematchGiftText
	buttonsound
	end

GymStatue1Script:
	mapnametotext $0
	opentext
	farwritetext GymStatue_CityGymText
	waitbutton
	closetext
	end

GymStatue2Script:
	mapnametotext $0
	opentext
	farwritetext GymStatue_CityGymText
	buttonsound
	farwritetext GymStatue_WinningTrainersText
	waitbutton
	closetext
	end

ReceiveItemScript: ; 0xbcdb9
	waitsfx
	farwritetext ReceivedItemText
	playsound SFX_ITEM
	waitsfx
	end
; 0xbcdc3

ReceiveTogepiEggScript: ; 0xbcdc3
	waitsfx
	farwritetext ReceivedItemText
	playsound SFX_GET_EGG_FROM_DAYCARE_LADY
	waitsfx
	end
; 0xbcdcd

GameCornerCoinVendorScript: ; 0xbcdcd
	faceplayer
	opentext
	farwritetext CoinVendor_WelcomeText
	buttonsound
	checkitem COIN_CASE
	iftrue CoinVendor_IntroScript
	farwritetext CoinVendor_NoCoinCaseText
	waitbutton
	closetext
	end
; 0xbcde0

CoinVendor_IntroScript: ; 0xbcde0
	farwritetext CoinVendor_IntroText

.loop: ; 0xbcde4
	special Special_DisplayMoneyAndCoinBalance
	loadmenudata .MenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .Buy50
	if_equal $2, .Buy500
	jump .Cancel
; 0xbcdf7

.Buy50: ; 0xbcdf7
	checkcoins 9949
	if_equal $0, .CoinCaseFull
	checkmoney $0, 1000
	if_equal $2, .NotEnoughMoney
	givecoins 50
	takemoney $0, 1000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy50CoinsText
	waitbutton
	jump .loop
; 0xbce1b

.Buy500: ; 0xbce1b
	checkcoins 9499
	if_equal $0, .CoinCaseFull
	checkmoney $0, 10000
	if_equal $2, .NotEnoughMoney
	givecoins 500
	takemoney $0, 10000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy500CoinsText
	waitbutton
	jump .loop
; 0xbce3f

.NotEnoughMoney: ; 0xbce3f
	farwritetext CoinVendor_NotEnoughMoneyText
	waitbutton
	closetext
	end
; 0xbce46

.CoinCaseFull: ; 0xbce46
	farwritetext CoinVendor_CoinCaseFullText
	waitbutton
	closetext
	end
; 0xbce4d

.Cancel: ; 0xbce4d
	farwritetext CoinVendor_CancelText
	waitbutton
	closetext
	end
; 0xbce54


.MenuDataHeader
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2
	db $80 ; flags
	db 3 ; items
	db " 50 :  ¥1000@"
	db "500 : ¥10000@"
	db "CANCEL@"
; 0xbce7f


HappinessCheckScript:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	if_less_than 50, .Unhappy
	if_less_than 150, .KindaHappy
	farwritetext HappinessText3
	waitbutton
	closetext
	end

.KindaHappy
	farwritetext HappinessText2
	waitbutton
	closetext
	end

.Unhappy
	farwritetext HappinessText1
	waitbutton
	closetext
	end

Movement_ContestResults_WalkAfterWarp: ; bcea1
	step_right
	step_down
	turn_head_up
	step_end
; bcea5
