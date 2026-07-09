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

///////////////////////////////////////////////////resonator
/obj/item/firearm/energy/resonator
	name = "Resonator"
	cell_type = /obj/item/ammo/power_cell/siren_orb
	icon = 'icons/obj/items/guns/energy.dmi'
	icon_state = "resonator"
	desc = "The combination of the creature's excess energy and the cultist's artifact has created a proficient weapon utilising the creature's innate vibration energy."
	item_state = "resonator"
	charge_icon_state = "resonator"
	can_swap_cell = 0
	force = 10
	two_handed = TRUE
	uses_charge_overlay = TRUE
	camera_recoil_enabled = TRUE
	abilities = list(/obj/ability_button/toggle_scope)

	New()
		set_current_projectile(new/datum/projectile/special/piercing/resonator)
		projectiles = list(new/datum/projectile/special/piercing/resonator)
		AddComponent(/datum/component/holdertargeting/windup, 1 SECOND)
		AddComponent(/datum/component/holdertargeting/sniper_scope, 8, 0, /datum/overlayComposition/sniper_scope/resonator, 'sound/machines/found.ogg')
		..()
