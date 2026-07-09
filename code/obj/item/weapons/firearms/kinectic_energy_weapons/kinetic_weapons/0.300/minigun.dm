/obj/item/firearm/kinetic/minigun // it is now STRONK
	name = "\improper Alpha Hydrae minigun"
	desc = "The Almagest M134 Alpha Hydrae is a six-barrel rotary machine gun chambered in 7.62×51mm NATO. The nuclear option for suppressive fire."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "minigun"
	item_state = "heavy"
	force = MELEE_DMG_LARGE
	ammo_cats = list(AMMO_AUTO_308)
	max_ammo_capacity = 200 //its a minigun it can have some ammo
	two_handed = TRUE
	auto_eject = 0
	has_empty_state = 1
	spread_angle = 15 //15 degrees is a lot
	can_dual_wield = TRUE //if you can figure it out, you can do it
	fire_animation = TRUE
	recoil_strength = 12

	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = EQUIPPED_WHILE_HELD

	w_class = W_CLASS_BULKY
	default_magazine = /obj/item/ammo/bullets/minigun

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/minigun)
		AddComponent(/datum/component/holdertargeting/fullauto/ramping, 2.5, 0.4, 0.9) //you only get full auto, why would you burst fire with a minigun?
		..()

	setupProperties()
		..()
		setProperty("carried_movespeed", 1.5) //the addative slow down does not play nice with the full auto so you get this instead
