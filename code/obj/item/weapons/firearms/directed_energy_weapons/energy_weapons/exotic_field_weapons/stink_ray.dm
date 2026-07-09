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

// stinky ray
/obj/item/firearm/energy/stinkray
	name = "stink ray"
	item_state = "gun"
	force = 5
	icon_state = "ghost"
	cell_type = /obj/item/ammo/power_cell/med_power
	uses_charge_overlay = TRUE
	charge_icon_state = "ghost"

	New()
		set_current_projectile(new/datum/projectile/bioeffect_beam/stinky)
		projectiles = list(current_projectile)
		..()
