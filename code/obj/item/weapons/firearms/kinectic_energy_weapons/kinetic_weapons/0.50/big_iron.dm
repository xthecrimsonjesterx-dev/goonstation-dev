/obj/item/firearm/kinetic/bigiron
	name = "Maelor 500 magnum"
	desc = "An immense revolver from Mabinogi Firearms Company. You could probably stop a charging space bear with this thing. Or a bus."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "maelor"
	item_state = "colt_saa"
	w_class = W_CLASS_NORMAL
	force = MELEE_DMG_RIFLE
	ammo_cats = list(AMMO_DEAGLE)
	rarity = 5
	spread_angle = 1
	max_ammo_capacity = 7
	default_magazine = /obj/item/ammo/bullets/fivehundred
	recoil_strength = 25

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/deagle50cal)
		..()
