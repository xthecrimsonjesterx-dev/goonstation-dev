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

////////////////////////////////////// Antique laser gun
TYPEINFO(/obj/item/firearm/energy/antique)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/firearm/energy/antique
	HELP_MESSAGE_OVERRIDE("You can use a <b>screwdriver</b> to open or close the maintenance panel. While the panel is open, you can insert lens and small coil to upgrade the weapon.")
	name = "antique laser gun"
	icon_state = "caplaser"
	item_state = "capgun"
	cell_type = /obj/item/ammo/power_cell/tiny
	force = 7
	desc = "It's a kit model of the Mod.00 'Lunaport Legend' laser gun from Super! Protector Friend. With realistic sound fx and exciting LED display!"
	muzzle_flash = "muzzle_flash_laser"
	uses_charge_overlay = TRUE
	charge_icon_state = "caplaser"

	var/obj/item/coil/small/myCoil = null
	var/obj/item/lens/myLens = null
	var/panelOpen = FALSE

	examine(mob/user)
		. = ..()
		if(src.panelOpen)
			. += "The maintenance panel is open."

	attackby(obj/item/item, mob/user)
		. = ..()
		if(isscrewingtool(item))
			user.show_text("You [src.panelOpen ? "close" : "open"] the maintenance panel.", "blue")
			src.panelOpen = !src.panelOpen
			if(!src.panelOpen)
				if(src.determineProjectiles() >= 3)//highest tier
					user.unlock_medal("Tinkerer", 1)
		if(istype(item, /obj/item/coil/small))
			if(panelOpen)
				user.show_text("You insert [item]", "blue")
				user.drop_item(item)
				if(src.myCoil)
					user.put_in_hand_or_drop(src.myCoil)
				src.myCoil = item
				item.set_loc(src)
			else
				user.show_text("You need to unscrew the maintenance panel first!", "red")
		if (istype(item, /obj/item/lens))
			if(panelOpen)
				user.show_text("You insert [item]", "blue")
				user.drop_item(item)
				if(src.myLens)
					user.put_in_hand_or_drop(src.myLens)
				src.myLens = item
				item.set_loc(src)
			else
				user.show_text("You need to unscrew the maintenance panel first!", "red")

	canshoot(mob/user)
		//configures the projectiles and makes sure it can actually shoot
		if(!src.myCoil || !src.myLens || !src.myCoil.material || !src.myLens.material)
			user.show_text("It's just a display model!", "red")
			return FALSE
		if(src.panelOpen)
			user.show_text("You need to secure the maintenance panel first!", "red")
			return FALSE
		. = ..()

	proc/evaluateQuality()
		//a quantification of how good the build was.
		//0 = nonfunctional
		//1 or 2 = 25 damage laser
		//3 or 4 = 45 damage laser
		//5 or 6 = 45 damage laser with alt-fire 3-round burst of 25 damage lasers
		var/evaluationScore = 0
		if(!src.myCoil || !src.myLens || !src.myCoil.material || !src.myLens.material)
			//not all components present
			return 0
		switch(src.myLens.material.getAlpha())
			if(-INFINITY to 80)
				evaluationScore += 3
			if(80 to 130)
				evaluationScore += 2
			if(130 to 180)
				evaluationScore += 1
			if(180 to INFINITY)
				//not good enough to be functional
				return 0
		switch(src.myCoil.material.getProperty("electrical") + ((src.myCoil.material.getMaterialFlags() & MATERIAL_ENERGY) ? 2 : 0))
			if(10 to INFINITY)
				evaluationScore += 3
			if(8 to 10)
				evaluationScore += 2
			if(6 to 8)
				evaluationScore += 1
			if(-INFINITY to 6)
				//not good enough to be functional
				return 0
		//grading finished, return score
		return evaluationScore

	proc/determineProjectiles()
		//returns a number for each tier
		switch(src.evaluateQuality())
			if(5 to INFINITY)
				src.current_projectile = new/datum/projectile/laser
				src.projectiles = list(current_projectile, new/datum/projectile/laser/glitter/burst)
				return 3
			if(3 to 5)
				src.current_projectile = new/datum/projectile/laser
				src.projectiles = list(current_projectile)
				return 2
			if(1 to 3)
				src.current_projectile = new/datum/projectile/laser/glitter
				src.projectiles = list(current_projectile)
				return 1
			if(-INFINITY to 1)
				src.current_projectile = null
				src.projectiles = null
				return 0
