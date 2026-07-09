/obj/item/firearm/kinetic/akm
	name = "\improper AKM Assault Rifle"
	desc = "An old Cold War relic chambered in 7.62x39. Rusted, but not busted. Vast numbers were brought back into service for the Martian war."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "ak47"
	item_state = "ak47"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = MELEE_DMG_RIFLE
	contraband = 8
	ammo_cats = list(AMMO_AUTO_762)
	spread_angle = 9
	shoot_delay = 3 DECI SECONDS
	max_ammo_capacity = 30
	auto_eject = 1
	can_dual_wield = 0
	two_handed = 1
	gildable = 1
	default_magazine = /obj/item/ammo/bullets/akm
	fire_animation = TRUE
	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = ONBACK
	w_class = W_CLASS_BULKY
	ammobag_magazines = list(/obj/item/ammo/bullets/akm)
	ammobag_restock_cost = 3
	recoil_strength = 10

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/akm)
		..()
