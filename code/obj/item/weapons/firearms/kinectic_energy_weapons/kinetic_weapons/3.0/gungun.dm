/obj/item/firearm/kinetic/gungun //meesa jarjar binks
	name = "\improper Gun"
	desc = "A gun that shoots... something. It looks like a modified grenade launcher."
	icon_state = "gungun"
	item_state = "gungun"
	w_class = W_CLASS_NORMAL
	ammo_cats = list(AMMO_DERRINGER_LITERAL)
	max_ammo_capacity = 6 //6 guns
	force = MELEE_DMG_SMG
	default_magazine = /obj/item/ammo/bullets/gun

	New()
		ammo = new default_magazine
		ammo.amount_left = 6 //spawn full please
		set_current_projectile(new /datum/projectile/special/spawner/gun)
		..()
