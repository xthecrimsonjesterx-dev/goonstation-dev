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

/obj/item/firearm/energy/lasergat
	name = "\improper HAFGAN Mod.93R Repeating Laser"
	rechargeable = 0
	icon_state = "burst_laser_idle"
	cell_type = /obj/item/ammo/power_cell/lasergat
	desc = "Introduced to compete with the Clock line of military sidearms. The Mod. 93R repeating laser masked early laser tech's heat problems with expendable liquid coolant cartridges, whose off-gassing caused unpredictable recoil that made it widely unpopular."
	item_state = "egun-kill"
	force = 5
	add_residue = 1 // this is unique in that it spews energy-gun-gas or something
	muzzle_flash = "muzzle_flash_elec"
	uses_charge_overlay = TRUE
	charge_icon_state = "burst_laser"
	shoot_delay = 4
	spread_angle = 2
	recoil_enabled = TRUE
	recoil_max = 50
	recoil_inaccuracy_max = 10
	icon_recoil_enabled = TRUE

	restrict_cell_type = /obj/item/ammo/power_cell/lasergat
	New()
		set_current_projectile(new/datum/projectile/laser/lasergat/burst)
		projectiles = list(current_projectile)
		..()
	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (canshoot(user))
			..()
			FLICK("burst_laser", src)
			FLICK(src.charge_image, src.charge_image)
			SPAWN(6 DECI SECONDS)
				playsound(user, 'sound/effects/tinyhiss.ogg', 60, TRUE)
			return
		..()

	update_icon()
		if (!canshoot())
			src.icon_state = "burst_laser_empty"
		else
			src.icon_state = "burst_laser_idle"
		..()
	attack_self(var/mob/M)
		..()
		UpdateIcon()
		M.update_inhands()
