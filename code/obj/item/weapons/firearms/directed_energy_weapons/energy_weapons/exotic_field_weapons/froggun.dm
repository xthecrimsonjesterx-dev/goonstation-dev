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

///////////////////////////////////////Frog Gun (Shoots :getin: and :getout:)
/obj/item/firearm/energy/frog
	name = "frog gun"
	desc = "It appears to be shivering and croaking in your hand. How creepy." //it must be unhoppy :^)
	icon = 'icons/obj/items/guns/gimmick.dmi'
	icon_state = "frog"
	item_state = "gun"
	m_amt = 1000
	force = 0

	cell_type = /obj/item/ammo/power_cell/self_charging/big //gotta have power for the frog

	New()
		set_current_projectile(new/datum/projectile/bullet/frog)
		projectiles = list(current_projectile,new/datum/projectile/bullet/frog/getout)
		..()
