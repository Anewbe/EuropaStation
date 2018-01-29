/obj/item/mmi
	name = "man-machine interface"
	desc = "The Warrior's bland acronym, MMI, obscures the true horror of this monstrosity."
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "mmi_empty"
	w_class = 3
	req_access = list(access_robotics)

	var/locked = 0
	var/mob/living/carbon/brain/brainmob = null//The current occupant.
	var/obj/item/organ/internal/brain/brainobj = null	//The current brain organ.

/obj/item/mmi/attackby(var/obj/item/O, var/mob/user)
	if(istype(O,/obj/item/organ/internal/brain) && !brainmob) //Time to stick a brain in it --NEO

		var/obj/item/organ/internal/brain/B = O
		if(B.health <= 0)
			user << "<span class='warning'>That brain is well and truly dead.</span>"
			return
		else if(!B.brainmob)
			user << "<span class='notice'>You aren't sure where this brain came from, but you're pretty sure it's a useless brain.</span>"
			return

		user.visible_message("<span class='notice'>\The [user] sticks \a [O] into \the [src].</span>")

		brainmob = B.brainmob
		B.brainmob = null
		brainmob.forceMove(src)
		brainmob.container = src
		brainmob.stat = 0
		brainmob.switch_from_dead_to_living_mob_list() //Update dem lists

		user.drop_item()
		brainobj = O
		brainobj.loc = src

		name = "man-machine interface ([brainmob.real_name])"
		icon_state = "mmi_full"

		locked = 1

		feedback_inc("cyborg_mmis_filled",1)

		return

	if((istype(O,/obj/item/card/id)||istype(O,/obj/item/radio/headset/pda)) && brainmob)
		if(allowed(user))
			locked = !locked
			user << "<span class='notice'>You [locked ? "lock" : "unlock"] the brain holder.</span>"
		else
			user << "<span class='warning'>Access denied.</span>"
		return
	if(brainmob)
		O.attack(brainmob, user)//Oh noooeeeee
		return
	..()

	//TODO: ORGAN REMOVAL UPDATE. Make the brain remain in the MMI so it doesn't lose organ data.
/obj/item/mmi/attack_self(var/mob/user)
	if(!brainmob)
		user << "<span class='warning'>You upend the MMI, but there's nothing in it.</span>"
	else if(locked)
		user << "<span class='warning'>You upend the MMI, but the brain is clamped into place.</span>"
	else
		user << "<span class='notice'>You upend the MMI, spilling the brain onto the floor.</span>"
		var/obj/item/organ/internal/brain/brain
		if (brainobj)	//Pull brain organ out of MMI.
			brainobj.loc = user.loc
			brain = brainobj
			brainobj = null
		else	//Or make a new one if empty.
			brain = new(user.loc)
		brainmob.container = null//Reset brainmob mmi var.
		brainmob.loc = brain//Throw mob into brain.
		brainmob.remove_from_living_mob_list() //Get outta here
		brain.brainmob = brainmob//Set the brain to use the brainmob
		brainmob = null//Set mmi brainmob var to null

		icon_state = "mmi_empty"
		name = "man-machine interface"

/obj/item/mmi/proc/transfer_identity(var/mob/living/carbon/human/H)//Same deal as the regular brain proc. Used for human-->robot people.
	brainmob = new(src)
	brainmob.name = H.real_name
	brainmob.real_name = H.real_name
	brainmob.container = src

	name = "Man-Machine Interface: [brainmob.real_name]"
	icon_state = "mmi_full"
	locked = 1
	return

/obj/item/mmi/relaymove(var/mob/user, var/direction)
	if(user.stat || user.stunned)
		return
	var/obj/item/rig/rig = src.get_rig()
	if(rig)
		rig.forced_move(direction, user)

/obj/item/mmi/Destroy()
	if(isrobot(loc))
		var/mob/living/silicon/robot/borg = loc
		borg.mmi = null
	if(brainmob)
		qdel(brainmob)
		brainmob = null
	return ..()

/obj/item/mmi/radio_enabled
	name = "radio-enabled man-machine interface"
	desc = "The Warrior's bland acronym, MMI, obscures the true horror of this monstrosity. This one comes with a built-in radio."


	var/obj/item/radio/radio = null//Let's give it a radio.

	New()
		..()
		radio = new(src)//Spawns a radio inside the MMI.
		radio.broadcasting = 1//So it's broadcasting from the start.

	verb//Allows the brain to toggle the radio functions.
		Toggle_Broadcasting()
			set name = "Toggle Broadcasting"
			set desc = "Toggle broadcasting channel on or off."
			set category = "MMI"
			set src = usr.loc//In user location, or in MMI in this case.
			set popup_menu = 0//Will not appear when right clicking.

			if(brainmob.stat)//Only the brainmob will trigger these so no further check is necessary.
				brainmob << "Can't do that while incapacitated or dead."

			radio.broadcasting = radio.broadcasting==1 ? 0 : 1
			brainmob << "<span class='notice'>Radio is [radio.broadcasting==1 ? "now" : "no longer"] broadcasting.</span>"

		Toggle_Listening()
			set name = "Toggle Listening"
			set desc = "Toggle listening channel on or off."
			set category = "MMI"
			set src = usr.loc
			set popup_menu = 0

			if(brainmob.stat)
				brainmob << "Can't do that while incapacitated or dead."

			radio.listening = radio.listening==1 ? 0 : 1
			brainmob << "<span class='notice'>Radio is [radio.listening==1 ? "now" : "no longer"] receiving broadcast.</span>"

/obj/item/mmi/emp_act(severity)
	if(!brainmob)
		return
	else
		switch(severity)
			if(1)
				brainmob.emp_damage += rand(20,30)
			if(2)
				brainmob.emp_damage += rand(10,20)
			if(3)
				brainmob.emp_damage += rand(0,10)
	..()
