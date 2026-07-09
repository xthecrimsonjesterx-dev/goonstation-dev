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

/obj/item/firearm/energy/tasersmg
	name = "taser SMG"
	icon_state = "tasersmg"
	desc = "The Five Points Armory Taser Mk.III. A weapon that produces a cohesive electrical charge to stun its target, capable of firing in two shot burst or full auto configurations."
	item_state = "tsmg"
	force = 5
	two_handed = 1
	can_dual_wield = 0
	cell_type = /obj/item/ammo/power_cell/med_power
	muzzle_flash = "muzzle_flash_elec"
	uses_charge_overlay = TRUE
	charge_icon_state = "tasersmg"

	New()
		set_current_projectile(new/datum/projectile/energy_bolt/smgburst)

		projectiles = list(current_projectile,new/datum/projectile/energy_bolt/smgauto)
		AddComponent(/datum/component/holdertargeting/fullauto, 1.2)
		..()

	update_icon()
		if (current_projectile.type == /datum/projectile/energy_bolt/smgauto)
			charge_icon_state = "[icon_state]_auto"
		else
			charge_icon_state = "[icon_state]_burst"
		..()

	attack_self(mob/user as mob)
		..()
		if (istype(current_projectile, /datum/projectile/energy_bolt/smgauto))
			spread_angle = 8
		else
			spread_angle = 2
		UpdateIcon()
