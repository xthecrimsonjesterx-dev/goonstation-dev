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

// Makeshift Laser Rifle
#define HEAT_REMOVED_PER_PROCESS 30
#define FIRE_THRESHOLD 125

TYPEINFO(/obj/item/firearm/energy/makeshift)
	analyser_flags = ANALYSER_BLACKLIST

/obj/item/firearm/energy/makeshift
	name = "makeshift laser rifle"
	icon = 'icons/obj/items/guns/energy64x32.dmi'
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "makeshift-energy"
	item_state = "makeshift_laser"
	wear_state = "makeshift_laser"
	c_flags = ONBACK
	cell_type = null
	can_swap_cell = FALSE
	rechargeable = FALSE
	force = 7
	two_handed = TRUE
	can_dual_wield = FALSE
	desc = "A laser rifle cobbled together from various appliances, Prone to overheating."
	muzzle_flash = "muzzle_flash_phaser"
	charge_icon_state = "laser"
	spread_angle = 10
	shoot_delay = 5 DECI SECONDS
	///What light source we use for the rifle
	var/obj/item/light/tube/our_light
	///What battery this gun uses
	var/obj/item/cell/our_cell
	///How much heat this weapon has after firing, the weapon breaks if this gets too high
	var/heat = 0
	///What step of repair are we on if we have broken? 0 = functional
	var/heat_repair = 0

	proc/attach_cell(obj/item/cell/C, mob/user)
		if (user)
			user.u_equip(C)
		RegisterSignal(C, COMSIG_PARENT_PRE_DISPOSING, PROC_REF(remove_cell))
		our_cell = C
		our_cell.set_loc(src)
		our_cell.AddComponent(/datum/component/power_cell, our_cell.maxcharge, our_cell.charge, our_cell.genrate, 0, FALSE)
		SEND_SIGNAL(src, COMSIG_CELL_SWAP, our_cell)
		UpdateIcon()

	proc/attach_light(obj/item/light/tube/T, mob/user)
		if (user)
			user.u_equip(T)
		our_light = T
		our_light.set_loc(src)
		UpdateIcon()
		var/datum/projectile/laser/makeshift/new_laser = new /datum/projectile/laser/makeshift
		new_laser.color_icon = rgb(our_light.color_r * 255, our_light.color_g * 255, our_light.color_b * 255)
		new_laser.color_red = our_light.color_r
		new_laser.color_green = our_light.color_g
		new_laser.color_blue = our_light.color_b
		set_current_projectile(new_laser)

	proc/do_explode()
		explosion(src, get_turf(src), -1, -1, 1, 2)
		qdel(src)

	proc/finish_repairs(obj/item/cable_coil/C, mob/user)
		if(C?.use(10))
			heat_repair = 0
			playsound(src, 'sound/effects/pop.ogg', 50, TRUE)
			src.icon_state = "makeshift-energy"
			UpdateIcon()

	proc/add_heat(var/heat_to_add, var/mob/user)
		heat += heat_to_add
		if (heat >= FIRE_THRESHOLD)
			if (user)
				boutput(user,SPAN_ALERT("[src] bursts into flame!"))
			if (our_cell)
				our_cell.use(our_cell.charge)
				SEND_SIGNAL(src, COMSIG_CELL_USE, INFINITY)
			elecflash(get_turf(src), 1, 3)
			our_light.light_status = LIGHT_BURNED
			our_light.update()
			heat_repair = 1
			src.icon_state = "makeshift-burnt-1"
			heat += FIRE_THRESHOLD // spicy!
			UpdateIcon()

	proc/remove_cell()
		var/obj/item/cell/C = our_cell
		C.UpdateIcon()
		UnregisterSignal(C, COMSIG_PARENT_PRE_DISPOSING)
		var/datum/component/power_cell/comp = C.GetComponent(/datum/component/power_cell)
		comp.UnregisterFromParent()
		comp.RemoveComponent()
		our_cell = null
		// need to reset our component or else a runtime occurs
		var/datum/component/cell_holder/holder = src.GetComponent(/datum/component/cell_holder)
		holder.cell = null
		UpdateIcon()

	emp_act()
		if (our_cell)
			src.visible_message(SPAN_ALERT("[src]'s cell violently overheats!"))
			src.add_heat(FIRE_THRESHOLD)

	New()
		processing_items |= src
		set_current_projectile(new/datum/projectile/laser/makeshift)
		projectiles = list(current_projectile)
		..()

	Exited(Obj, newloc)
		var/obj/item/cell/C = Obj
		if (istype(C) && !QDELETED(C))
			src.remove_cell()
		. = ..()


	process()
		if (heat > 0)
			if (heat > FIRE_THRESHOLD)
				var/mob/living/victim = src.loc
				if (istype(victim))
					victim.changeStatus("burning", 7 SECONDS)
					if (!ON_COOLDOWN(victim, "makeshift_burn", 5 SECONDS))
						boutput(victim, SPAN_ALERT("You are set on fire due to the extreme temperature of [src]!"))
						victim.emote("scream")
			heat = max(0, heat - HEAT_REMOVED_PER_PROCESS)
			UpdateIcon()
		return

	canshoot(mob/user)
		if (heat_repair != 0)
			boutput(user,SPAN_ALERT("[src] will need repairs before being able to function!"))
			return FALSE
		if (!our_light)
			boutput(user,SPAN_ALERT("[src] needs a light source to function!"))
			return FALSE
		else if (our_light.light_status != LIGHT_OK)
			boutput(user,SPAN_ALERT("[src] has no reaction when you pull the trigger!"))
			return FALSE
		else
			return ..()

	attackby(obj/item/W, mob/user, params)
		if (heat < FIRE_THRESHOLD)
			if(heat_repair) // gun machine broke, we need to repair it
				if (issnippingtool(W) && heat_repair == 1)
					boutput(user,SPAN_NOTICE("You remove the burnt wiring from [src]."))
					playsound(src, 'sound/items/Wirecutter.ogg', 50, TRUE)
					heat_repair++
					src.icon_state = "makeshift-burnt-2"
					UpdateIcon()
					return
				else if (istype(W, /obj/item/cable_coil) && heat_repair == 2)
					if (W.amount >= 10)
						SETUP_GENERIC_ACTIONBAR(user, src, 3 SECONDS, /obj/item/firearm/energy/makeshift/proc/finish_repairs,\
						list(W,user), W.icon, W.icon_state, SPAN_NOTICE("[user] replaces the burnt wiring within [src]."), null)
					else
						boutput(user,SPAN_NOTICE("You need at least 10 wire to repair the wiring."))
					return
			else if (iswrenchingtool(W) && our_cell)
				var/obj/item/removed_cell = our_cell
				SEND_SIGNAL(src, COMSIG_CELL_SWAP, null)
				boutput(user,SPAN_NOTICE("You disconnect [our_cell] from [src]."))
				playsound(src, 'sound/items/Ratchet.ogg', 50, TRUE)
				user.put_in_hand_or_drop(removed_cell)
				return
			else if (istype(W, /obj/item/cell) && !our_cell)
				user.u_equip(W)
				boutput(user,SPAN_NOTICE("You attach [W] to [src]."))
				attach_cell(W, user)
				return
			else if (issnippingtool(W) && our_light)
				boutput(user,SPAN_NOTICE("You remove the wiring attaching [our_light] to the barrel."))
				playsound(src, 'sound/items/Wirecutter.ogg', 50, TRUE)
				user.put_in_hand_or_drop(our_light)
				our_light = null
				UpdateIcon()
				return
			else if (istype(W, /obj/item/light/tube) && !our_light)
				boutput(user,SPAN_NOTICE("You place [W] inside of the barrel and redo the wiring."))
				playsound(src, 'sound/effects/pop.ogg', 50, TRUE)
				attach_light(W, user)
				UpdateIcon()
				return
			..()
		else
			boutput(user,SPAN_NOTICE("Attempting to work on [src] while its on fire might be a bad idea..."))
			return

	get_desc()
		. = ..()
		if (!heat_repair)
			if (!our_cell && isnull(cell_type))
				. += SPAN_ALERT("<b> [src] is lacking a power source!</b>")
			if (!our_light)
				. += SPAN_ALERT("<b> [src] is lacking a light source!</b>")
			else if(our_light.light_status != LIGHT_OK)
				. += SPAN_ALERT("<b> [src]'s light source is nonfunctional!</b>")
		else
			. += SPAN_ALERT("<b> [src] is broken and requires repairs!</b>")

	get_help_message(dist, mob/user)
		switch(src.heat_repair)
			if(0)
				if(cell_type)
					; //noop
				else if(!our_cell)
					. += "You can use a large energy cell on [src] to attach it to the gun."
				else
					. += "You can use a <b>wrench</b> to remove [src]'s energy cell."
				if(!our_light)
					. += "You can use a light tube on [src] to insert it into the gun."
				else
					. += "You can use <b>wirecutters</b> to remove [src]'s light tube."
			if(1)
				. = "You can use <b>wirecutters</b> to remove the burnt wiring."
			if(2)
				. = "You can add 10 wire to replace the wiring."

	attack_self(mob/user)
		var/I = tgui_input_number(user, "Input a firerate (In deciseconds)", "Timer Adjustment", shoot_delay, 10, 2)
		if (!I || BOUNDS_DIST(src, user) > 0)
			return
		shoot_delay = I
		boutput(user, SPAN_NOTICE("You adjust [src] to fire every [I / 10] seconds."))

	update_icon()
		if (our_cell)
			var/image/overlay_image
			if (istype(our_cell, /obj/item/cell/artifact))
				var/obj/item/cell/artifact/C = our_cell
				var/datum/artifact/powercell/AS = C.artifact
				var/datum/artifact_origin/AO = AS.artitype
				overlay_image = SafeGetOverlayImage("gun_cell", src.icon, "makeshift-[AO.name]")
			else
				overlay_image = SafeGetOverlayImage("gun_cell", src.icon, "makeshift-[our_cell.icon_state]")
			src.UpdateOverlays(overlay_image, "gun_cell")
		else
			src.UpdateOverlays(null, "gun_cell")

		if (our_light)
			var/image/overlay_image = SafeGetOverlayImage("gun_light", src.icon, "makeshift-light")
			src.UpdateOverlays(overlay_image, "gun_light")
		else
			src.UpdateOverlays(null, "gun_light")

		if (heat > FIRE_THRESHOLD)
			var/image/overlay_image = SafeGetOverlayImage("gun_smoke", src.icon, "makeshift-burn")
			src.UpdateOverlays(overlay_image, "gun_smoke")
		else if (heat > 70)
			var/image/overlay_image = SafeGetOverlayImage("gun_smoke", src.icon, "makeshift-smoke")
			src.UpdateOverlays(overlay_image, "gun_smoke")
		else
			src.UpdateOverlays(null, "gun_smoke")
		..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (canshoot(user))
			if (our_light.rigged) // bad idea
				src.visible_message(SPAN_ALERT("[src]'s light tube violently explodes!"))
				do_explode()
				return
			var/datum/projectile/laser/makeshift/possible_laser
			if (istype(possible_laser))
				src.add_heat(rand(possible_laser.heat_low, possible_laser.heat_high), user)
			else // allow varedit shenanigans
				src.add_heat(rand(15,20), user)
			UpdateIcon()
			our_cell?.use(current_projectile.cost)
		return ..(target, start, user)

/obj/item/firearm/energy/makeshift/spawnable // for testing purposes

	New()
		..()
		var/obj/item/cell/supercell/charged/C = new /obj/item/cell/supercell/charged
		C.UpdateIcon() // fix visual bug
		src.attach_cell(C)
		var/obj/item/light/tube/T = new /obj/item/light/tube
		src.attach_light(T)
