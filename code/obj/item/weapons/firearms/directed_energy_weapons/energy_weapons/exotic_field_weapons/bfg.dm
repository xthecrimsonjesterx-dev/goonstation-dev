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

////////////////////////////////////BFG
/obj/item/firearm/energy/bfg
	name = "\improper BFG 9000"
	icon_state = "bfg"
	m_amt = 4000
	force = 6
	desc = "I think it stands for Banned For Griefing?"
	cell_type = /obj/item/ammo/power_cell/high_power
	recoil_strength = 20
	camera_recoil_enabled = TRUE

	New()
		set_current_projectile(new/datum/projectile/bfg)
		projectiles = list(new/datum/projectile/bfg)
		..()

	update_icon()
		..()
		return

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (canshoot(user)) // No more attack messages for empty guns (Convair880).
			playsound(user, 'sound/weapons/DSBFG.ogg', 75)
			sleep(0.9 SECONDS)
		return ..(target, start, user)

/obj/item/firearm/energy/bfg/vr
	icon = 'icons/effects/VR.dmi'
