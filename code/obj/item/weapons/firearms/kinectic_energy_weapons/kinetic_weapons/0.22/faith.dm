/obj/item/firearm/kinetic/faith
	name = "Faith"
	desc = "'Cause ya gotta have Faith. A custom upgrade to the Auklet .22 pocket pistol from Cormorant Precision Arms."
	icon_state = "faith"
	force = MELEE_DMG_PISTOL
	ammo_cats = list(AMMO_PISTOL_22)
	max_ammo_capacity = 4
	auto_eject = 1
	w_class = W_CLASS_SMALL
	muzzle_flash = null
	has_empty_state = 1
	default_magazine = /obj/item/ammo/bullets/bullet_22/faith
	fire_animation = TRUE
	recoil_strength = 4
	icon_recoil_cap = 30
	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/bullet_22)
		..()
