/obj/item/firearm/kinetic/silenced_22
	name = "\improper Orion silenced pistol"
	desc = "A small pistol with an integrated flash and noise suppressor, bearing the emblem of Sceptre Tactical Laboratories. Uses .22 rounds."
	icon_state = "silenced"
	w_class = W_CLASS_SMALL
	silenced = 1
	force = MELEE_DMG_PISTOL
	contraband = 4
	ammo_cats = list(AMMO_PISTOL_22)
	max_ammo_capacity = 10
	auto_eject = 1
	hide_attack = ATTACK_FULLY_HIDDEN
	muzzle_flash = null
	has_empty_state = 1
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/bullet_22HP
	ammobag_magazines = list(/obj/item/ammo/bullets/bullet_22, /obj/item/ammo/bullets/bullet_22HP)
	ammobag_restock_cost = 1
	recoil_strength = 3
	icon_recoil_cap = 30

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/bullet_22/HP)
		..()

	//override the shot sound and volume because we have a silencer
	set_current_projectile(datum/projectile/newProj)
		. = ..()
		src.current_projectile.shot_sound = 'sound/weapons/suppressed_22.ogg'
		src.current_projectile.shot_volume = 30
