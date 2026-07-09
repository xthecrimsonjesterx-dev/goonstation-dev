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

////////////////////////////////////////EGun
TYPEINFO(/obj/item/firearm/energy/egun)
	mats = list("metal" = 15,
				"conductive" = 5,
				"energy" = 5)

/obj/item/firearm/energy/egun
	name = "energy gun"
	icon_state = "energy"
	cell_type = /obj/item/ammo/power_cell/med_plus_power
	desc = "The Five Points Armory Energy Gun. Double emitters with switchable fire modes, for stun bolts or lethal laser fire."
	item_state = "egun"
	force = 5
	var/nojobreward = 0 //used to stop people from scanning it and then getting both a lawbringer/sabre AND an egun.
	muzzle_flash = "muzzle_flash_elec"
	uses_charge_overlay = TRUE
	charge_icon_state = "energystun"

	New()
		set_current_projectile(new/datum/projectile/energy_bolt)
		projectiles = list(current_projectile,new/datum/projectile/laser)
		RegisterSignal(src, COMSIG_ATOM_ANALYZE, PROC_REF(noreward))
		src.verbs -= /obj/item/firearm/energy/egun/verb/claim_lawbringer
		src.verbs -= /obj/item/firearm/energy/egun/verb/claim_sword
		..()
	update_icon()
		if (current_projectile.type == /datum/projectile/laser)
			charge_icon_state = "energykill"
			muzzle_flash = "muzzle_flash_laser"
			item_state = "egun-kill"
		else if (current_projectile.type == /datum/projectile/energy_bolt)
			charge_icon_state = "energystun"
			muzzle_flash = "muzzle_flash_elec"
			item_state = "egun"
		..()
	attack_self(var/mob/M)
		..()
		UpdateIcon()
		M.update_inhands()

	pickup(mob/user)
		. = ..()
		if (user.mind?.assigned_role == "Head of Security")
			src.verbs |= /obj/item/firearm/energy/egun/verb/claim_lawbringer
		else if (user.mind?.assigned_role == "Captain")
			src.verbs |= /obj/item/firearm/energy/egun/verb/claim_sword

	dropped(mob/user)
		. = ..()
		src.verbs -= /obj/item/firearm/energy/egun/verb/claim_lawbringer
		src.verbs -= /obj/item/firearm/energy/egun/verb/claim_sword

	verb/claim_lawbringer()
		set src in usr
		set category = "Local"
		set name = "Convert to Lawbringer"

		var/datum/jobXpReward/reward = global.xpRewards["The Lawbringer"]
		reward.try_claim(usr, FALSE)

	verb/claim_sword()
		set src in usr
		set category = "Local"
		set name = "Convert to Sabre"

		var/datum/jobXpReward/reward = global.xpRewards["Commander's Sabre"]
		reward.try_claim(usr, FALSE)

	proc/noreward()
		src.nojobreward = 1

	captain
		desc = "The Five Points Armory Energy Gun. Double emitters with switchable fire modes, for stun bolts or lethal laser fire. Decorated to match standard NT captain attire."
		icon_state = "energy-cap"

	head_of_security
		desc = "The Five Points Armory Energy Gun. Double emitters with switchable fire modes, for stun bolts or lethal laser fire. 'HOS' is engraved in the side."
		icon_state = "energy-hos"

		New()
			. = ..()
			src.verbs -= /obj/item/firearm/energy/egun/verb/claim_sword

TYPEINFO(/obj/item/firearm/energy/egun_jr)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/firearm/energy/egun_jr
	name = "energy gun junior"
	icon_state = "egun-jr"
	cell_type = /obj/item/ammo/power_cell/med_minus_power
	desc = "A smaller, disposable version of the Five Points Armory energy gun, with dual modes for stun and kill."
	item_state = "egun"
	force = 3
	muzzle_flash = "muzzle_flash_elec"
	can_swap_cell = FALSE
	rechargeable = FALSE
	spread_angle = 10
	uses_charge_overlay = TRUE
	charge_icon_state = "egunjr"

	New()
		set_current_projectile(new/datum/projectile/energy_bolt/diffuse)
		projectiles = list(current_projectile,new/datum/projectile/laser/diffuse)
		..()

	update_icon()
		if (current_projectile.type == /datum/projectile/laser/diffuse)
			charge_icon_state = "[initial(charge_icon_state)]kill"
			muzzle_flash = "muzzle_flash_laser"
			item_state = "egun-jrkill"
		else if(current_projectile.type == /datum/projectile/energy_bolt/diffuse)
			charge_icon_state = "[initial(charge_icon_state)]stun"
			muzzle_flash = "muzzle_flash_elec"
			item_state = "egun-jrstun"
		..()

	attack_self(var/mob/M)
		..()
		UpdateIcon()
		M.update_inhands()
