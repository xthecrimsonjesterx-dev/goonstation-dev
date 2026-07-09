////////////////////////////////////////// Kinetic parent //////////////////////////////////////////////////
// To be completed refactores file location for weapons pre-2026-era code here. All weapons code parents should be placed inside the primary folders as primary directives.
// All files secondary to such must be placed in a new secondary folder within the primary folder. This is to ensure that all weapons code is properly-
// organized and as easy to navigate for future development and maintenance. Ensure they are named appropriately.
//
// Contains:
// - Primary Folder
// -- example_parent.dm
// -- Secondary Folder
// --- example_child.dm
//

ABSTRACT_TYPE(/obj/item/firearm/kinetic)
/obj/item/firearm/kinetic
	name = "kinetic weapon"
	icon = 'icons/obj/items/guns/kinetic.dmi'
	item_state = "gun"
	m_amt = 2000
	camera_recoil_sway_min = 5 // kinetics can be more shuddery than lasers
	recoil_inaccuracy_max = 10 // +10 degrees of seperation at max recoil
	var/obj/item/ammo/bullets/ammo = null
	/// How much ammo can this gun hold? Don't make this null (Convair880).
	var/max_ammo_capacity = 1
	/// Can be a list too. The .357 Mag revolver can also chamber .38 Spc rounds, for instance (Convair880).
	var/ammo_cats = list()
	/// Does this gun have a special icon state for having no ammo lefT?
	var/has_empty_state = FALSE
	/// Does this gun have a special icon state it should flick to when fired?
	var/has_fire_anim_state = FALSE
	var/fire_anim_state = null
	/// Can this gun be affected by the [Helios] medal reward?
	var/gildable = FALSE
	/// Is this gun currently gilded by the [Helios] medal reward?
	var/gilded = FALSE
	/// Do we eject casings on firing, or on reload?
	var/auto_eject = FALSE
	/// If we don't automatically ejected them, we need to keep track (Convair880).
	var/casings_to_eject = 0
	/// What's the default magazine used in this gun? Set this in place of putting the type in New()
	var/default_magazine = null
	/// Assoc list of magazine types, standard ammo first, special ammo second
	var/list/ammobag_magazines = list()
	/// Can only special-ammo ammobags restock these?
	var/ammobag_spec_required = FALSE
	/// How many charges it costs an ammobag to fabricate ammo for this gun
	var/ammobag_restock_cost = 1
	/// Does this gun have a special sound it makes when loading instead of the assigned ammo sound?
	var/sound_load_override = null

	/// How many bullets get moved into this gun per action?
	var/max_move_amount = -1
	/// What's the fastest speed we can reload this? 2 deciseconds is the default spam limiter.
	var/reload_cooldown = 2 DECI SECONDS
	/// Does this gun add gunshot residue when fired? Kinetic guns should (Convair880).
	add_residue = TRUE

	/// Can you use the gun on ammo to reload?
	var/allowReverseReload = TRUE

	/// Can you Drag & Drop ammo onto the gun to reload?
	var/allowDropReload = TRUE

	/// `icon_state` of the muzzle flash of the gun (if any)
	muzzle_flash = "muzzle_flash"

	/// Feedback for incompatible ammo can be customized for clarity.
	var/ammo_incompatible_msg = "This ammo won't fit!"

	// caliber list: update as needed
	// 0.22 - pistols
	// 0.308 - rifles
	// 0.357 - revolver
	// 0.38 - detective
	// 0.41 - derringer
	// 0.72 - shotgun shell, 12ga
	// 1.57 - 40mm shell
	// 1.58 - RPG-7 (Tube is 40mm too, though warheads are usually larger in diameter.)

	New()
		..()
		src.UpdateIcon()

	examine()
		. = ..()
		if (src.ammo && (src.ammo.amount_left > 0))
			var/datum/projectile/ammo_type = src.ammo.ammo_type
			. += "There are [src.ammo.amount_left][(ammo_type.material && istype(ammo_type.material, /datum/material/metal/silver)) ? " silver " : " "]bullets of [src.ammo.sname] left!"
		else
			. += "There are 0 bullets left!"
		if (current_projectile)
			. += "Each shot will currently use [src.current_projectile.cost] bullets!"
		else
			. += SPAN_ALERT("*ERROR* No output selected!")

	update_icon()

		if (src.ammo)
			inventory_counter?.update_number(src.ammo.amount_left)
		else
			inventory_counter?.update_text("-")

		if(src.has_empty_state)
			if (src.ammo.amount_left < 1 && !findtext(src.icon_state, "-empty")) //sanity check
				src.icon_state = "[src.icon_state]-empty"
			else
				src.icon_state = replacetext(src.icon_state, "-empty", "")
		return 0

	canshoot(mob/user)
		if(src.ammo && src.current_projectile)
			if(src.ammo:amount_left >= src.current_projectile:cost)
				return 1
		return 0

	process_ammo(var/mob/user)
		if(src.ammo && src.current_projectile)
			if(src.ammo.use(current_projectile.cost))
				return 1
		if (src.click_sound)
			boutput(user, SPAN_ALERT(src.click_msg))
			if (!src.silenced)
				playsound(user, click_sound, 60, TRUE)
		return 0

	MouseDrop_T(atom/movable/O as mob|obj, mob/user as mob)
		if (istype(O, /obj/item/ammo/bullets) && allowDropReload)
			src.Attackby(O, user)
		return ..()

	attackby(obj/item/ammo/bullets/b, mob/user)
		if(istype(b, /obj/item/ammo/bullets))
			if(ON_COOLDOWN(src, "reload_spam", src.reload_cooldown))
				return
			switch (src.ammo.loadammo(b,src))
				if(0)
					user.show_text("You can't reload this gun.", "red")
					return
				if(AMMO_RELOAD_INCOMPATIBLE)
					user.show_text(src.ammo_incompatible_msg, "red")
					return
				if(AMMO_RELOAD_SOURCE_EMPTY)
					user.show_text("There's no ammo left in [b.name].", "red")
					return
				if(AMMO_RELOAD_ALREADY_FULL)
					user.show_text("[src] is full!", "red")
					return
				if(AMMO_RELOAD_PARTIAL)
					user.visible_message(SPAN_ALERT("[user] reloads [src]."), SPAN_ALERT("There wasn't enough ammo left in [b.name] to fully reload [src]. It only has [src.ammo.amount_left] rounds remaining."))
					src.tooltip_rebuild = TRUE
					src.logme_temp(user, src, b) // Might be useful (Convair880).
					return
				if(AMMO_RELOAD_FULLY)
					user.visible_message(SPAN_ALERT("[user] reloads [src]."), SPAN_ALERT("You fully reload [src] with ammo from [b.name]. There are [b.amount_left] rounds left in [b.name]."))
					src.tooltip_rebuild = TRUE
					src.logme_temp(user, src, b)
					return
				if(AMMO_RELOAD_TYPE_SWAP)
					switch (src.ammo.swap(b,src))
						if(AMMO_SWAP_INCOMPATIBLE)
							user.show_text("This ammo won't fit!", "red")
							return
						if(AMMO_SWAP_SOURCE_EMPTY)
							user.visible_message(SPAN_ALERT("[user] reloads [src]."), SPAN_ALERT("You swap out the magazine. Or whatever this specific gun uses."))
						if(AMMO_SWAP_ALREADY_FULL)
							user.visible_message(SPAN_ALERT("[user] reloads [src]."), SPAN_ALERT("You swap [src]'s ammo with [b.name]. There are [b.amount_left] rounds left in [b.name]."))
					src.logme_temp(user, src, b)
					return
				if(AMMO_RELOAD_CAPPED)
					if(!ON_COOLDOWN(src, "reload_single_spam", 3 SECONDS))
						user.visible_message("<span class='alert'>[user] loads some ammo into [src].</span>", "<span class='alert'>You load [src] with ammo from [b.name]. There are [b.amount_left] rounds left in [b.name].</span>")
					src.tooltip_rebuild = TRUE
					src.logme_temp(user, src, b)

		else
			..()

	//attack_self(mob/user as mob)
	//	return

	attack_hand(mob/user)
	// Added this to make manual reloads possible (Convair880).

		if ((src.loc == user) && user.find_in_hand(src)) // Make sure it's not on the belt or in a backpack.
			src.add_fingerprint(user)
			if(ON_COOLDOWN(src, "reload_spam", 2 DECI SECONDS))
				return
			if (src.sanitycheck(0, 1) == 0)
				user.show_text("You can't unload this gun.", "red")
				return
			src.eject_magazine(user)
		return ..()

	attack(mob/target, mob/user, def_zone, is_special = FALSE, params = null)
	// Finished Cogwerks' former WIP system (Convair880).
		if (src.canshoot(user) && user.a_intent != "help" && user.a_intent != "grab")
			if (src.auto_eject)
				var/turf/T = get_turf(src)
				if(T)
					if (src.current_projectile.casing && (src.sanitycheck(1, 0) == 1))
						var/number_of_casings = max(1, src.current_projectile.shot_number)
						//DEBUG_MESSAGE("Ejected [number_of_casings] casings from [src].")
						for (var/i in 1 to number_of_casings)
							new src.current_projectile.casing(T, src)
			else
				if (src.casings_to_eject < 0)
					src.casings_to_eject = 0
				src.casings_to_eject += src.current_projectile.shot_number
		. = ..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (src.canshoot(user) && !isghostdrone(user))
			if (src.auto_eject)
				var/turf/T = get_turf(src)
				if(T)
					if (src.current_projectile.casing && (src.sanitycheck(1, 0) == 1))
						var/number_of_casings = max(1, src.current_projectile.shot_number)
						//DEBUG_MESSAGE("Ejected [number_of_casings] casings from [src].")
						for (var/i in 1 to number_of_casings)
							new src.current_projectile.casing(T, src)
			else
				if (src.casings_to_eject < 0)
					src.casings_to_eject = 0
				src.casings_to_eject += src.current_projectile.shot_number

		if (fire_animation)
			if(src.ammo?.amount_left >= 1)
				var/flick_state = src.has_fire_anim_state && src.fire_anim_state ? src.fire_anim_state : src.icon_state
				FLICK(flick_state, src)

		if(..() && user.traction != TRACTION_FULL)
			user.inertia_dir = get_dir_accurate(target, user)
			user.inertia_value = 1
			step(user, user.inertia_dir) // Propel user in opposite direction

	proc/eject_magazine(mob/user)
		if (src.ammo.amount_left <= 0)
			// The gun may have been fired; eject casings if so.
			if ((src.casings_to_eject > 0) && src.current_projectile.casing)
				if (src.sanitycheck(1, 0) == 0)
					logTheThing(LOG_DEBUG, usr, "<b>Convair880</b>: [usr]'s gun ([src]) ran into the casings_to_eject cap, aborting.")
					src.casings_to_eject = 0
					return
				else
					user.show_text("You eject [src.casings_to_eject] casings from [src].", "red")
					src.ejectcasings()
					playsound(src, src.ammo.sound_load, rand(30, 60), TRUE)
					return
			else
				user.show_text("[src] is empty!", "red")
				return

		// Make a copy here to avoid item teleportation issues.
		var/obj/item/ammo/bullets/ammoHand = new src.ammo.type
		ammoHand.amount_left = src.ammo.amount_left
		ammoHand.name = src.ammo.name
		ammoHand.icon = src.ammo.icon
		ammoHand.icon_state = src.ammo.icon_state
		ammoHand.ammo_type = src.ammo.ammo_type
		ammoHand.delete_on_reload = 1 // No duplicating empty magazines, please (Convair880).
		ammoHand.UpdateIcon()
		user.put_in_hand_or_drop(ammoHand)
		ammoHand.after_unload(user)

		// The gun may have been fired; eject casings if so.
		src.ejectcasings()
		src.casings_to_eject = 0

		src.ammo.amount_left = 0
		src.ammo.refillable = FALSE
		src.UpdateIcon()
		src.add_fingerprint(user)
		ammoHand.add_fingerprint(user)

		user.visible_message(SPAN_ALERT("[user] unloads [src]."), SPAN_ALERT("You unload [src]."))
		//DEBUG_MESSAGE("Unloaded [src]'s ammo manually.")
		return

	proc/ejectcasings()
		if ((src.casings_to_eject > 0) && src.current_projectile.casing && (src.sanitycheck(1, 0) == 1))
			var/turf/T = get_turf(src)
			if(T)
				//DEBUG_MESSAGE("Ejected [src.casings_to_eject] [src.current_projectile.casing] from [src].")
				while (src.casings_to_eject > 0)
					new src.current_projectile.casing(T, src)
					src.casings_to_eject--
		return

	// Don't set this too high. Absurdly large reloads and item spawning can cause a lot of lag. (Convair880).
	proc/sanitycheck(var/casings = 0, var/ammo = 1)
		if (casings && (src.casings_to_eject > 30 || src.current_projectile.shot_number > 30))
			logTheThing(LOG_DEBUG, usr, "<b>Convair880</b>: [usr]'s gun ([src]) ran into the casings_to_eject cap, aborting.")
			if (src.casings_to_eject > 0)
				src.casings_to_eject = 0
			return 0
		if (ammo && (src.max_ammo_capacity > 200 || src.ammo.amount_left > 200))
			logTheThing(LOG_DEBUG, usr, "<b>Convair880</b>: [usr]'s gun ([src]) ran into the magazine cap, aborting.")
			return 0
		return 1

