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

//////////////////////// Taser Shotgun
//Azungar's Improved, more beefy weapon for security that can only be acquired via QM.
/obj/item/firearm/energy/tasershotgun
	name = "taser shotgun"
	icon_state = "tasershotgun"
	desc = "The Five Points Armory Taser Mk.II, a shotgun-format weapon that produces a spreading electrical charge to stuns its targets."
	item_state = "tasers"
	cell_type = /obj/item/ammo/power_cell/med_power
	force = 12
	two_handed = 1
	can_dual_wield = 0
	shoot_delay = 6 DECI SECONDS
	muzzle_flash = "muzzle_flash_elec"
	uses_charge_overlay = TRUE
	charge_icon_state = "tasershotgun"

	New()
		set_current_projectile(new/datum/projectile/special/spreader/tasershotgunspread)
		projectiles = list(current_projectile,new/datum/projectile/energy_bolt/tasershotgunslug)
		..()
