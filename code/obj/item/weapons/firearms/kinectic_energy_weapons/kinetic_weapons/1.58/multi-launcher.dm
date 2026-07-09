/obj/item/firearm/kinetic/mrl
	desc = "A 6-barrel multiple rocket launcher armed with guided micro-missiles."
	name = "Fomalhaut MRL"
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi'
	icon_state = "mrls"
	item_state = "mrls"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	c_flags = ONBACK
	w_class = W_CLASS_BULKY
	throw_speed = 2
	throw_range = 4
	force = MELEE_DMG_LARGE
	contraband = 8
	ammo_cats = list(AMMO_ROCKET_MRL)
	max_ammo_capacity = 6
	can_dual_wield = 0
	two_handed = 1
	muzzle_flash = "muzzle_flash_launch"
	default_magazine = /obj/item/ammo/bullets/mrl
	ammobag_magazines = list(/obj/item/ammo/bullets/mrl)
	ammobag_spec_required = TRUE
	ammobag_restock_cost = 6
	recoil_strength = 12

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		ammo.amount_left = 0 // Spawn empty.
		set_current_projectile(new /datum/projectile/bullet/homing/rocket/mrl)
		AddComponent(/datum/component/holdertargeting/windup, 0.2 SECOND)
		..()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	loaded
		New()
			..()
			ammo.amount_left = 6
			UpdateIcon()
			return