ABSTRACT_TYPE(/obj/item/firearm/kinetic/single_action)
/obj/item/firearm/kinetic/single_action
	// We need a separate uncocked state if a gun has a fire animation
	var/has_uncocked_state = FALSE
	var/hammer_cocked = FALSE

	// Handles the odd scenario of gilding and hammer cocking
	update_icon()
		. = ..()
		src.icon_state = src.gen_icon_state(FALSE)
		src.wear_state = src.gen_icon_state(TRUE)
		if (src.has_uncocked_state && src.fire_animation)
			src.has_fire_anim_state = TRUE
			src.fire_anim_state = src.gen_icon_state(TRUE)

	canshoot(mob/user)
		if (hammer_cocked)
			return ..()
		else
			return FALSE

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		. = ..()
		hammer_cocked = FALSE
		src.UpdateIcon()

	attack_self(mob/user as mob)
		..()	//burst shot has a slight spread.
		if (hammer_cocked)
			boutput(user, SPAN_NOTICE("You gently lower the weapon's hammer!"))
		else
			boutput(user, SPAN_ALERT("You cock the hammer!"))
			playsound(user.loc, 'sound/weapons/gun_cocked_colt45.ogg', 70, 1)
		src.hammer_cocked = !src.hammer_cocked
		src.UpdateIcon()

	proc/gen_icon_state(ignore_hammer_state)
		var/state = "[initial(src.icon_state)]" + (src.gilded ? "-golden" : "")
		if (!ignore_hammer_state && src.hammer_cocked)
			state += "-c"
		// Gun is uncocked and has a separate uncock icon_state
		else if (!ignore_hammer_state && src.has_uncocked_state)
			state +="-uc"
		return state


