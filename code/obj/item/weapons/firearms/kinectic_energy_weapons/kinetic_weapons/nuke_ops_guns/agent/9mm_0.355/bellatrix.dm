/obj/item/firearm/kinetic/smg/bellatrix
	name = "\improper Bellatrix submachine gun"
	desc = "A semi-automatic, 9mm submachine gun, developed by Almagest Weapons Fabrication."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "mp52"
	w_class = W_CLASS_SMALL
	object_flags = NO_GHOSTCRITTER | NO_ARM_ATTACH
	force = MELEE_DMG_SMG
	contraband = 4
	ammo_cats = list(AMMO_SMG_9MM)
	max_ammo_capacity = 30
	auto_eject = 1
	spread_angle = 10
	has_empty_state = 1
	default_magazine = /obj/item/ammo/bullets/bullet_9mm/smg
	ammobag_magazines = list(/obj/item/ammo/bullets/bullet_9mm/smg)
	ammobag_restock_cost = 2
	recoil_strength = 8

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/bullet_9mm/smg)
		..()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	attack_self(mob/user as mob)
		if(ishuman(user))
			if(two_handed)
				setTwoHanded(0) //Go 1-handed.
				src.spread_angle = initial(src.spread_angle)
				icon_recoil_cap = initial(src.icon_recoil_cap)
				recoil_max = initial(src.recoil_max)
				recoil_strength = initial(src.recoil_strength)
			else
				if(!setTwoHanded(1)) //Go 2-handed.
					boutput(user, SPAN_ALERT("Can't switch to 2-handed while your other hand is full."))
				else
					icon_recoil_cap = 10
					recoil_max = 100
					src.spread_angle = 4
					recoil_strength = 5
		..()

/obj/item/firearm/kinetic/smg/bellatrix/empty

	New()
		..()
		ammo.amount_left = 0
		UpdateIcon()
