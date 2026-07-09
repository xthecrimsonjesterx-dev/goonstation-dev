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

//////////////////////////////////////Crabgun
TYPEINFO(/obj/item/firearm/energy/crabgun)
	analyser_flags = parent_type::analyser_flags | ANALYSER_SYNDIE_ONLY

/obj/item/firearm/energy/crabgun
	name = "a strange crab"
	desc = "Years of extreme genetic tinkering have finally led to the feared combination of crab and gun."
	icon = 'icons/obj/crabgun.dmi'
	icon_state = "crabgun"
	item_state = "crabgun-world"
	inhand_image_icon = 'icons/obj/crabgun.dmi'
	w_class = W_CLASS_BULKY
	force = 12
	throw_speed = 8
	throw_range = 12
	rechargeable = 0
	cell_type = /obj/item/ammo/power_cell/self_charging/slowcharge
	from_frame_cell_type = /obj/item/ammo/power_cell/self_charging/slowcharge
	projectiles = null
	custom_cell_max_capacity = 100 //endless crab

	New()
		set_current_projectile(new/datum/projectile/claw)
		projectiles = list(current_projectile)
		..()

	attackby(obj/item/b, mob/user)
		if(istype(b, /obj/item/ammo/power_cell))
			boutput(user, SPAN_ALERT("You attempt to swap the cell but \the [src] bites you instead."))
			playsound(src.loc, 'sound/impact_sounds/Flesh_Stab_1.ogg', 50, 1, -6)
			user.TakeDamage(user.zone_sel.selecting, 3, 0)
			take_bleeding_damage(user, user, 3, DAMAGE_CUT)
			return
		. = ..()
