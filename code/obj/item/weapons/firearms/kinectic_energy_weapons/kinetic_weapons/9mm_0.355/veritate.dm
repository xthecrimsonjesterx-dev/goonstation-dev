//medic primary
/obj/item/firearm/kinetic/veritate
	desc = "A personal defence weapon, developed by Almagest Weapons Fabrication."
	name = "\improper Veritate PDW"
	icon_state = "vector"
	item_state = "glocksyn"
	shoot_delay = 1
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_PISTOL
	ammo_cats = list(AMMO_FLECHETTE)
	max_ammo_capacity = 21
	auto_eject = 1
	has_empty_state = 1
	gildable = 0
	fire_animation = FALSE
	default_magazine = /obj/item/ammo/bullets/veritate
	ammobag_magazines = list(/obj/item/ammo/bullets/veritate)
	ammobag_restock_cost = 2

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/veritate)
		projectiles = list(current_projectile,new/datum/projectile/bullet/veritate/burst)
		..()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	attack_self(mob/user as mob)
		..()	//burst shot has a slight spread.
		if (istype(current_projectile, /datum/projectile/bullet/veritate/burst/))
			spread_angle = 6
			shoot_delay = 3 DECI SECONDS
		else
			spread_angle = 0
			shoot_delay = 2 DECI SECONDS
