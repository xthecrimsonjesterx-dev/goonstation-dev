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

//////////////////////////////////////// Phaser
/obj/item/firearm/energy/phaser_gun
	name = "RP-4 phaser gun"
	icon_state = "phaser"
	item_state = "phaser"
	force = 7
	desc = "An amplified carbon-arc weapon designed by Radnor Photonics. Popular among frontier adventurers and explorers."
	muzzle_flash = "muzzle_flash_phaser"
	cell_type = /obj/item/ammo/power_cell/med_power
	uses_charge_overlay = TRUE
	charge_icon_state = "phaser"

	New()
		set_current_projectile(new/datum/projectile/laser/light)
		projectiles = list(current_projectile)
		..()

/obj/item/firearm/energy/phaser_gun/extended_mag
	cell_type = /obj/item/ammo/power_cell/med_plus_power

TYPEINFO(/obj/item/firearm/energy/phaser_small)
	mats = 20

/obj/item/firearm/energy/phaser_small
	name = "RP-3 micro phaser"
	icon_state = "phaser-tiny"
	item_state = "phaser"
	force = 4
	desc = "A diminutive carbon-arc sidearm produced by Radnor Photonics. It's not much, but it might just save your life."
	muzzle_flash = "muzzle_flash_phaser"
	cell_type = /obj/item/ammo/power_cell
	w_class = W_CLASS_SMALL
	uses_charge_overlay = TRUE
	charge_icon_state = "phaser-tiny"

	New()
		set_current_projectile(new/datum/projectile/laser/light/tiny)
		projectiles = list(current_projectile)
		..()

TYPEINFO(/obj/item/firearm/energy/phaser_huge)
	mats = list("metal" = 15,
				"metal_dense" = 10,
				"conductive_high" = 10,
				"energy_high" = 15,
				"crystal" = 10)
/obj/item/firearm/energy/phaser_huge
	name = "RP-5 macro phaser"
	icon_state = "phaser-xl"
	item_state = "phaser_xl"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	c_flags = ONBACK
	desc = "The largest amplified carbon-arc weapon from Radnor Photonics. A big gun for big problems."
	muzzle_flash = "muzzle_flash_phaser"
	cell_type = /obj/item/ammo/power_cell/med_plus_power
	shoot_delay = 8
	can_dual_wield = FALSE
	force = MELEE_DMG_RIFLE
	two_handed = 1
	uses_charge_overlay = TRUE
	charge_icon_state = "phaser-xl"

	New()
		set_current_projectile(new/datum/projectile/laser/light/huge) // light/huge - whatev!!!! this should probably be refactored
		projectiles = list(current_projectile)
		AddComponent(/datum/component/holdertargeting/windup, 1 SECOND)
		..()

/obj/item/firearm/energy/phaser_smg
	name = "RP-4S phaser smg"
	icon_state = "phaser-smg"
	item_state = "phaser"
	force = 7
	desc = "An amplified carbon-arc weapon designed by Radnor Photonics, modified to fire in fully automatic mode. Popular among frontier adventurers and explorers."
	muzzle_flash = "muzzle_flash_phaser"
	cell_type = /obj/item/ammo/power_cell/med_power
	uses_charge_overlay = TRUE
	charge_icon_state = "phaser-smg"
	spread_angle = 10

	New()
		set_current_projectile(new/datum/projectile/laser/light/smg)
		projectiles = list(current_projectile)
		AddComponent(/datum/component/holdertargeting/fullauto, 1.2)
		..()

/obj/item/firearm/energy/phaser_smg/extended_mag
	cell_type = /obj/item/ammo/power_cell/med_plus_power
