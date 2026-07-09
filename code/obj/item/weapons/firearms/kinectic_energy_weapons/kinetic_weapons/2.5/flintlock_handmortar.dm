/obj/item/firearm/kinetic/single_action/flintlock/mortar
	name = "hand mortar"
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "hand_mortar"
	item_state = "hand_mortar"
	ammo_cats = list(AMMO_FLINTLOCK_MORTAR)
	force = MELEE_DMG_RIFLE
	two_handed = TRUE
	default_magazine = /obj/item/ammo/bullets/flintlock/mortar/single
	recoil_strength = 14

	New()
		..()
		set_current_projectile(new/datum/projectile/bullet/flintlock/mortar)
