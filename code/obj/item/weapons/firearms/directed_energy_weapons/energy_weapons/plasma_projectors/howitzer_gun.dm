////////////////////////////////////////// Plasma projectors child //////////////////////////////////////////////////
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

// HOWIZTER GUN
// dumb meme admin item. not remotely fair, will probably kill person firing it.
/obj/item/firearm/energy/plasma/howitzer
	name = "man-portable plasma howitzer"
	desc = "How can you even lift this?"
	icon_state = "bfg"
	force = 25
	two_handed = 1
	can_dual_wield = 0
	cell_type = /obj/item/ammo/power_cell/self_charging/howitzer
	camera_recoil_enabled = TRUE
	recoil_strength = 50

	New()
		..()
		set_current_projectile(new/datum/projectile/special/howitzer)
		projectiles = list(new/datum/projectile/special/howitzer )

TYPEINFO(/obj/item/firearm/energy/plasma/optio1)
	mats = list("iridiumalloy" = 30,
				"plutonium" = 15,
				"electrum" = 25)