ABSTRACT_TYPE(/obj/item/survival_rifle_barrel)
/obj/item/survival_rifle_barrel
	icon = 'icons/obj/electronics.dmi'
	icon_state = "dbox"
	var/caliber_name = ""
	var/rifle_icon_state = ""
	var/ammo_cats = list()
	var/max_ammo_capacity = 1
	var/default_magazine = null
	var/default_projectile = null
	var/recoil_strength = 6
	New()
		name = "[src.caliber_name] rifle barrel"
		desc = "An interchangable barrel for the Efnysien survival rifle. This one is designed to fire [src.caliber_name]."
		..()

	barrel_22
		caliber_name = ".22 LR"
		rifle_icon_state = "survival_rifle_22"
		ammo_cats = list(AMMO_PISTOL_22)
		max_ammo_capacity = 10
		default_magazine = /obj/item/ammo/bullets/bullet_22
		default_projectile = /datum/projectile/bullet/bullet_22
		recoil_strength = 6


	barrel_9mm
		caliber_name = "9x19mm Parabellum"
		rifle_icon_state = "survival_rifle_9mm"
		ammo_cats = list(AMMO_PISTOL_9MM_ALL)
		max_ammo_capacity = 15
		default_magazine = /obj/item/ammo/bullets/bullet_9mm
		default_projectile = /datum/projectile/bullet/bullet_9mm
		recoil_strength = 9

	barrel_556
		caliber_name = "5.56x45mm NATO"
		rifle_icon_state = "survival_rifle_556"
		ammo_cats = list(AMMO_AUTO_556)
		max_ammo_capacity = 20
		default_magazine = /obj/item/ammo/bullets/assault_rifle
		default_projectile = /datum/projectile/bullet/assault_rifle
		recoil_strength = 12

