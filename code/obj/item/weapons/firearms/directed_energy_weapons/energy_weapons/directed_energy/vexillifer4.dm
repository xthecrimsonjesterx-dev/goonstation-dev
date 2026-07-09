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

TYPEINFO(/obj/item/firearm/energy/vexillifer4)
	mats = list("iridiumalloy" = 50,
				"starstone" = 10,
				"metal_superdense" = 150,
				"crystal_dense" = 100,
				"conductive_high" = 100,
				"energy_extreme" = 50)

/obj/item/firearm/energy/vexillifer4
	name = "Vexillifer IV"
	desc = "It's a cannon? A laser gun? You can't tell."
	icon = 'icons/obj/items/guns/energy64x32.dmi'
	icon_state = "lasercannon"
	item_state = "vexillifer"
	wear_state = "vexillifer"
	var/active_state = "lasercannon"
	var/collapsed_state = "lasercannon-empty"
	var/state = TRUE
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = MELEE_DMG_LARGE
	camera_recoil_enabled = TRUE
	recoil_strength = 20


	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = EQUIPPED_WHILE_HELD | ONBACK

	can_dual_wield = 0
	two_handed = 1
	w_class = W_CLASS_BULKY
	muzzle_flash = "muzzle_flash_bluezap"
	cell_type = /obj/item/ammo/power_cell/self_charging/mediumbig
	shoot_delay = 0.8 SECONDS

	New()
		set_current_projectile(new/datum/projectile/laser/ntso_cannon)
		AddComponent(/datum/component/holdertargeting/windup, 2 SECOND)
		..()

	attack_self(mob/user)
		. = ..()
		src.swap_state()

	proc/swap_state()
		if(state)
			RemoveComponentsOfType(/datum/component/holdertargeting/windup)
			src.icon_state = collapsed_state
			w_class = W_CLASS_NORMAL
		else
			AddComponent(/datum/component/holdertargeting/windup, 2 SECOND)
			src.icon_state = active_state
			w_class = W_CLASS_BULKY
		state = !state

	canshoot(mob/user)
		. = ..() && state

	setupProperties()
		..()
		setProperty("carried_movespeed", 0.3)

	flashy
		active_state = "lasercannon-anim"
		icon_state = "lasercannon-anim"

		shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
			if(src.canshoot(user))
				FLICK("lasercannon-fire", src)
			. = ..()
