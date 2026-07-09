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

///Crossbow that fires irradiating neutron projectiles like the nuclear reactor
///DEBUG ITEM - don't actually use this for things. Unless you really want to, or it might be funny.
TYPEINFO(/obj/item/firearm/energy/radiological/neutron)
	analyser_flags = parent_type::analyser_flags | ANALYSER_SYNDIE_ONLY

/obj/item/firearm/energy/radiological/neutron
	name = "mini neutron-crossbow"
	desc = "A weapon that fires irradiating neutrons. Because it makes sense that a crossbow can fire subatomic particles at relativistic speeds."
	icon_state = "crossbow"
	w_class = W_CLASS_SMALL
	item_state = "crossbow"
	force = 4
	throw_speed = 3
	throw_range = 10
	rechargeable = 0 // Cannot be recharged manually.
	cell_type = /obj/item/ammo/power_cell/self_charging/slowcharge
	from_frame_cell_type = /obj/item/ammo/power_cell/self_charging/slowcharge
	projectiles = null
	silenced = 1
	custom_cell_max_capacity = 100

	New()
		set_current_projectile(new/datum/projectile/neutron(50))
		projectiles = list(current_projectile)
		..()
