/***************************************
* Highly Visible and Dangerous Weapons *
***************************************/
/datum/uplink_item/item/visible_weapons
	category = /datum/uplink_category/visible_weapons

/datum/uplink_item/item/visible_weapons/energy_sword
	name = "Energy Sword"
	item_cost = 32
	path = /obj/item/melee/energy/sword

/datum/uplink_item/item/visible_weapons/g9mm
	name = "Silenced Holdout Pistol"
	item_cost = 32
	path = /obj/item/storage/box/syndie_kit/g9mm

/datum/uplink_item/item/visible_weapons/revolver
	name = "Revolver"
	item_cost = 56
	antag_costs = list(MODE_MERCENARY = 7)
	path = /obj/item/storage/backpack/satchel/syndie_kit/revolver

/datum/uplink_item/item/visible_weapons/grenade_launcher
	name = "Grenade Launcher"
	item_cost = 60
	antag_roles = list(MODE_MERCENARY = 12)
	path = /obj/item/gun/launcher/grenade/loaded

//These are for traitors (or other antags, perhaps) to have the option of purchasing some merc gear.
/datum/uplink_item/item/visible_weapons/submachinegun
	name = "Submachine Gun"
	item_cost = 52
	antag_costs = list(MODE_MERCENARY = 6)
	path = /obj/item/gun/composite/premade/smg/a10/preloaded

/datum/uplink_item/item/visible_weapons/assaultrifle
	name = "Assault Rifle"
	item_cost = 60
	antag_costs = list(MODE_MERCENARY = 9)
	path = /obj/item/gun/composite/premade/assault_rifle/a762/preloaded

/datum/uplink_item/item/visible_weapons/heavysniper
	name = "Anti-materiel Rifle with ammunition"
	item_cost = 68
	path = /obj/item/storage/secure/briefcase/heavysniper

/datum/uplink_item/item/visible_weapons/psi_amp
	name = "Cerebroenergetic Psionic Amplifier"
	item_cost = 50
	path = /obj/item/clothing/head/helmet/space/psi_amp/lesser
	desc = "A powerful, illegal psi-amp. Boosts latent psi-faculties to extremely high levels."