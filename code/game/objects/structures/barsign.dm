/obj/structure/sign/double/barsign
	icon = 'icons/obj/barsigns.dmi'
	icon_state = "empty"
	appearance_flags = 0
	anchored = 1
	pixel_x = -32
	pixel_y = -32
	auto_init = TRUE

	light_power = 6
	light_range = 5
	light_color = "#FF55FF"

	var/cult = 0

/obj/structure/sign/double/barsign/proc/get_valid_states(initial=1)
	. = icon_states(icon)
	. -= "on"
	. -= "narsiebistro"
	. -= "empty"
	if(initial)
		. -= "Off"

/obj/structure/sign/double/barsign/examine(mob/user)
	..()
	switch(icon_state)
		if("Off")
			user << "It appears to be switched off."
		if("on", "empty")
			user << "The lights are on, but there's no picture."
		else
			user << "It says '[icon_state]'"

/obj/structure/sign/double/barsign/New()
	..()
	icon_state = pick(get_valid_states())

/obj/structure/sign/double/barsign/initialize()
	..()
	set_light()

/obj/structure/sign/double/barsign/attackby(obj/item/I, mob/user)
	if(cult)
		return ..()

	var/obj/item/card/id/card = I.GetID()
	if(istype(card))
		if(access_bar in card.GetAccess())
			var/sign_type = input(user, "What would you like to change the barsign to?") as null|anything in get_valid_states(0)
			if(!sign_type)
				return
			icon_state = sign_type
			user << "<span class='notice'>You change the barsign.</span>"
		else
			user << "<span class='warning'>Access denied.</span>"
		return

	return ..()
