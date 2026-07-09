/obj/item/firearm/kinetic/single_action/mts_255
	name = "\improper MTs-255 Revolver Shotgun"
	desc = "A single-action revolving cylinder shotgun, popular with Soviet hunters, produced by the Zvezda Design Bureau."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "mts255"
	item_state = "mts255"
	flags =  TABLEPASS | CONDUCT
	c_flags = ONBACK
	force = MELEE_DMG_RIFLE
	contraband = 5
	ammo_cats = list(AMMO_SHOTGUN_AUTOMATIC)
	max_ammo_capacity = 5
	auto_eject = FALSE
	can_dual_wield = FALSE
	two_handed = TRUE
	has_empty_state = FALSE
	has_uncocked_state = TRUE
	fire_animation = TRUE
	gildable = TRUE
	default_magazine = /obj/item/ammo/bullets/a12/bird/five
	recoil_strength = 10
	recoil_max = 60

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/special/spreader/uniform_burst/bird12)
		..()
