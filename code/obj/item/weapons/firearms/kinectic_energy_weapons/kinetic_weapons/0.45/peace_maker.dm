		name = "\improper Peacemaker"
		desc = "A barely adequate replica of a nearly ancient single action revolver. Used by war reenactors for the last hundred years or so. Its caliber is obviously the wrong size, though."
		w_class = W_CLASS_SMALL
		force = MELEE_DMG_REVOLVER
		ammo_cats = list(AMMO_REVOLVER_DETECTIVE)
		default_magazine = /obj/item/ammo/bullets/a38/stun
		New()
			..()
			ammo = new default_magazine
			set_current_projectile(new/datum/projectile/bullet/revolver_38/stunners)

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/revolver_45)
		..()
