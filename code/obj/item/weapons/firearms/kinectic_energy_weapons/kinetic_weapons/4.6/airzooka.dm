/obj/item/firearm/kinetic/airzooka //This is technically kinetic? I guess?
	name = "Super! Bazooka Friend"
	desc = "The new double action air projection device from Super! Friend."
	icon = 'icons/obj/items/guns/toy.dmi'
	icon_state = "airzooka"
	force = MELEE_DMG_PISTOL
	max_ammo_capacity = 10
	ammo_cats = list(AMMO_AIRZOOKA)
	muzzle_flash = "muzzle_flash_launch"
	default_magazine = /obj/item/ammo/bullets/airzooka

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/airzooka)
		..()
