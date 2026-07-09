/obj/item/firearm/kinetic/dart_rifle
	name = "tranquilizer rifle"
	desc = "A veterinary tranquilizer rifle chambered in .308 caliber. This rifle can only accept .308 tranquilizer darts."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "tranq"
	item_state = "tranq"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags =  TABLEPASS | CONDUCT | USEDELAY
	c_flags = ONBACK
	force = MELEE_DMG_RIFLE
	//contraband = 8
	ammo_cats = list(AMMO_TRANQ_308)
	max_ammo_capacity = 4 // It's magazine-fed (Convair880).
	auto_eject = 1
	can_dual_wield = 0
	two_handed = 1
	gildable = 1
	default_magazine = /obj/item/ammo/bullets/tranq_darts
	fire_animation = TRUE
	recoil_strength = 4

	New()
		ammo = new default_magazine
		ammo_incompatible_msg = "[src] can only accept .308 tranquilizer darts!"
		set_current_projectile(new/datum/projectile/bullet/tranq_dart)
		..()
