GetTrainerDVs: ; 270c4
; Return the DVs of OtherTrainerClass in bc

	push hl
	ld a, [OtherTrainerClass]
	dec a
	ld c, a
	ld b, 0

	ld hl, TrainerClassDVs
rept 2
	add hl, bc
endr

	ld a, [hli]
	ld b, a
	ld c, [hl]

	pop hl
	ret
; 270d6

TrainerClassDVs: ; 270d6
	;  Atk  Spd
	;  Def  Spc
	db $77, $77 ; falkner
	db $77, $77 ; bugsy
	db $77, $77 ; whitney
	db $77, $77 ; morty
	db $77, $77 ; pryce
	db $77, $77 ; jasmine
	db $77, $77 ; chuck
	db $77, $77 ; clair
	db $77, $77 ; rival1
	db $77, $77 ; pokemon prof
	db $77, $77 ; will
	db $77, $77 ; cal
	db $77, $77 ; bruno
	db $77, $77 ; karen
	db $77, $77 ; koga
	db $77, $77 ; champion
	db $77, $77 ; brock
	db $77, $77 ; misty
	db $77, $77 ; lt surge
	db $77, $77 ; scientist
	db $77, $77 ; erika
	db $77, $77 ; youngster
	db $77, $77 ; schoolboy
	db $77, $77 ; bird keeper
	db $77, $77 ; lass
	db $77, $77 ; janine
	db $77, $77 ; cooltrainerm
	db $77, $77 ; cooltrainerf
	db $77, $77 ; beauty
	db $77, $77 ; pokemaniac
	db $77, $77 ; gruntm
	db $77, $77 ; gentleman
	db $77, $77 ; skier
	db $77, $77 ; teacher
	db $77, $77 ; sabrina
	db $77, $77 ; bug catcher
	db $77, $77 ; fisher
	db $77, $77 ; swimmerm
	db $77, $77 ; swimmerf
	db $77, $77 ; sailor
	db $77, $77 ; super nerd
	db $77, $77 ; rival2
	db $77, $77 ; guitarist
	db $77, $77 ; hiker
	db $77, $77 ; biker
	db $77, $77 ; blaine
	db $77, $77 ; burglar
	db $77, $77 ; firebreather
	db $77, $77 ; juggler
	db $77, $77 ; blackbelt
	db $77, $77 ; executivem
	db $77, $77 ; psychic
	db $77, $77 ; picnicker
	db $77, $77 ; camper
	db $77, $77 ; executivef
	db $77, $77 ; sage
	db $77, $77 ; medium
	db $77, $77 ; boarder
	db $77, $77 ; pokefanm
	db $77, $77 ; kimono girl
	db $77, $77 ; twins
	db $77, $77 ; pokefanf
	db $77, $77 ; red
	db $77, $77 ; blue
	db $77, $77 ; officer
	db $77, $77 ; gruntf
	db $77, $77 ; mysticalman
; 2715c
