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

//////////////////////// nanotrasen gun
//Azungar's Nanotrasen inspired Laser Assault Rifle for RP gimmicks
/obj/item/firearm/energy/ntgun
	name = "laser assault rifle"
	icon_state = "nt"
	desc = "Rather futuristic assault rifle with two firing modes."
	item_state = "ntgun"
	force = 10
	contraband = 8
	two_handed = 1
	spread_angle = 6
	cell_type = /obj/item/ammo/power_cell/med_power
	uses_charge_overlay = TRUE
	charge_icon_state = "ntstun"

	New()
		set_current_projectile(new/datum/projectile/energy_bolt/ntburst)
		projectiles = list(current_projectile,new/datum/projectile/laser/ntburst)
		..()

	update_icon()
		if (current_projectile.type == /datum/projectile/energy_bolt/ntburst)
			charge_icon_state = "[icon_state]stun"
		else
			charge_icon_state = "[icon_state]lethal"
		..()
	attack_self()
		..()
		UpdateIcon()
