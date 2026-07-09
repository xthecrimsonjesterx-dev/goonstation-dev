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

///////////////////////////////////////Particle Blasters
TYPEINFO(/obj/item/firearm/energy/radiological/blaster_pistol)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/firearm/energy/radiological/blaster_pistol
	name = "GRF Zap-Pistole"
	desc = "A dangerous-looking particle blaster pistol from Giesel Radiofabrik. It's self-charging by a radioactive power cell. Beware of Bremsstrahlung backscatter."
	icon = 'icons/obj/items/guns/energy.dmi'
	icon_state = "pistol"
	charge_icon_state = "pistol"
	uses_charge_overlay = TRUE
	w_class = W_CLASS_NORMAL
	force = MELEE_DMG_PISTOL
	cell_type = /obj/item/ammo/power_cell/self_charging/medium
	from_frame_cell_type = /obj/item/ammo/power_cell/self_charging/disruptor
	rarity = 3
	muzzle_flash = "muzzle_flash_bluezap"
	shoot_delay = 2


	/*
	var/obj/item/gun_parts/emitter/emitter = null
	var/obj/item/gun_parts/back/back = null
	var/obj/item/gun_parts/top_rail/top_rail = null
	var/obj/item/gun_parts/bottom_rail/bottom_rail = null
	var/heat = 0 // for overheating stuff

	New()
		if (!emitter)
			emitter = new /obj/item/gun_parts/emitter
		if(!current_projectile)
			set_current_projectile(src.emitter.projectile)
		projectiles = list(current_projectile)
		..() */



	//handle gun mods at a workbench

	New()
		set_current_projectile(new /datum/projectile/laser/blaster)
		projectiles = list(current_projectile)
		..()

	/*examine()
		set src in view()
		boutput(usr, "[SPAN_NOTICE("Installed components:")]<br>")
		if(emitter)
			boutput(usr, SPAN_NOTICE("[src.emitter.name]"))
		if(cell)
			boutput(usr, SPAN_NOTICE("[src.cell.name]"))
		if(back)
			boutput(usr, SPAN_NOTICE("[src.back.name]"))
		if(top_rail)
			boutput(usr, SPAN_NOTICE("[src.top_rail.name]"))
		if(bottom_rail)
			boutput(usr, SPAN_NOTICE("[src.bottom_rail.name]"))
		..()*/

	/*proc/generate_overlays()
		src.overlays = null
		if(extension_mod)
			src.overlays += icon('icons/obj/items/gun_mod.dmi',extension_mod.overlay_name)
		if(converter_mod)
			src.overlays += icon('icons/obj/items/gun_mod.dmi',converter_mod.overlay_name)*/
