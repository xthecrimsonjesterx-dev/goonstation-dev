/obj/item/firearm/kinetic/pistol/ceridwen_tranq_pistol
	name = "\improper Ceridwen tranquilizer pistol"
	desc = "A silenced 9mm tranquilizer pistol, developed by Mabinogi Firearms Company."
	icon_state = "tranq_pistol"
	item_state = "tranq_pistol"
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_PISTOL
	contraband = 4
	ammo_cats = list(AMMO_TRANQ_9MM)
	max_ammo_capacity = 15
	auto_eject = 1
	hide_attack = ATTACK_FULLY_HIDDEN
	muzzle_flash = null
	default_magazine = /obj/item/ammo/bullets/tranq_darts/syndicate/pistol
	fire_animation = TRUE
	ammobag_magazines = list(/obj/item/ammo/bullets/tranq_darts/syndicate/pistol)
	ammobag_restock_cost = 2
	recoil_strength = 7
	icon_recoil_cap = 30
	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/tranq_dart/syndicate/pistol)
		..()
