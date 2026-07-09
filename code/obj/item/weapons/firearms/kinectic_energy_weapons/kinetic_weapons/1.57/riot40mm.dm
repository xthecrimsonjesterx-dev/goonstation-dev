/obj/item/firearm/kinetic/riot40mm
	desc = "A classic 40mm riot-control launcher from Cormorant Precision Arms. It can accept standard 40mm rounds and hand-thrown grenades."
	name = "\improper Puffin 40mm riot launcher"
	icon_state = "40mm"
	item_state = "40mm"
	force = MELEE_DMG_SMG
	contraband = 7
	ammo_cats = list(AMMO_GRENADE_ALL)
	max_ammo_capacity = 1
	muzzle_flash = "muzzle_flash_launch"
	default_magazine = /obj/item/ammo/bullets/smoke/single
	fire_animation = TRUE
	recoil_strength = 12

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/smoke)
		..()

	attackby(obj/item/b, mob/user)
		if (istype(b, /obj/item/chem_grenade) || istype(b, /obj/item/explosive/old_grenade))
			if(src.ammo.amount_left > 0)
				boutput(user, SPAN_ALERT("The [src.name] already has something in it! You can't use the conversion chamber right now! You'll have to manually unload the [src.name]!"))
				return
			else
				SETUP_GENERIC_ACTIONBAR(user, src, 1 SECOND, PROC_REF(convert_grenade), list(b, user), b.icon, b.icon_state,"", null)
				return
		else
			..()

	proc/convert_grenade(obj/item/nade, mob/user)
		var/obj/item/ammo/bullets/grenade_shell/TO_LOAD = new /obj/item/ammo/bullets/grenade_shell
		TO_LOAD.Attackby(nade, user)
		src.Attackby(TO_LOAD, user)

	breach
		default_magazine = /obj/item/ammo/bullets/breach_flashbang/single
		New()
			..()
			ammo = new default_magazine
			set_current_projectile(new/datum/projectile/bullet/breach_flashbang)
