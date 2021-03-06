//Psi-boosting item (antag only)
/obj/item/clothing/head/helmet/space/psi_amp
	name = "cerebro-energetic enhancer"
	desc = "A matte-black, eyeless cerebro-energetic enhancement helmet. Rather unsettling to look at."
	action_button_name = "Install Boosters"
	icon_state = "cerebro"

	item_state_slots = list(
		slot_l_hand_str = "helmet",
		slot_r_hand_str = "helmet"
		)

	var/operating = FALSE
	var/list/boosted_faculties = list()
	var/boosted_rank = PSI_RANK_PARAMOUNT
	var/unboosted_rank = PSI_RANK_MASTER
	var/max_boosted_faculties = 3
	var/boosted_psipower = 120

/obj/item/clothing/head/helmet/space/psi_amp/lesser
	name = "psionic amplifier"
	desc = "A crown-of-thorns cerebro-energetic enhancer. Kind of looks like a tiara having sex with an industrial robot."
	icon_state = "amp"
	flags_inv = 0
	body_parts_covered = 0

	max_boosted_faculties = 1
	boosted_rank = PSI_RANK_MASTER
	unboosted_rank = PSI_RANK_OPERANT
	boosted_psipower = 50

/obj/item/clothing/head/helmet/space/psi_amp/New()
	..()
	verbs += /obj/item/clothing/head/helmet/space/psi_amp/proc/integrate

/obj/item/clothing/head/helmet/space/psi_amp/attack_self(var/mob/user)

	if(operating)
		return

	if(!canremove)
		deintegrate()
		return

	var/mob/living/carbon/human/H = loc
	if(istype(H) && H.head == src)
		integrate()
		return

	var/choice = input("Select a brainboard to install or remove.","Psi-Amp") as null|anything in psychic_strings_to_ids
	if(!choice || !psychic_strings_to_ids[choice])
		return

	var/removed
	if(psychic_strings_to_ids[choice] in boosted_faculties)
		boosted_faculties -= psychic_strings_to_ids[choice]
		removed = TRUE
	else
		boosted_faculties += psychic_strings_to_ids[choice]

	var/slots_left = max_boosted_faculties-boosted_faculties.len
	to_chat(user, "<span class='notice'>You [removed ? "remove" : "install"] the [choice] brainboard [removed ? "from" : "in"] \the [src]. There [slots_left!=1 ? "are" : "is"] [slots_left] slot\s left.</span>")

/obj/item/clothing/head/helmet/space/psi_amp/proc/deintegrate()

	set name = "Remove Psi-Amp"
	set desc = "Enhance your brainpower."
	set category = "Abilities"
	set src in usr

	if(operating)
		return

	if(canremove)
		return

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.head != src)
		canremove = TRUE
		return

	to_chat(H, "<span class='warning'>You feel a strange tugging sensation as \the [src] begins removing the enhancers from your brain...</span>")
	playsound(H, 'sound/weapons/circsawhit.ogg', 50, 1, -1)
	operating = TRUE

	sleep(80)

	if(H.psi) H.psi.reset()
	to_chat(H, "<span class='notice'>\The [src] chimes quietly as it finishes remove the enhancers from your brain.</span>")

	canremove = TRUE
	operating = FALSE

	verbs -= /obj/item/clothing/head/helmet/space/psi_amp/proc/deintegrate
	verbs |= /obj/item/clothing/head/helmet/space/psi_amp/proc/integrate

	action_button_name = "Install Boosters"
	H.update_action_buttons()

	kill_light()

/obj/item/clothing/head/helmet/space/psi_amp/proc/integrate()

	set name = "Integrate Psi-Amp"
	set desc = "Enhance your brainpower."
	set category = "Abilities"
	set src in usr

	if(operating)
		return

	if(!canremove)
		return

	if(boosted_faculties.len < max_boosted_faculties)
		to_chat(usr, "<span class='notice'>You still have [max_boosted_faculties-boosted_faculties.len] facult[boosted_faculties.len == 1 ? "y" : "ies"] to select. Use \the [src] in-hand to select them.</span>")
		return

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.head != src)
		to_chat(usr, "<span class='warning'>\The [src] must be worn on your head in order to be activated.</span>")
		return

	if(!HAS_ASPECT(H, ASPECT_PSI_ROOT))
		to_chat(usr, "<span class='warning'>You have no psionic potential - \the [src] can't boost something that doesn't exist.</span>")
		return

	canremove = FALSE
	operating = TRUE
	to_chat(H, "<span class='warning'>You feel a series of sharp pinpricks as \the [src] anaesthetises your scalp before drilling down into your brain...</span>")
	playsound(H, 'sound/weapons/circsawhit.ogg', 50, 1, -1)

	sleep(80)

	for(var/faculty in list(PSI_COERCION, PSI_PSYCHOKINESIS, PSI_REDACTION, PSI_ENERGISTICS))
		if(faculty in boosted_faculties)
			H.set_psi_rank(faculty, boosted_rank, take_larger = TRUE, temporary = TRUE)
		else
			H.set_psi_rank(faculty, unboosted_rank, take_larger = TRUE, temporary = TRUE)
	if(H.psi)
		H.psi.max_stamina = boosted_psipower
		H.psi.stamina = H.psi.max_stamina
		H.psi.update()

	to_chat(H, "<span class='notice'>\The [src] chimes quietly as it finishes boosting your brain.</span>")
	verbs |= /obj/item/clothing/head/helmet/space/psi_amp/proc/deintegrate
	verbs -= /obj/item/clothing/head/helmet/space/psi_amp/proc/integrate

	operating = FALSE
	action_button_name = "Remove Boosters"
	H.update_action_buttons()

	set_light(1, 1, "#880000")
