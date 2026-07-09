/obj/item/firearm/kinetic/grenade_launcher
	name = "\improper Rigil grenade launcher"
	desc = "A 40mm hand-held grenade launcher, developed by Almagest Weapons Fabrication."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "grenade_launcher"
	item_state = "grenade_launcher"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags =  TABLEPASS | CONDUCT | USEDELAY
	c_flags = ONBACK
	force = MELEE_DMG_RIFLE
	contraband = 7
	ammo_cats = list(AMMO_GRENADE_ALL)
	max_ammo_capacity = 4 // to fuss with if i want 6 packs of ammo
	two_handed = 1
	can_dual_wield = 0
	auto_eject = 0
	default_magazine = /obj/item/ammo/bullets/grenade_round/explosive
	ammobag_magazines = list(/obj/item/ammo/bullets/grenade_round/explosive)
	ammobag_spec_required = TRUE
	ammobag_restock_cost = 3
	sound_load_override = 'sound/weapons/gunload_rigil.ogg'
	recoil_strength = 12
	recoil_max = 40

	New()
		START_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		ammo = new default_magazine
		ammo.amount_left = max_ammo_capacity
		set_current_projectile(new/datum/projectile/bullet/grenade_round/explosive)
		..()

	attackby(obj/item/b, mob/user)
		if (istype(b, /obj/item/chem_grenade) || istype(b, /obj/item/explosive/old_grenade))
			if((src.ammo.amount_left > 0 && !istype(current_projectile, /datum/projectile/bullet/grenade_shell)) || src.ammo.amount_left >= src.max_ammo_capacity)
				boutput(user, SPAN_ALERT("The [src.name] already has something in it! You can't use the conversion chamber right now! You'll have to manually unload the [src.name]!"))
				return
			else
				var/datum/projectile/bullet/grenade_shell/custom_shell = src.current_projectile
				if(src.ammo.amount_left > 0 && istype(custom_shell) && custom_shell.get_nade().type != b.type)
					boutput(user, SPAN_ALERT("The [src.name] has a different kind of grenade in the conversion chamber, and refuses to mix and match!"))
					return
				else
					SETUP_GENERIC_ACTIONBAR(user, src, 0.3 SECONDS, PROC_REF(convert_grenade), list(b, user), b.icon, b.icon_state,"", null)
					return
		else
			..()

	disposing()
		STOP_TRACKING_CAT(TR_CAT_NUKE_OP_STYLE)
		..()

	proc/convert_grenade(obj/item/nade, mob/user)
		var/obj/item/ammo/bullets/grenade_shell/TO_LOAD = new /obj/item/ammo/bullets/grenade_shell/rigil
		TO_LOAD.Attackby(nade, user)
		src.Attackby(TO_LOAD, user)
