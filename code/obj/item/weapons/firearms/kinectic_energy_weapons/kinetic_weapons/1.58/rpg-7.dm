// Ported from old, non-gun RPG-7 object class (Convair880).
/obj/item/firearm/kinetic/rpg7
	desc = "A rocket-propelled grenade launcher licensed by the Space Irish Republican Army."
	name = "\improper MPRT-7"
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi'
	icon_state = "rpg7"
	item_state = "rpg7"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	c_flags = ONBACK
	w_class = W_CLASS_BULKY
	throw_speed = 2
	throw_range = 4
	force = MELEE_DMG_LARGE
	contraband = 8
	ammo_cats = list(AMMO_ROCKET_ALL)
	max_ammo_capacity = 1
	can_dual_wield = 0
	two_handed = 1
	muzzle_flash = "muzzle_flash_launch"
	has_empty_state = 1
	default_magazine = /obj/item/ammo/bullets/rpg
	ammobag_magazines = list(/obj/item/ammo/bullets/rpg)
	ammobag_spec_required = TRUE
	ammobag_restock_cost = 4
	recoil_strength = 13

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		ammo.amount_left = 0 // Spawn empty.
		set_current_projectile(new /datum/projectile/bullet/rpg)
		AddComponent(/datum/component/holdertargeting/windup, 0.2 SECOND)
		..()

	update_icon()
		..()
		if (src.ammo.amount_left < 1)
			src.item_state = "rpg7_empty"
		else
			src.item_state = "rpg7"
		if (ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			H.update_inhands()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	loaded
		New()
			..()
			ammo.amount_left = 1
			src.UpdateIcon()
			return
