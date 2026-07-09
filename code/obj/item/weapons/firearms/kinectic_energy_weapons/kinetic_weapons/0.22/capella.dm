/obj/item/firearm/kinetic/capella
	name = "\improper Capella Mk. 8 competition pistol"
	desc = "A match-grade competition pistol, expertly machined for extreme accuracy and speed. Produced by Almagest Weapons Fabrication."
	icon_state = "capella"
	item_state = "pw_pistol_sy"
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_PISTOL
	contraband = 25
	rarity = 4
	ammo_cats = list(AMMO_PISTOL_22)
	max_ammo_capacity = 10
	auto_eject = 1
	has_empty_state = 1
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/bullet_22match
	ammobag_magazines = list(/obj/item/ammo/bullets/bullet_22match)
	ammobag_restock_cost = 1
	recoil_strength = 0.1
	icon_recoil_cap = 3

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/bullet_22/match)
		..()
