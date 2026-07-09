/obj/item/firearm/kinetic/pumpweapon/riotgun
	name = "\improper Guillemot riot shotgun"
	desc = "A police-issue shotgun from Cormorant Precision Arms, customized for riot suppression and prison guard duty."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "shotty"
	item_state = "shotty"
	wear_state = "shotty" // prevent empty state from breaking the worn image
	base_icon_state = "shotty"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags =  TABLEPASS | CONDUCT | USEDELAY
	c_flags = ONBACK
	force = MELEE_DMG_RIFLE
	contraband = 5
	ammo_cats = list(AMMO_SHOTGUN_AUTOMATIC)
	max_ammo_capacity = 8
	auto_eject = FALSE
	can_dual_wield = FALSE
	two_handed = TRUE
	has_empty_state = TRUE
	gildable = TRUE
	default_magazine = /obj/item/ammo/bullets/abg
	recoil_strength = 14
	recoil_max = 60


	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/abg)
		..()
