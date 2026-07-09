/obj/item/firearm/kinetic/light_machine_gun
	name = "\improper Antares light machine gun"
	desc = "A 100 round light machine gun, developed by Almagest Weapons Fabrication."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "lmg"
	item_state = "lmg"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = MELEE_DMG_RIFLE
	ammo_cats = list(AMMO_AUTO_308)
	max_ammo_capacity = 100
	auto_eject = 0
	shoot_delay = 7

	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = EQUIPPED_WHILE_HELD | ONBACK

	spread_angle = 6
	can_dual_wield = 0

	contraband = 7
	two_handed = 1
	w_class = W_CLASS_BULKY
	default_magazine = /obj/item/ammo/bullets/lmg
	ammobag_magazines = list(/obj/item/ammo/bullets/lmg)
	ammobag_restock_cost = 3

	camera_recoil_multiplier = 0.65 // this thing packs possibly excessive punch
	camera_recoil_sway_max = 10 // lower the wobblies when shooting huge volumes of lead

	recoil_strength = 5
	recoil_stacking_enabled = TRUE
	recoil_stacking_safe_stacks = 8
	recoil_stacking_max_stacks = 8
	recoil_stacking_amount = 0.5
	recoil_max = 100 // eat more recoil

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/lmg)
		projectiles = list(current_projectile, new/datum/projectile/bullet/lmg/auto)
		AddComponent(/datum/component/holdertargeting/fullauto, 1.5 DECI SECONDS)
		..()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	setupProperties()
		..()
		setProperty("carried_movespeed", 1)
