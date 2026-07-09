////////////////////////////////////////// Directed energy weapon child //////////////////////////////////////////////////
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

/////////////////////////////////////// Pickpocket Grapple, Grayshift's grif gun
TYPEINFO(/obj/item/firearm/energy/pickpocket)
	analyser_flags = parent_type::analyser_flags | ANALYSER_SYNDIE_ONLY
	mats = list("metal" = 5,
				"conductive_high" = 5,
				"energy_high" = 10)
/obj/item/firearm/energy/pickpocket
	name = "\improper Super! Grapple Friend" // like foam dart guns
	desc = "A complicated, camoflaged claw device on a tether capable of complex and stealthy interactions. It's definitely not just a repurposed janky toy that steals shit."
	icon_state = "pickpocket"
	w_class = W_CLASS_SMALL
	item_state = "pickpocket"
	force = 4
	throw_speed = 3
	throw_range = 10
	rechargeable = 0 // Cannot be recharged manually.
	cell_type = /obj/item/ammo/power_cell/self_charging/slowcharge
	from_frame_cell_type = /obj/item/ammo/power_cell/self_charging/slowcharge
	projectiles = null
	silenced = 1
	hide_attack = ATTACK_FULLY_HIDDEN
	custom_cell_max_capacity = 100
	var/obj/item/heldItem = null
	tooltip_flags = REBUILD_DIST
	HELP_MESSAGE_OVERRIDE({"Use the pickpocket gun in hand to alternate between three fire modes : <b>Steal</b>, <b>Plant</b> and <b>Harass</b>.\n
							To remove an item from the pickpocket gun, hold the gun in one hand, then use your other hand on it.\n
							To place an item into the pickpocket gun, hold the gun in one hand, then hit it with an item in your other hand.\n
							While on <b>Steal</b>, the gun will attempt to steal the item of the target who's body part you are aiming at.\n
							While on <b>Plant</b>, the gun will attempt to place an item on the target on the body part you are aiming at.\n
							While on <b>Harass</b>, the gun will perform a debilitating effect on the target depending on the body part you are aiming at."})

	New()
		set_current_projectile(new/datum/projectile/pickpocket/steal)
		projectiles = list(current_projectile, new/datum/projectile/pickpocket/plant, new/datum/projectile/pickpocket/harass)
		..()

	get_desc(dist)
		..()
		if (dist < 1) // on our tile or our person
			if (.) // we're returning something
				. += " " // add a space
			if (src.heldItem)
				. += "It's currently holding \a [src.heldItem]."
			else
				. += "It's not holding anything."

	attack_hand(mob/user)
		if (src.loc == user && (src == user.l_hand || src == user.r_hand))
			if (heldItem)
				boutput(user, "You remove \the [heldItem.name] from the gun.")
				user.put_in_hand_or_drop(heldItem)
				heldItem = null
				tooltip_rebuild = TRUE
			else
				boutput(user, "The gun does not contain anything.")
		else
			return ..()

	attackby(obj/item/I, mob/user)
		if (I.cant_drop) return
		if (heldItem)
			boutput(user, "The gun is already holding [heldItem.name].")
		else
			heldItem = I
			user.u_equip(I)
			I.dropped(user)
			boutput(user, "You insert \the [heldItem.name] into the gun's gripper.")
			tooltip_rebuild = TRUE
		return ..()

	attack(mob/target, mob/user, def_zone, is_special = FALSE, params = null)
		if (istype(current_projectile, /datum/projectile/pickpocket/steal) && heldItem)
			boutput(user, "Cannot steal while gun is holding something!")
			return
		if (istype(current_projectile, /datum/projectile/pickpocket/plant) && !heldItem)
			boutput(user, "Cannot plant item if gun is not holding anything!")
			return

		var/datum/projectile/pickpocket/shot = current_projectile
		shot.linkedGun = src
		shot.firer = user.key
		shot.targetZone = user.zone_sel.selecting
		var/turf/us = get_turf(src)
		if(isrestrictedz(us.z) && !in_shuttle_transit(us))
			boutput(user, "\The [src.name] jams!")
			return
		return ..(target, user)

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (istype(current_projectile, /datum/projectile/pickpocket/steal) && heldItem)
			boutput(user, "Cannot steal items while gun is holding something!")
			return
		if (istype(current_projectile, /datum/projectile/pickpocket/plant) && !heldItem)
			boutput(user, "Cannot plant item if gun is not holding anything!")
			return

		var/turf/us = get_turf(src)
		if (isrestrictedz(us.z) && !in_shuttle_transit(us))
			boutput(user, "\The [src.name] jams!")
			message_admins("[key_name(user)] is a nerd and tried to fire a pickpocket gun in a restricted z-level at [log_loc(us)].")
			return


		var/datum/projectile/pickpocket/shot = current_projectile
		shot.linkedGun = src
		shot.targetZone = user.zone_sel.selecting
		shot.firer = user.key
		return ..(target, start, user)

/obj/item/firearm/energy/pickpocket/testing // has a beefier cell in it
	cell_type = /obj/item/ammo/power_cell/self_charging/big
