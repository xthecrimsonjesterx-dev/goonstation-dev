/obj/item/firearm/kinetic/revolver
	name = "\improper Kestrel revolver"
	desc = "A hefty combat revolver developed by Cormorant Precision Arms. Uses .357 caliber rounds."
	icon_state = "revolver"
	item_state = "revolver"
	force = MELEE_DMG_REVOLVER
	ammo_cats = list(AMMO_REVOLVER_SYNDICATE, AMMO_REVOLVER_DETECTIVE) // Just like in RL (Convair880).
	max_ammo_capacity = 7
	default_magazine = /obj/item/ammo/bullets/a357
	fire_animation = TRUE
	ammobag_magazines = list(/obj/item/ammo/bullets/a357, /obj/item/ammo/bullets/a357/AP)
	ammobag_restock_cost = 2
	recoil_strength = 12
	icon_recoil_cap = 30
	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/revolver_357)
		..()
