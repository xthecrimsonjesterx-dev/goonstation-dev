/obj/item/firearm/kinetic/sirius_assault_rifle
	name = "\improper Sirius assault rifle"
	desc = "A bullpup assault rifle capable of semi-automatic and burst fire modes, developed by Almagest Weapons Fabrication."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "assault_rifle"
	item_state = "assault_rifle"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags =  TABLEPASS | CONDUCT | USEDELAY
	c_flags = ONBACK
	force = MELEE_DMG_RIFLE
	contraband = 8
	ammo_cats = list(AMMO_AUTO_556)
	max_ammo_capacity = 20
	auto_eject = 1
	ammobag_magazines = list(/obj/item/ammo/bullets/assault_rifle, /obj/item/ammo/bullets/assault_rifle/armor_piercing)
	ammobag_restock_cost = 2

	two_handed = 1
	can_dual_wield = 0
	spread_angle = 0
	default_magazine = /obj/item/ammo/bullets/assault_rifle
	recoil_strength = 9 // two handed guns can probably take lower recoil
	recoil_stacking_enabled = TRUE

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/assault_rifle)
		projectiles = list(current_projectile,new/datum/projectile/bullet/assault_rifle/burst)
		..()

	attackby(obj/item/ammo/bullets/b, mob/user)  // has to account for whether regular or armor-piercing ammo is loaded AND which firing mode it's using
		var/obj/previous_ammo = ammo
		var/mode_was_burst = (istype(current_projectile, /datum/projectile/bullet/assault_rifle/burst/))  // was previous mode burst fire?
		..()
		if(previous_ammo.type != ammo.type)  // we switched ammo types
			if(istype(ammo, /obj/item/ammo/bullets/assault_rifle/armor_piercing)) // we switched from normal to armor_piercing
				if(mode_was_burst) // we were in burst shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle/burst/armor_piercing)
					projectiles = list(new/datum/projectile/bullet/assault_rifle/armor_piercing, current_projectile)
				else // we were in single shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle/armor_piercing)
					projectiles = list(current_projectile, new/datum/projectile/bullet/assault_rifle/burst/armor_piercing)
			else // we switched from armor penetrating ammo to normal
				if(mode_was_burst) // we were in burst shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle/burst)
					projectiles = list(new/datum/projectile/bullet/assault_rifle, current_projectile)
				else // we were in single shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle)
					projectiles = list(current_projectile, new/datum/projectile/bullet/assault_rifle/burst)

	attack_self(mob/user as mob)
		..()	//burst shot has a slight spread.
		if (istype(current_projectile, /datum/projectile/bullet/assault_rifle/burst/))
			spread_angle = 12.5
			shoot_delay = 4 DECI SECONDS
		else
			spread_angle = 0
			shoot_delay = 3 DECI SECONDS

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()
