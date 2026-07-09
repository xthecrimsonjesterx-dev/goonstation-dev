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

//////////////////////// Alastor

TYPEINFO(/obj/item/firearm/energy/alastor)
	analyser_flags = parent_type::analyser_flags | ANALYSER_SYNDIE_ONLY
	mats = list("metal_dense" = 15,
				"conductive_high" = 10,
				"energy_high" = 10)
/obj/item/firearm/energy/alastor
	name = "\improper Alastor pattern laser rifle"
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi'
	icon_state = "alastor100"
	item_state = "alastor"
	icon = 'icons/obj/large/38x38.dmi'
	force = 7
	can_dual_wield = 0
	two_handed = 1
	cell_type = /obj/item/ammo/power_cell/med_power
	desc = "A gun that produces a harmful laser, causing substantial damage."
	muzzle_flash = "muzzle_flash_laser"

	New()
		set_current_projectile(new/datum/projectile/laser/alastor)
		projectiles = list(current_projectile)
		..()

	update_icon()
		..()
		var/list/ret = list()
		if(SEND_SIGNAL(src, COMSIG_CELL_CHECK_CHARGE, ret) & CELL_RETURNED_LIST)
			var/ratio = min(1, ret["charge"] / ret["max_charge"])
			ratio = round(ratio, 0.25) * 100
			src.icon_state = "alastor[ratio]"
			return
