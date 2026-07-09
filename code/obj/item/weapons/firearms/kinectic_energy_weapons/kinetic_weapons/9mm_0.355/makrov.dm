/obj/item/firearm/kinetic/makarov
	name = "\improper PM Pistol"
	desc = "A time-proven semi-automatic, 9x18mm caliber service pistol, still produced by the Zvezda Design Bureau."
	icon_state = "makarov"
	item_state = "makarov"
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_PISTOL
	contraband = 4
	ammo_cats = list(AMMO_PISTOL_9MM_SOVIET)
	max_ammo_capacity = 8
	shoot_delay = 2
	auto_eject = TRUE
	has_empty_state = TRUE
	fire_animation = TRUE
	gildable = TRUE
	default_magazine = /obj/item/ammo/bullets/nine_mm_soviet

	New()
		ammo = new default_magazine
		set_current_projectile(new /datum/projectile/bullet/nine_mm_soviet)
		..()
