/obj/item/firearm/kinetic/cannon
	name = "\improper Alphard 20mm cannon"
	desc = "A 20mm anti-materiel recoiling cannon from Almagest. Slow but enormously powerful."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "cannon"
	item_state = "cannon"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = MELEE_DMG_LARGE
	ammo_cats = list(AMMO_CANNON_20MM)
	max_ammo_capacity = 1
	auto_eject = 1
	fire_animation = TRUE
	rarity = 4

	recoil_strength = 20
	recoil_max = 25 //seriously how are you going to fire this more than once

	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = EQUIPPED_WHILE_HELD | ONBACK

	can_dual_wield = 0

	slowdown = 10
	slowdown_time = 15

	contraband = 8
	two_handed = 1
	w_class = W_CLASS_BULKY
	muzzle_flash = "muzzle_flash_launch"
	default_magazine = /obj/item/ammo/bullets/cannon/single
	ammobag_magazines = list(/obj/item/ammo/bullets/cannon)
	ammobag_spec_required = TRUE
	ammobag_restock_cost = 3


	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/cannon)
		AddComponent(/datum/component/holdertargeting/windup, 0.2 SECOND)
		..()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	setupProperties()
		..()
		setProperty("carried_movespeed", 0.5)
