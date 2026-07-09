/obj/item/firearm/kinetic/pistol/branwen
	name = "\improper Branwen pistol"
	desc = "A semi-automatic, 9mm caliber service pistol, developed by Mabinogi Firearms Company."
	icon_state = "9mm_pistol"
	w_class = W_CLASS_NORMAL
	force = MELEE_DMG_PISTOL
	contraband = 4
	ammo_cats = list(AMMO_PISTOL_9MM_ALL)
	max_ammo_capacity = 15
	auto_eject = 1
	has_empty_state = 1
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/bullet_9mm
	ammobag_magazines = list(/obj/item/ammo/bullets/bullet_9mm)
	ammobag_restock_cost = 1
	recoil_strength = 8
	icon_recoil_cap = 30
	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/bullet_9mm)
		..()

/obj/item/firearm/kinetic/pistol/branwen/empty

	New()
		..()
		ammo.amount_left = 0
		UpdateIcon()
