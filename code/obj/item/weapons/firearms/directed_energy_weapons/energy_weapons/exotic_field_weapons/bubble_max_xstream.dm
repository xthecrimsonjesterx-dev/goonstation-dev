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

///////////////////////////////////////////////////Bubble Max XSTREAM
	name = "Bubble Max XSTREAM"
	icon_state = "phaser-tiny"
	item_state = "phaser"
	force = 4
	desc = "The foremost name in bubble based warfare."
	muzzle_flash = "muzzle_flash_launch"
	cell_type = /obj/item/ammo/power_cell
	w_class = W_CLASS_SMALL
	var/bubble_type = /datum/projectile/special/bubble

	New()
		. = ..()
		color = list(0,0,1,1,0,0,0,1,0)
		set_current_projectile(new bubble_type)
		projectiles = list(current_projectile)

/obj/item/firearm/energy/bubble_gun/bomb
	name = "Bubble Bomb Max ULTRAimpact"
	desc = "Looks to be a modified Bubble Max XSTREAM. There appears to be a warning label on the side, \"Fire at a distance.\""
	var/bubble_type = /datum/projectile/special/bubble/bomb
	shoot_delay = 50

/obj/item/firearm/energy/bubble_gun/bomb/turf_safe
	bubble_type = /datum/projectile/special/bubble/bomb/turf_safe

#undef HEAT_REMOVED_PER_PROCESS
#undef FIRE_THRESHOLD
