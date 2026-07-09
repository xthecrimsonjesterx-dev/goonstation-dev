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

////////////////////////////////////Wave Gun
/obj/item/firearm/energy/wavegun
	name = "\improper Sancai wave gun"
	desc = "The versatile XIANG|GIESEL model '三�' with three nonlethal functions: inverse '炎�', transverse '地皇' and reflective '天皇' ."
	icon_state = "wavegun"
	item_state = "wave"
	cell_type = /obj/item/ammo/power_cell/med_power
	m_amt = 4000
	force = 6
	muzzle_flash = "muzzle_flash_wavep"
	uses_charge_overlay = TRUE
	charge_icon_state = "wavegun"

	New()
		set_current_projectile(new/datum/projectile/wavegun)
		projectiles = list(current_projectile,new/datum/projectile/wavegun/transverse,new/datum/projectile/wavegun/bouncy)
		..()

	// Old phasers aren't around anymore, so the wave gun might as well use their better sprite (Convair880).
	// Flaborized has made a lovely new wavegun sprite! - Gannets
	// Flaborized has made even more wavegun sprites!

	update_icon()
		if (current_projectile.type == /datum/projectile/wavegun)
			charge_icon_state = "[icon_state]"
			muzzle_flash = "muzzle_flash_wavep"
			item_state = "wave"
		else if (current_projectile.type == /datum/projectile/wavegun/transverse)
			charge_icon_state = "[icon_state]_green"
			muzzle_flash = "muzzle_flash_waveg"
			item_state = "wave-g"
		else
			charge_icon_state = "[icon_state]_emp"
			muzzle_flash = "muzzle_flash_waveb"
			item_state = "wave-emp"
		..()
	attack_self(mob/user as mob)
		..()
		UpdateIcon()
		user.update_inhands()
