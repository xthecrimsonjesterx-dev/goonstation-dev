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

///////////////////////////////////////Wasp Crossbow
TYPEINFO(/obj/item/firearm/energy/wasp)
	analyser_flags = parent_type::analyser_flags | ANALYSER_SYNDIE_ONLY
	mats = list("metal" = 5,
				"conductive_high" = 5,
				"energy_high" = 10)

/obj/item/firearm/energy/wasp
	name = "mini wasp-egg-crossbow"
	desc = "A weapon favored by many of the syndicate's stealth apiarists, which does damage over time using swarms of angry wasps. Utilizes a self-recharging atomic power cell to synthesize more wasp eggs. Somehow."
	icon_state = "crossbow" //placeholder, would prefer a custom wasp themed icon
	w_class = W_CLASS_SMALL
	item_state = "crossbow" //ditto
	force = 4
	throw_speed = 3
	throw_range = 10
	rechargeable = 0 // Cannot be recharged manually.
	cell_type = /obj/item/ammo/power_cell/self_charging/slowcharge
	from_frame_cell_type = /obj/item/ammo/power_cell/self_charging/slowcharge
	projectiles = null
	silenced = 1
	custom_cell_max_capacity = 100

	New()
		set_current_projectile(new/datum/projectile/special/spreader/quadwasp)
		projectiles = list(current_projectile)
		..()
