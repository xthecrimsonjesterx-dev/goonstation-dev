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

///////////////////////////////////////Ray Gun
/obj/item/firearm/energy/raygun
	name = "experimental ray gun"
	desc = "A weapon that looks vaguely like a cheap toy and is definitely unsafe."
	icon = 'icons/obj/items/guns/gimmick.dmi'
	icon_state = "raygun"
	item_state = "raygun"
	force = 5
	can_dual_wield = 0
	muzzle_flash = "muzzle_flash_laser"

	New()
		set_current_projectile(new/datum/projectile/energy_bolt/raybeam)
		projectiles = list(new/datum/projectile/energy_bolt/raybeam)
		..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null) //it's experimental for a reason; use at your own risk!
		if (canshoot(user))
			if (GET_COOLDOWN(src, "raygun_cooldown"))
				return
			if (prob(30))
				user.TakeDamage("chest", 0, rand(5, 15), 0, DAMAGE_BURN, 1)
				boutput(user, SPAN_ALERT("This piece of junk Ray Gun backfired! Ouch!"))
				user.do_disorient(stamina_damage = 20, disorient = 3 SECONDS)
				ON_COOLDOWN(src, "raygun_cooldown", 2 SECONDS)
		return ..(target, start, user)
