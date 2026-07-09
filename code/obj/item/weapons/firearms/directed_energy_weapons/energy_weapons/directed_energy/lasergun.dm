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

/////////////////////////////////////LASERGUN
/obj/item/firearm/energy/laser_gun
	name = "laser gun"
	icon_state = "laser"
	item_state = "laser"
	cell_type = /obj/item/ammo/power_cell/med_plus_power
	force = 7
	desc = "The venerable Hafgan Mod.28 laser gun, causes substantial damage in close quarters and space environments. Not suitable for use in dust storms."
	muzzle_flash = "muzzle_flash_laser"
	uses_charge_overlay = TRUE
	charge_icon_state = "laser"

	New()
		set_current_projectile(new/datum/projectile/laser)
		projectiles = list(current_projectile)
		..()

	virtual
		icon = 'icons/effects/VR.dmi'
		New()
			..()
			set_current_projectile(new /datum/projectile/laser/virtual)
			projectiles.len = 0
			projectiles += current_projectile
