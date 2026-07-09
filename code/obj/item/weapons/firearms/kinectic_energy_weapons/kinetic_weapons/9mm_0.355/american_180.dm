/obj/item/firearm/kinetic/american180
	name = "\improper Razorbill-180"
	desc = "A .22 submachine gun from Cormorant Precision Arms loaded with a huge pancake magazine, marketed towards max-security prison guards and security forces facing massed wave attacks."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "american180"
	item_state = "a180"
	spread_angle = 3
	shoot_delay = 3
	has_empty_state = FALSE // non detachable mag, for now...
	w_class = W_CLASS_BULKY
	force = MELEE_DMG_RIFLE
	ammo_cats = 0
	max_ammo_capacity = 177
	two_handed = TRUE
	auto_eject = TRUE
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/bullet_22/american_180
	recoil_max = 100

	eject_magazine(mob/user)
		user.show_message(SPAN_ALERT("They tell stories of how BORING these magazines are to load! Let's not do that."))
		return

	New()
		ammo = new default_magazine

		set_current_projectile(new/datum/projectile/bullet/bullet_22/a180)
		AddComponent(/datum/component/holdertargeting/fullauto, 0.6)
		..()
