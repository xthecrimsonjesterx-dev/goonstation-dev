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

///////////////////////////////////////Ghost Gun
TYPEINFO(/obj/item/firearm/energy/ghost)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/firearm/energy/ghost
	name = "ectoplasmic destabilizer"
	desc = "If this had streams, it would be inadvisable to cross them. But no, it fires bolts instead.  Don't throw it into a stream, I guess?"
	icon_state = "ghost"
	w_class = W_CLASS_NORMAL
	item_state = "gun"
	force = 10
	throw_speed = 2
	throw_range = 10
	cell_type = /obj/item/ammo/power_cell/med_power
	muzzle_flash = "muzzle_flash_waveg"
	uses_charge_overlay = TRUE
	charge_icon_state = "ghost"

	New()
		set_current_projectile(new /datum/projectile/energy_bolt_antighost)
		projectiles = list(current_projectile)
		..()
