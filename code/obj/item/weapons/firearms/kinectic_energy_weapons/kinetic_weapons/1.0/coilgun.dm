/obj/item/firearm/kinetic/coilgun_TEST
	name = "coil gun"
	icon = 'icons/obj/items/assemblies.dmi'
	icon_state = "coilgun_2"
	item_state = "flaregun"
	force = MELEE_DMG_RIFLE
	contraband = 6
	ammo_cats = list(AMMO_COILGUN)
	max_ammo_capacity = 2
	default_magazine = /obj/item/ammo/bullets/rod

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/rod)
		..()
