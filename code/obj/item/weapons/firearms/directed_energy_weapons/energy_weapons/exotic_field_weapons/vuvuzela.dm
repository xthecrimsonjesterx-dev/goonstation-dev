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

////////////////////////////////////VUVUV
TYPEINFO(/obj/item/firearm/energy/vuvuzela_gun)
	analyser_flags = parent_type::analyser_flags | ANALYSER_SYNDIE_ONLY
	mats = list("metal" = 5,
				"conductive_high" = 5,
				"energy_high" = 10)

/obj/item/firearm/energy/vuvuzela_gun
	name = "amplified vuvuzela"
	icon_state = "vuvuzela"
	item_state = "bike_horn"
	desc = "BZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZT, *fart*"
	cell_type = /obj/item/ammo/power_cell/med_power
	uses_charge_overlay = TRUE
	charge_icon_state = "vuvuzela"

	New()
		set_current_projectile(new/datum/projectile/energy_bolt_v)
		projectiles = list(current_projectile)
		..()
