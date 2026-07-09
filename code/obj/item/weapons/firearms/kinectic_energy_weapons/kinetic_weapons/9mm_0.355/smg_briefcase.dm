/obj/item/firearm/kinetic/SMG_briefcase
	name = "secure briefcase"
	icon = 'icons/obj/items/storage.dmi'
	icon_state = "secure"
	inhand_image_icon = 'icons/mob/inhand/hand_general.dmi'
	item_state = "sec-case"
	desc = "A large briefcase with a digital locking system. This one has a small hole in the side of it and the emblem of Sceptre Tactical Laboratories. Odd."
	force = MELEE_DMG_SMG
	ammo_cats = list(AMMO_9MM_ALL)
	max_ammo_capacity = 30
	auto_eject = 0

	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	object_flags = NO_ARM_ATTACH
	c_flags = ONBELT

	spread_angle = 2
	can_dual_wield = 0
	default_magazine = /obj/item/ammo/bullets/nine_mm_NATO
	var/cases_to_eject = 0
	var/open = FALSE


	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/nine_mm_NATO/burst)
		..()

	attack_hand(mob/user)
		if(!user.find_in_hand(src))
			..() //this works, dont touch it
		else if(open)
			.=..()
		else
			boutput(user, SPAN_ALERT("You can't unload the [src] while it is closed."))

	attackby(obj/item/ammo/bullets/b as obj, mob/user)
		if(open)
			.=..()
		else
			boutput(user, SPAN_ALERT("You can't access the gun inside the [src] while it's closed! You'll have to open the [src]!"))

	attack_self(mob/user)
		if(open)
			open = FALSE
			UpdateIcon()
			boutput(user, SPAN_ALERT("You close the [src]!"))
		else
			boutput(user, SPAN_ALERT("You open the [src]."))
			open = TRUE
			UpdateIcon()
			if (src.loc == user && user.find_in_hand(src)) // Make sure it's not on the belt or in a backpack.
				src.add_fingerprint(user)
				if (!src.sanitycheck(0, 1))
					user.show_text("You can't unload this gun.", "red")
					return
				if (src.casings_to_eject > 0 && src.current_projectile.casing)
					if (!src.sanitycheck(1, 0))
						logTheThing(LOG_DEBUG, user, "<b>Convair880</b>: [user]'s gun ([src]) ran into the casings_to_eject cap, aborting.")
						src.casings_to_eject = 0
						return
					else
						user.show_text("You eject [src.casings_to_eject] casings from [src].", "red")
						src.ejectcasings()
						return
				else
					user.show_text("[src] is empty!", "red")
					return

	canshoot(mob/user)
		if(open)
			return 0
		else
			. = ..()

	update_icon()

		if(open)
			icon_state="guncase"
		else
			icon_state="secure"
