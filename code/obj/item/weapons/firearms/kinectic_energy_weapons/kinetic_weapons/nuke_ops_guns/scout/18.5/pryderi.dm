/obj/item/firearm/kinetic/pryderi_tactical_shotgun //just a reskin, unused currently
	name = "\improper Pryderi tactical shotgun"
	desc = "A compact multi-purpose shotgun from Mabinogi Firearms Company, standard-issue for Hafgan's mine guards and convoy security throughout the Martian War."
	icon_state = "tactical_shotgun"
	item_state = "shotgun"
	force = MELEE_DMG_RIFLE
	contraband = 7
	ammo_cats = list(AMMO_SHOTGUN_AUTOMATIC)
	max_ammo_capacity = 5
	auto_eject = 1
	two_handed = 0
	can_dual_wield = 1
	default_magazine = /obj/item/ammo/bullets/buckshot_burst
	fire_animation = TRUE
	has_empty_state = TRUE
	recoil_strength = 10
	recoil_max = 60

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/special/spreader/buckshot_burst/)
		..()
