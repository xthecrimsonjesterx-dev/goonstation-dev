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

/obj/item/firearm/energy/cornicen3
	name = "\improper Cornicen III"
	desc = "Formal enough for the boardroom. Rugged enough for the battlefield."
	icon = 'icons/obj/items/guns/energy48x32.dmi'
	muzzle_flash = "muzzle_flash_bluezap"
	icon_state = "cornicen_close"
	item_state = "ntgun2"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags =  TABLEPASS | CONDUCT | USEDELAY
	c_flags = ONBACK
	w_class = W_CLASS_NORMAL		//for clarity
	two_handed = TRUE
	force = 9
	cell_type = /obj/item/ammo/power_cell/self_charging/big
	from_frame_cell_type = /obj/item/ammo/power_cell/self_charging/mediumbig
	can_swap_cell = 0
	rechargeable = 0
	shoot_delay = 8 DECI SECONDS
	spread_angle = 3
	can_dual_wield = 0
	var/extended = FALSE

	New()
		set_current_projectile(new/datum/projectile/laser/plasma/auto)
		projectiles = list(current_projectile,new/datum/projectile/laser/plasma/burst)
		AddComponent(/datum/component/holdertargeting/fullauto, 1.5)
		..()

	update_icon()
		..()
		if(!src.extended)
			src.icon_state = "cornicen_close"
			src.item_state = "cornicen"
			src.w_class = W_CLASS_NORMAL
			src.spread_angle = initial(src.spread_angle)
		else
			src.icon_state = "cornicen_ext"
			src.item_state = "cornicen_ext"
			src.w_class = W_CLASS_BULKY
			src.spread_angle = 0

	attack_self(var/mob/M)
		..()
		src.extended = !src.extended
		UpdateIcon()
		if(src.extended)
			FLICK("cornicen_open", src)
		M.update_inhands()
