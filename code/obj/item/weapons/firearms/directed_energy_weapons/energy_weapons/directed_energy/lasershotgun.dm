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

TYPEINFO(/obj/item/firearm/energy/lasershotgun)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/firearm/energy/lasershotgun
	name = "Mod. 77 'Nosaxa'"
	cell_type = /obj/item/ammo/power_cell/high_power
	icon = 'icons/obj/items/guns/energy48x32.dmi'
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "lasershotgun"
	desc = "Originally developed as a mining laser, the Nosaxa was quickly rebranded after the dangers of firing it in confined spaces were discovered."
	item_state = "lasershotgun"
	c_flags = ONBACK
	force = 10
	two_handed = TRUE
	uses_charge_overlay = TRUE
	muzzle_flash = "muzzle_flash_red"
	charge_icon_state = "lasershotgun"
	var/overheated = FALSE
	var/shotcount = 0

	New()
		set_current_projectile(new/datum/projectile/special/spreader/tasershotgunspread/laser)
		projectiles = list(new/datum/projectile/special/spreader/tasershotgunspread/laser)
		..()

	canshoot(mob/user)
		return(..() && !src.overheated)

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (!shoot_check(user))
			return
		..()
		if (src.shotcount++ >= 1)
			src.overheat()

	shoot_point_blank(atom/target, mob/user, second_shot)
		if (!shoot_check(user))
			return
		..()
		if (src.shotcount++ >= 1)
			src.overheat()

	proc/overheat()
		src.overheated = TRUE
		SPAWN(0.3 SECONDS)
			playsound(src, 'sound/impact_sounds/burn_sizzle.ogg')
		src.UpdateParticles(new /particles/steam_leak, "overheat_steam", plane = src.plane + (src.plane == PLANE_HUD ? 1 : 0))

	dropped(mob/user)
		. = ..()
		for (var/key in src.particle_refs)
			var/obj/effects/particle_holder/holder = src.particle_refs[key]
			holder.plane = src.plane

	pickup(mob/user)
		. = ..()
		for (var/key in src.particle_refs)
			var/obj/effects/particle_holder/holder = src.particle_refs[key]
			holder.plane = PLANE_ABOVE_HUD

	proc/shoot_check(var/mob/user)
		if (SEND_SIGNAL(src, COMSIG_CELL_CHECK_CHARGE, amount) & CELL_INSUFFICIENT_CHARGE)
			boutput(user, "<span class ='notice'>You are out of energy!</span>")
			return FALSE

		if (GET_COOLDOWN(src, "rack delay"))
			boutput(user, "<span class ='notice'>Still cooling!</span>")
			return FALSE

		if (src.overheated)
			boutput(user, "<span class='notice'>You need to vent before you can fire!</span>")
			playsound(src.loc, 'sound/machines/button.ogg', 50, 1, -5)
			return FALSE
		return TRUE

	attack_self(mob/user as mob)
		..()
		src.rack(user)

	proc/rack(var/mob/user)
		if (src.shotcount > 0 && !ON_COOLDOWN(src, "rack delay", 1 SECONDS))
			boutput(user, "<span class='notice'>You release some heat from the shotgun!</span>")
			playsound(src, 'sound/effects/steamrelease.ogg', 70, 1)
			SPAWN(1 SECOND)
				src.overheated = FALSE
				src.shotcount = 0
				src.UpdateParticles(null, "overheat_steam")
