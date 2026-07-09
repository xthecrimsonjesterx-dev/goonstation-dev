/obj/item/firearm/kinetic/sniper
	name = "\improper Betelgeuse sniper rifle"
	desc = "A semi-automatic bullpup sniper rifle, developed by Almagest Weapons Fabrication."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "sniper"
	item_state = "sniper"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = MELEE_DMG_RIFLE
	ammo_cats = list(AMMO_RIFLE_308)
	max_ammo_capacity = 6
	auto_eject = 1
	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = EQUIPPED_WHILE_HELD | ONBACK
	slowdown = 7
	slowdown_time = 5

	can_dual_wield = 0
	contraband = 7
	two_handed = 1
	w_class = W_CLASS_BULKY

	shoot_delay = 1 SECOND
	default_magazine = /obj/item/ammo/bullets/rifle_762_NATO
	ammobag_magazines = list(/obj/item/ammo/bullets/rifle_762_NATO)
	ammobag_restock_cost = 3
	recoil_strength = 15
	recoil_inaccuracy_max = 0 // just to be nice :)
	abilities = list(/obj/ability_button/toggle_scope)
	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/rifle_762_NATO)
		AddComponent(/datum/component/holdertargeting/sniper_scope, 12, 3200, /datum/overlayComposition/sniper_scope, 'sound/weapons/scope.ogg')
		..()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	setupProperties()
		..()
		setProperty("carried_movespeed", 0.8)
