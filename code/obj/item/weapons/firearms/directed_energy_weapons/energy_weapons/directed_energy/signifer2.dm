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

TYPEINFO(/obj/item/firearm/energy/signifer2)
	mats = list("energy_high" = 15,
				"conductive_high" = 15,
				"metal_superdense" = 20)

/obj/item/firearm/energy/signifer2
	name = "\improper Signifer II"
	desc = "It's a handgun? Or an smg? You can't tell."
	icon_state = "signifer_2"
	w_class = W_CLASS_NORMAL		//for clarity
	object_flags = NO_ARM_ATTACH
	force = 8
	two_handed = 0
	cell_type = /obj/item/ammo/power_cell/self_charging/ntso_signifer
	from_frame_cell_type = /obj/item/ammo/power_cell/self_charging/ntso_signifer/bad
	can_swap_cell = 0
	var/shotcount = 0

	New()
		set_current_projectile(new/datum/projectile/energy_bolt/signifer_tase)
		projectiles = list(current_projectile,new/datum/projectile/laser/signifer_lethal)
		..()

	update_icon()
		..()
		if(!src.two_handed)// && current_projectile.type == /datum/projectile/energy_bolt)
			src.icon_state = "signifer_2"
			src.item_state = "signifer_2"
			muzzle_flash = "muzzle_flash_elec"
			shoot_delay = 2
			spread_angle = 0
			force = 9
			w_class = W_CLASS_NORMAL
		else //if (current_projectile.type == /datum/projectile/laser)
			src.item_state = "signifer_2-smg"
			src.icon_state = "signifer_2-smg"
			muzzle_flash = "muzzle_flash_bluezap"
			spread_angle = 3
			shoot_delay = 5
			force = 12
			w_class = W_CLASS_BULKY

	attack_self(var/mob/M)
		if (!setTwoHanded(!src.two_handed))
			boutput(M, SPAN_ALERT("You need a free hand to switch modes!"))
			return 0

		..()
		src.can_dual_wield = !src.two_handed
		UpdateIcon()
		M.update_inhands()

	alter_projectile(obj/projectile/P)
		. = ..()
		if(++shotcount == 2 && istype(P.proj_data, /datum/projectile/laser/signifer_lethal/))
			P.proj_data = new/datum/projectile/laser/signifer_lethal/brute

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		shotcount = 0
		. = ..()

	shoot_point_blank(atom/target, mob/user, second_shot)
		shotcount = 0
		. = ..()

TYPEINFO(/obj/item/firearm/energy/cornicen3)
	mats = list("iridiumalloy" = 50,
				"starstone" = 30,
				"plutonium" = 25,
				"electrum" = 50,
				"exoweave" = 5)
