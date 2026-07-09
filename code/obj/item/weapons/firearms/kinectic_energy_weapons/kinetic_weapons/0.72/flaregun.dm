/obj/item/firearm/kinetic/flaregun
	desc = "A 12-gauge signal launcher from Cormorant Precision Arms. A perennial lifesaver at sea, on land, and in space."
	name = "\improper Pelican flare gun"
	icon_state = "flare"
	item_state = "flaregun"
	force = MELEE_DMG_PISTOL
	contraband = 2
	ammo_cats = list(AMMO_SHOTGUN_LOW)
	max_ammo_capacity = 1
	has_empty_state = 1
	default_magazine = /obj/item/ammo/bullets/flare/single
	recoil_strength = 10
	recoil_max = 20
	icon_recoil_cap = 30
	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/flare)
		..()
