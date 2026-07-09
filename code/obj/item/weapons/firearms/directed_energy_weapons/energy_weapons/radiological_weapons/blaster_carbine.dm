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

/obj/item/firearm/energy/radiological/blaster_carbine
	name = "GRF Zap-Karabiner"
	desc = "A blaster carbine from Giesel Radiofabrik, designed for longer range engagements. It's self-charging by a radioactive power cell. Beware of Bremsstrahulung backscatter."
	icon = 'icons/obj/items/guns/energy48x32.dmi'
	icon_state = "blaster-carbine"
	charge_icon_state = "blaster-carbine"
	item_state = "rifle"
	uses_charge_overlay = TRUE
	can_dual_wield = FALSE
	two_handed = TRUE
	w_class = W_CLASS_BULKY
	force = MELEE_DMG_RIFLE
	cell_type = /obj/item/ammo/power_cell/self_charging/medium
	rarity = 4
	shoot_delay = 4
	muzzle_flash = "muzzle_flash_bluezap"

	New()
		set_current_projectile(new /datum/projectile/laser/blaster/carbine)
		projectiles = list(current_projectile)
		..()
