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

/obj/item/firearm/energy/radiological/blaster_cannon
	name = "GRF Zap-Kanone"
	desc = "A heavy particle blaster from Giesel Radiofabrik, designed for high damage. It's self-charging by a larger radioactive power cell. Beware of Bremsstrahlung backscatter."
	icon = 'icons/obj/items/guns/energy.dmi'
	icon_state = "cannon"
	charge_icon_state = "cannon"
	item_state = "rifle"
	uses_charge_overlay = TRUE
	can_dual_wield = FALSE
	two_handed = TRUE
	w_class = W_CLASS_BULKY
	force = MELEE_DMG_RIFLE
	shoot_delay = 8
	cell_type = /obj/item/ammo/power_cell/self_charging/big
	rarity = 5
	muzzle_flash = "muzzle_flash_bluezap"
	recoil_strength = 20
	camera_recoil_enabled = TRUE

	New()
		set_current_projectile(new /datum/projectile/laser/blaster/cannon)
		projectiles = list(current_projectile)
		c_flags |= ONBACK
		AddComponent(/datum/component/holdertargeting/windup, 1 SECOND)
		..()

///////////modular components - putting them here so it's easier to work on for now////////
/*
TYPEINFO(/obj/item/gun_parts)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/gun_parts
	name = "gun parts"
	desc = "Components for building custom sidearms."
	item_state = "table_parts"
	inhand_image_icon = 'icons/mob/inhand/hand_tools.dmi'
	icon = 'icons/obj/items/gun_mod.dmi'
	icon_state = "frame" // todo: make more item icons

/obj/item/gun_parts/emitter
	name = "optical pulse emitter"
	desc = "Generates a pulsed burst of energy."
	icon_state = "emitter"
	var/datum/projectile/laser/light/projectile = new/datum/projectile/laser/light
	var/obj/item/device/flash/flash = new/obj/item/device/flash
	//use flash as the core of the device

	// inherit material vars from the flash

/obj/item/gun_parts/back
	name = "phaser stock"
	desc = "A gun stock for a modular phaser. Does this even do anything? Probably not."
	icon_state = "mod-stock"

/obj/item/gun_parts/top_rail
	name = "phaser pulse modifier"
	desc = "Modifies the beam path of modular phaser."
	icon_state = "mod-range"

	range
		name = "beam collimator"
		icon_state = "mod-range"

	width
		name = "beam spreader"
		icon_state = "mod-aoe"

/obj/item/gun_parts/bottom_rail
	name = "Phaser accessory"

	sight
		name = "phaser dot accessory"
		icon_state = "mod-sight"
		// idk what the hell this would even do

	flashlight
		name = "phaser flashlight accessory"
		icon_state = "mod-flashlight"

	heatsink
		name = "phaser heatsink"
		icon_state = "mod-heatsink"

	grip // tacticool
		name = "fore grip"
		icon_state = "mod-grip" */
