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

////////////////////////////////////TASERGUN
/obj/item/firearm/energy/taser_gun
	name = "taser gun"
	icon_state = "taser"
	item_state = "taser"
	force = 1
	cell_type = /obj/item/ammo/power_cell/med_power
	desc = "The Five Points Armory Taser Mk.I, a weapon that produces a cohesive electrical charge to stun and subdue its target."
	muzzle_flash = "muzzle_flash_elec"
	uses_charge_overlay = TRUE
	charge_icon_state = "taser"

	New()
		set_current_projectile(new/datum/projectile/energy_bolt)
		projectiles = list(current_projectile)
		..()

	borg
		cell_type = /obj/item/ammo/power_cell/self_charging/disruptor

/obj/item/firearm/energy/taser_gun/bouncy
	name = "richochet taser gun"
	desc = "A modified Five Points Armory taser gun. This one appears to be capable of firing ricochet stun charges."

	New()
		..()
		set_current_projectile(new/datum/projectile/energy_bolt/bouncy)
		projectiles = list(current_projectile)////////////////////////////////////TASERGUN
/obj/item/firearm/energy/taser_gun
	name = "taser gun"
	icon_state = "taser"
	item_state = "taser"
	force = 1
	cell_type = /obj/item/ammo/power_cell/med_power
	desc = "The Five Points Armory Taser Mk.I, a weapon that produces a cohesive electrical charge to stun and subdue its target."
	muzzle_flash = "muzzle_flash_elec"
	uses_charge_overlay = TRUE
	charge_icon_state = "taser"

	New()
		set_current_projectile(new/datum/projectile/energy_bolt)
		projectiles = list(current_projectile)
		..()

	borg
		cell_type = /obj/item/ammo/power_cell/self_charging/disruptor

/obj/item/firearm/energy/taser_gun/bouncy
	name = "richochet taser gun"
	desc = "A modified Five Points Armory taser gun. This one appears to be capable of firing ricochet stun charges."

	New()
		..()
		set_current_projectile(new/datum/projectile/energy_bolt/bouncy)
		projectiles = list(current_projectile)
