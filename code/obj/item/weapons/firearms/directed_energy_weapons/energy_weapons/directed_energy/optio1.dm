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

/obj/item/firearm/energy/optio1
	name = "\improper Optio I"
	desc = "It's a laser gun? Or a handgun? Yeah, you're pretty sure it's a handgun."
	w_class = W_CLASS_SMALL
	icon_state = "optio_1"
	item_state = "protopistol"
	cell_type = /obj/item/ammo/power_cell/self_charging/ntso_signifer
	from_frame_cell_type = /obj/item/ammo/power_cell/self_charging/ntso_signifer/bad
	can_swap_cell = 0

	New()
		set_current_projectile(new/datum/projectile/bullet/optio)
		projectiles = list(current_projectile, new/datum/projectile/bullet/optio/hitscan)
		..()
