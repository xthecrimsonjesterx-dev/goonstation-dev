////////////////////////////////////////// Radiological weapons child //////////////////////////////////////////////////
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

TYPEINFO(/obj/item/firearm/energy/radiological/blaster_smg)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/firearm/energy/radiological/blaster_smg
	name = "GRF Zap-Maschine"
	desc = "A special issue particle blaster from Giesel Radiofabrik, designed for burst fire. It's self-charging by a radioactive power cell. Beware of Bremsstrahlung backscatter."
	icon = 'icons/obj/items/guns/energy.dmi'
	icon_state = "smg"
	charge_icon_state = "smg"
	uses_charge_overlay = TRUE
	can_dual_wield = FALSE
	w_class = W_CLASS_NORMAL
	force = MELEE_DMG_PISTOL
	cell_type = /obj/item/ammo/power_cell/self_charging/medium
	rarity = 4
	spread_angle = 10
	muzzle_flash = "muzzle_flash_bluezap"

	New()
		set_current_projectile(new /datum/projectile/laser/blaster/burst)
		projectiles = list(current_projectile)
		AddComponent(/datum/component/holdertargeting/fullauto, 1.2)
		..()
