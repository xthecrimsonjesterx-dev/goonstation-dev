/obj/item/firearm/kinetic/recoilless
	name = "\improper Carinae RCL/120"
	desc = "An absurdly destructive 120mm recoilless gun-mortar, the largest man-portable weapon in the Almagest line."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "recoilless"
	item_state = "cannon"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = MELEE_DMG_LARGE
	ammo_cats = list(AMMO_HOWITZER)
	max_ammo_capacity = 1
	auto_eject = 1
	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = EQUIPPED_WHILE_HELD | ONBACK

	can_dual_wield = 0

	slowdown = 10
	slowdown_time = 15

	recoil_strength = 0 // saving the discord from this joke

	two_handed = 1
	w_class = W_CLASS_BULKY
	muzzle_flash = "muzzle_flash_launch"
	default_magazine = /obj/item/ammo/bullets/howitzer
	ammobag_magazines = list(/obj/item/ammo/bullets/howitzer)
	ammobag_spec_required = TRUE
	ammobag_restock_cost = 5

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/howitzer)
		AddComponent(/datum/component/holdertargeting/windup, 0.2 SECOND)

		..()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	setupProperties()
		..()
		setProperty("carried_movespeed", 0.2)
