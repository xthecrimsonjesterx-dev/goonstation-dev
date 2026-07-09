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

///////////////////////////////////////Glitch Gun
/obj/item/firearm/energy/glitch_gun
	name = "glitch gun"
	desc = "It's humming with some sort of disturbing energy. Do you really wanna hold this?"
	icon = 'icons/obj/items/guns/toy.dmi'
	icon_state = "airzooka"
	m_amt = 4000
	force = 0
	cell_type = /obj/item/ammo/power_cell/high_power

	New()
		set_current_projectile(new/datum/projectile/bullet/glitch/gun)
		projectiles = list(new/datum/projectile/bullet/glitch/gun)
		..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (canshoot(user)) // No more attack messages for empty guns (Convair880).
			playsound(user, 'sound/weapons/DSBFG.ogg', 75)
			sleep(0.1 SECONDS)
		return ..(target, start, user)