/obj/item/casing
	name = "bullet casing"
	desc = "A spent casing from a bullet of some sort."
	icon = 'icons/obj/items/casings.dmi'
	icon_state = "medium"
	w_class = W_CLASS_TINY
	burn_possible = FALSE
	tooltip_flags = REBUILD_USER
	var/fired_by = null // The name of the gun that fired this casing, e.g. "SPES-12". If not null can be identified by anyone with Forensic Training

	small
		icon_state = "small"
		desc = "Seems to be a small pistol cartridge."
		New()
			..()
			SPAWN(rand(1, 3))
				playsound(src.loc, "sound/weapons/casings/casing-small-0[rand(1,6)].ogg", 20, 0.1)

	medium
		icon_state = "medium"
		desc = "Seems to be a common revolver cartridge."
		New()
			..()
			SPAWN(rand(1, 3))
				playsound(src.loc, "sound/weapons/casings/casing-0[rand(1,9)].ogg", 20, 0.1)

	rifle
		icon_state = "rifle"
		desc = "Seems to be a rifle cartridge."
		New()
			..()
			SPAWN(rand(1, 3))
				playsound(src.loc, "sound/weapons/casings/casing-0[rand(1,9)].ogg", 20, 0.1, 0, 0.8)


	rifle_loud
		icon_state = "rifle"
		desc = "Seems to be a rifle cartridge."
		New()
			..()
			SPAWN(rand(1, 3))
				playsound(src.loc, "sound/weapons/casings/casing-large-0[rand(1,4)].ogg", 25, 0.1)

	derringer
		icon_state = "medium"
		desc = "A fat and stumpy bullet casing. Looks pretty old."
		New()
			..()
			SPAWN(rand(1, 3))
				playsound(src.loc, "sound/weapons/casings/casing-0[rand(1,9)].ogg", 20, 0.1)

	deagle
		icon_state = "medium"
		desc = "An uncomfortably large pistol cartridge."
		New()
			..()
			SPAWN(rand(1, 3))
				playsound(src.loc, "sound/weapons/casings/casing-0[rand(1,9)].ogg", 20, 0.1, 0, 0.9)
	shotgun
		red
			icon_state = "shotgun_red"
			desc = "A red shotgun shell."

		blue
			icon_state = "shotgun_blue"
			desc = "A blue shotgun shell."

		orange
			icon_state = "shotgun_orange"
			desc = "An orange shotgun shell."

		gray
			icon_state = "shotgun_gray"
			desc = "A gray shotgun shell."

		pipe
			icon_state = "shotgun_pipe"
			desc = "A slightly scorched length of pipe with an open end."
		New()
			..()
			SPAWN(rand(4, 7))
				playsound(src.loc, "sound/weapons/casings/casing-shell-0[rand(1,7)].ogg", 20, 0.1)

	cannon
		icon_state = "rifle"
		desc = "A cannon shell."
		w_class = W_CLASS_SMALL
		New()
			..()
			SPAWN(rand(2, 4))
				playsound(src.loc, "sound/weapons/casings/casing-large-0[rand(1,4)].ogg", 35, 0.1, 0, 0.8)

	grenade
		w_class = W_CLASS_SMALL
		icon_state = "40mm"
		desc = "A 40mm grenade round casing. Huh."
		New()
			..()
			SPAWN(rand(3, 6))
				playsound(src.loc, "sound/weapons/casings/casing-xl-0[rand(1,6)].ogg", 15, 0.1)


/obj/item/casing/New(loc, obj/item/firearm/firearm)
	. = ..()
	src.pixel_y += rand(-12,12)
	src.pixel_x += rand(-12,12)
	src.set_dir(pick(alldirs))
	if(firearm)
		src.forensic_ID = firearm.forensic_ID
		//Only include the default name of the gun, some special names set randomly in new are confusing and labels shouldnt be readable
		src.fired_by = initial(firearm.name)

/obj/item/casing/get_desc(dist, mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(src.fired_by && istype(H) && H.traitHolder.hasTrait("training_forensic"))
		. += SPAN_NOTICE("<br>Your forensic intuition tells you it was fired by \an [src.fired_by].")
