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

///////////////////////////////////////Telegun
TYPEINFO(/obj/item/firearm/energy/teleport)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/firearm/energy/teleport
	name = "teleport gun"
	desc = "A hacked together combination of a taser gun and a handheld teleportation unit."
	icon_state = "teleport"
	w_class = W_CLASS_NORMAL
	item_state = "gun"
	force = 10
	throw_speed = 2
	throw_range = 10
	cell_type = /obj/item/ammo/power_cell/med_power
	var/obj/item/our_target = null
	var/obj/machinery/computer/teleporter/our_teleporter = null // For checks before firing (Convair880).
	uses_charge_overlay = TRUE
	charge_icon_state = "teleport"
	HELP_MESSAGE_OVERRIDE({"Use the teleport gun in hand to set it's destination. Destination list is pulled from all the currently activated teleporters."})

	New()
		set_current_projectile(new /datum/projectile/tele_bolt)
		projectiles = list(current_projectile)
		..()

	// I overhauled everything down there. Old implementation made the telegun unreliable and crap, to be frank (Convair880).
	attack_self(mob/user as mob)
		src.add_fingerprint(user)

		var/list/L = list()
		L += "None (Cancel)" // So we'll always get a list, even if there's only one teleporter in total.

		for(var/obj/machinery/teleport/portal_generator/PG as anything in machine_registry[MACHINES_PORTALGENERATORS])
			if (!PG.linked_computer || !PG.linked_rings)
				continue
			var/turf/PG_loc = get_turf(PG)
			if (PG && isrestrictedz(PG_loc.z)) // Don't show teleporters in "somewhere", okay.
				continue

			var/obj/machinery/computer/teleporter/Control = PG.linked_computer
			if (Control)
				switch (Control.check_teleporter())
					if (0) // It's busted, Jim.
						continue
					if (1)
						var/index = "Tele at [get_area(Control)]: Locked in ([ismob(Control.locked.loc) ? "[Control.locked.loc.name]" : "[get_area(Control.locked)]"])"
						if (L[index])
							L[dedupe_index(L, index)] = Control
						else
							L[index] = Control
					if (2)
						var/index = "Tele at [get_area(Control)]: *NOPOWER*"
						if (L[index])
							L[dedupe_index(L, index)] = Control
						else
							L[index] = Control
					if (3)
						var/index = "Tele at [get_area(Control)]: Inactive"
						if (L[index])
							L[dedupe_index(L, index)] = Control
						else
							L[index] = Control
			else
				continue

		if (length(L) < 2)
			user.show_text("Error: no working teleporters detected.", "red")
			return

		var/t1 = tgui_input_list(user, "Please select a teleporter to lock in on.", "Target Selection", L)
		if ((user.equipped() != src) || user.stat || user.restrained())
			return
		if (t1 == "None (Cancel)")
			return

		var/obj/machinery/computer/teleporter/Control2 = L[t1]
		if (Control2)
			src.our_teleporter = null
			src.our_target = null
			switch (Control2.check_teleporter())
				if (0)
					user.show_text("Error: selected teleporter is out of order.", "red")
					return
				if (1)
					src.our_target = Control2.locked
					if (!our_target)
						user.show_text("Error: selected teleporter is locked in to invalid coordinates.", "red")
						return
					else
						user.show_text("Teleporter selected. Locked in on [ismob(Control2.locked.loc) ? "[Control2.locked.loc.name]" : "beacon"] in [get_area(Control2.locked)].", "blue")
						src.our_teleporter = Control2
						return
				if (2)
					user.show_text("Error: selected teleporter is unpowered.", "red")
					return
				if (3)
					user.show_text("Error: selected teleporter is not locked in.", "red")
					return
		else
			user.show_text("Error: couldn't establish connection to selected teleporter.", "red")
			return

	attack(mob/target, mob/user, def_zone, is_special = FALSE, params = null)
		if (!src.our_target)
			user.show_text("Error: no target set. Please select a teleporter first.", "red")
			return
		if (!src.our_teleporter || (src.our_teleporter.check_teleporter() != 1))
			user.show_text("Error: linked teleporter is out of order.", "red")
			return

		var/datum/projectile/tele_bolt/TB = current_projectile
		TB.target = our_target
		return ..(target, user)

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (!src.our_target)
			user.show_text("Error: no target set. Please select a teleporter first.", "red")
			return
		if (!src.our_teleporter || (src.our_teleporter.check_teleporter() != 1))
			user.show_text("Error: linked teleporter is out of order.", "red")
			return

		var/datum/projectile/tele_bolt/TB = current_projectile
		TB.target = our_target
		return ..(target, start, user)

	proc/dedupe_index(list/L, index)
		var/index_base = index
		var/i = 2
		while(L[index])
			index = index_base
			index += " [i]"
			i++
		return index
