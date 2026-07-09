/obj/item/firearm/kinetic/foamdartgun
	name = "\improper Super! Gun Friend"
	desc = "A toy gun that fires foam darts. Keep out of reach of clowns, staff assistants and scientists."
	icon = 'icons/obj/items/guns/toy.dmi'
	icon_state = "foamdartgun"
	w_class = W_CLASS_SMALL
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi'
	item_state = "toygun"
	contraband = 1
	force = 1
	ammo_cats = list(AMMO_FOAMDART)
	max_ammo_capacity = 1
	muzzle_flash = null
	default_magazine = /obj/item/ammo/bullets/foamdarts
	var/pulled = FALSE
	add_residue = FALSE
	recoil_enabled = FALSE

	New()
		ammo = new default_magazine
		ammo.amount_left = 1
		set_current_projectile(new/datum/projectile/bullet/foamdart)
		..()

	attack_self(mob/user as mob)
		..()
		if(!pulled)
			pulled = TRUE
			playsound(user.loc, 'sound/weapons/gunload_click.ogg', 60, 1)
			UpdateIcon()

	update_icon()
		..()
		if(pulled)
			icon_state="foamdartgun-pull"
		else
			icon_state="foamdartgun"

	canshoot(mob/user)
		if(!pulled)
			return FALSE
		else
			return ..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if(!src.canshoot(user))
			boutput(user, SPAN_NOTICE("You need to pull back the pully tab thingy first!"))
			playsound(user, 'sound/weapons/Gunclick.ogg', 60, TRUE)
			return
		..()
		pulled = FALSE
		UpdateIcon()

	shoot_point_blank(atom/target, var/mob/user, second_shot)
		if(!src.canshoot(user))
			boutput(user, SPAN_NOTICE("You need to pull back the pully tab thingy first!"))
			playsound(user, 'sound/weapons/Gunclick.ogg', 60, TRUE)
			return
		..()
		pulled = FALSE
		UpdateIcon()

/obj/item/firearm/kinetic/foamdartgun/borg
	name = "cybernetic foam dart gun"
	desc = "A law enforcement weapon that fires foam darts. Synthesizes darts directly from the battery and includes new auto-load technology."
	icon_state="foamdartgun-pull"
	inventory_counter_enabled = FALSE
	allowReverseReload = FALSE
	var/power_requirement = 100 //! The amount of power deducted from a borg's cell when they fire this.

	New()
		. = ..()
		set_current_projectile(new /datum/projectile/bullet/foamdart/biodegradable)

	canshoot(mob/user)
		// no parent call so we don't care if it's pulled
		if (issilicon(user))
			var/mob/living/silicon/S = user
			return S.cell?.charge >= power_requirement
		else // guess someone spawned one???
			return TRUE

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (src.canshoot(user))
			. = ..() // this checks canshoot twice; could be refactored
		else
			boutput(user, SPAN_ALERT("You're too low on power to synthesize a dart!"))

	shoot_point_blank(atom/target, mob/user, second_shot)
		if (src.canshoot(user))
			. = ..()
		else
			boutput(user, SPAN_ALERT("You're too low on power to synthesize a dart!"))

	process_ammo(mob/user)
		if (issilicon(user))
			var/mob/living/silicon/S = user
			S.cell?.use(src.power_requirement)
		return TRUE


/obj/item/firearm/kinetic/foamdartrevolver
	name = "\improper Super! Revolver Friend"
	desc = "An advanced dart gun for experienced pros. Just holding it imbues you with a sense of great power."
	icon = 'icons/obj/items/guns/toy.dmi'
	icon_state = "foamdartrevolver"
	w_class = W_CLASS_SMALL
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi'
	item_state = "toyrevolver"
	contraband = 1
	force = 1
	ammo_cats = list(AMMO_FOAMDART)
	max_ammo_capacity = 6
	muzzle_flash = null
	default_magazine = /obj/item/ammo/bullets/foamdarts
	add_residue = FALSE
	recoil_enabled = FALSE

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/foamdart)
		..()
/obj/item/firearm/kinetic/foamdartshotgun
	name = "\improper Super! Shotgun Friend"
	desc = "An even more powerful, bigger brother of the dart gun. Kicks like a horse, a foam horse. A horse made of foam."
	icon = 'icons/obj/items/guns/toy.dmi'
	icon_state = "foamdartshotgun"
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi'
	item_state = "foamdartshotgun"
	wear_state = "foamdartshotgun"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	contraband = 1
	two_handed = TRUE
	auto_eject = FALSE
	c_flags = ONBACK
	force = 2
	ammo_cats = list(AMMO_FOAMDART)
	max_ammo_capacity = 12
	muzzle_flash = null
	default_magazine = /obj/item/ammo/bullets/foamdarts
	add_residue = FALSE
	recoil_strength = 3

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/special/spreader/buckshot_burst/foamdarts)
		..()
