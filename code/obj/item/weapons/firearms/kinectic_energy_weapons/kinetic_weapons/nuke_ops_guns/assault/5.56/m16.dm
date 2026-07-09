/obj/item/firearm/kinetic/m16
	name = "\improper M16"
	desc = "This gun's seen a lot of conflict! And you're probably going to make it see more. Uses 5.56 rounds."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "m16"
	item_state = "m16"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags =  TABLEPASS | CONDUCT | USEDELAY
	c_flags = EQUIPPED_WHILE_HELD
	force = MELEE_DMG_RIFLE
	contraband = 8
	ammo_cats = list(AMMO_AUTO_556)
	max_ammo_capacity = 20
	auto_eject = TRUE
	two_handed = TRUE
	can_dual_wield = FALSE
	spread_angle = 0
	fire_animation = TRUE
	has_empty_state = TRUE
	default_magazine = /obj/item/ammo/bullets/assault_rifle/remington

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/assault_rifle/remington)
		projectiles = list(current_projectile,new/datum/projectile/bullet/assault_rifle/burst/remington)
		..()

	attackby(obj/item/ammo/bullets/b, mob/user)  // has to account for whether regular or armor-piercing ammo is loaded AND which firing mode it's using
		var/obj/previous_ammo = ammo
		var/mode_was_burst = (istype(current_projectile, /datum/projectile/bullet/assault_rifle/burst))  // was previous mode burst fire?
		..()
		if(previous_ammo.type != ammo.type)  // we switched ammo types
			if(istype(ammo, /obj/item/ammo/bullets/assault_rifle/armor_piercing)) // we switched from normal to armor_piercing
				if(mode_was_burst) // we were in burst shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle/burst/armor_piercing)
					projectiles = list(new/datum/projectile/bullet/assault_rifle/armor_piercing, current_projectile)
				else // we were in single shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle/armor_piercing)
					projectiles = list(current_projectile, new/datum/projectile/bullet/assault_rifle/burst/armor_piercing)
			else if(istype(ammo, /obj/item/ammo/bullets/assault_rifle/remington))
				if(mode_was_burst) // we were in burst shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle/remington)
					projectiles = list(new/datum/projectile/bullet/assault_rifle/remington, current_projectile)
				else // we were in single shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle/burst/remington)
					projectiles = list(current_projectile, new/datum/projectile/bullet/assault_rifle/burst/remington)
			else // we switched from armor penetrating ammo to normal
				if(mode_was_burst) // we were in burst shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle/burst)
					projectiles = list(new/datum/projectile/bullet/assault_rifle, current_projectile)
				else // we were in single shot mode
					set_current_projectile(new/datum/projectile/bullet/assault_rifle)
					projectiles = list(current_projectile, new/datum/projectile/bullet/assault_rifle/burst)

	attack_self(mob/user)
		..()	//burst shot has a slight spread.
		if (istype(current_projectile, /datum/projectile/bullet/assault_rifle/burst))
			spread_angle = 7.5
			shoot_delay = 4 DECI SECONDS
		else
			spread_angle = 0
			shoot_delay = 3 DECI SECONDS
