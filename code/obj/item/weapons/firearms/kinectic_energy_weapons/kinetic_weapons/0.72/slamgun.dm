/obj/item/firearm/kinetic/slamgun
	name = "slamgun"
	desc = "A 12 gauge shotgun. Apparently. It's just two pipes stacked together."
	icon = 'icons/obj/slamgun.dmi'
	icon_state = "slamgun-ready"
	inhand_image_icon = 'icons/obj/slamgun.dmi'
	item_state = "slamgun-ready-world"
	force = MELEE_DMG_RIFLE
	ammo_cats = list(AMMO_SHOTGUN_ALL)
	max_ammo_capacity = 1
	auto_eject = 0
	object_flags = NO_GHOSTCRITTER | NO_ARM_ATTACH
	spread_angle = 10 // sorry, no sniping with slamguns

	can_dual_wield = 0
	two_handed = 1
	w_class = W_CLASS_BULKY
	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	default_magazine = /obj/item/ammo/bullets/a12
	sound_load_override = 'sound/weapons/gunload_sawnoff.ogg'
	recoil_strength = 14
	recoil_max = 14

	New()
		set_current_projectile(new/datum/projectile/bullet/a12)
		ammo = new /obj/item/ammo/bullets/a12
		ammo.amount_left = 0 // Spawn empty.
		..()

	attack_self(mob/user as mob)
		if (src.icon_state == "slamgun-ready")
			if(user.updateTwoHanded(src, FALSE)) // should never fail, but respect error codes
				w_class = W_CLASS_NORMAL
				force = MELEE_DMG_REVOLVER
				if (src.ammo.amount_left > 0 || src.casings_to_eject > 0)
					src.icon_state = "slamgun-open-loaded"
				else
					src.icon_state = "slamgun-open"
				UpdateIcon()
				two_handed = 0

			user.update_inhands()
		else
			if(user.updateTwoHanded(src, TRUE))
				w_class = W_CLASS_BULKY
				force = MELEE_DMG_RIFLE
				src.icon_state = "slamgun-ready"
				UpdateIcon()
				two_handed = 1
				user.update_inhands()

	canshoot(mob/user)
		if (src.icon_state == "slamgun-ready")
			return ..()
		else
			return 0

	attack_hand(mob/user as mob)
		. = src.casings_to_eject
		..()
		if(. != src.casings_to_eject)
			UpdateIcon()

	update_icon()
		if(src.icon_state == "slamgun-ready")
			src.item_state = "slamgun-ready-world"
		else
			src.item_state = "slamgun-open-world"
			if (src.ammo.amount_left > 0 || src.casings_to_eject > 0)
				src.icon_state = "slamgun-open-loaded"
			else
				src.icon_state = "slamgun-open"

		..()

	mouse_drop(atom/over_object, src_location, over_location, params)
		if (usr.stat || usr.restrained() || !can_reach(usr, src) || usr.getStatusDuration("unconscious") || usr.sleeping || usr.lying || isAIeye(usr) || isAI(usr) || isghostcritter(usr))
			return ..()
		if (over_object == usr && src.icon_state == "slamgun-open-loaded") // sorry for doing it like this, but i have no idea how to do it cleaner.
			src.Attackhand(usr)
			return

	attackby(obj/item/b, mob/user)
		if (istype(b, /obj/item/ammo/bullets) && src.icon_state == "slamgun-ready")
			boutput(user, SPAN_ALERT("You can't shove shells down the barrel! You'll have to open \the [src]!"))
			return
		if (istype(b, /obj/item/ammo/bullets) && (src.ammo.amount_left > 0 || src.casings_to_eject > 0))
			boutput(user, SPAN_ALERT("\The [src] already has a shell inside! You'll have to unload \the [src]!"))
			return
		..()

	alter_projectile(var/obj/projectile/P)
		. = ..()
		P.proj_data.shot_sound = 'sound/weapons/sawnoff.ogg'

	pixelaction(atom/target, params, mob/user, reach, continuousFire = 0)
		if (src.icon_state == "slamgun-ready")
			..()
		else
			boutput(user, SPAN_ALERT("You can't fire \the [src] when it is open!"))
