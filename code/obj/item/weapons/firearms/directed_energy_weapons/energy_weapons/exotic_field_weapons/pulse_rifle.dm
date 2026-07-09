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

//0/////////////////////////////////////////////////// Pulse Rifle
// An energy gun that uses the lawbringer's Pulse setting, to beef up the current armory.
/obj/item/firearm/energy/pulse_rifle
	name = "pulse rifle"
	desc = "A sleek energy rifle with two different pulse settings: Kinetic and Electromagnetic."
	icon_state = "pulse_rifle"
	item_state = "pulse_rifle"
	force = 5
	two_handed = 1
	can_dual_wield = 0
	muzzle_flash = "muzzle_flash_bluezap"
	cell_type = /obj/item/ammo/power_cell/high_power //300 PU
	uses_charge_overlay = TRUE
	charge_icon_state = "pulse_rifle"

	New()
		..()
		set_current_projectile(new/datum/projectile/energy_bolt/pulse)//uses 35PU per shot, so 8 shots
		projectiles = list(new/datum/projectile/energy_bolt/pulse, new/datum/projectile/energy_bolt/electromagnetic_pulse)
