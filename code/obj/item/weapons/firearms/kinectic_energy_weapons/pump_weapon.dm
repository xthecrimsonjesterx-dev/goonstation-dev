/obj/item/firearm/kinetic/pumpweapon
	/// Whether this shotgun needs an action to pump in each direction
	var/is_heavy = FALSE
	/// Whether this shotgun's action is open (pump is pulled backwards)
	var/pump_back = FALSE
	/// Whether this shotgun is ready to fire (if the slide is not racked)
	var/hammer_ready = FALSE
	var/base_icon_state = ""
	/// The path to the sound played when the shotgun is pumped, or if is_heavy, pulled back
	var/pumpsound = 'sound/weapons/shotgunpump.ogg'
	/// The path to the sound played when the shotgun is pushed forwards, if is_heavy
	var/pushsound = FALSE
	/// The delay between racking this gun
	var/rack_delay = 0


	New()
		if (!is_heavy)
			pump_back = TRUE
			hammer_ready = TRUE
		..()

	canshoot(mob/user)
		return(..() && hammer_ready && !src.pump_back)

	attack_self(mob/user as mob)
		..()
		src.rack(user)


	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if(ammo.amount_left > 0 && (pump_back || !hammer_ready))
			boutput(user, SPAN_NOTICE("You need to rack the slide before you can fire!"))
		..()
		src.hammer_ready = FALSE
		if (!is_heavy)
			src.pump_back = TRUE //lighter guns get this half-done for you
		else
			ON_COOLDOWN(src,"rack_delay",rack_delay)
		src.UpdateIcon()


	shoot_point_blank(atom/target, mob/user, second_shot)
		if(ammo.amount_left > 0 && (pump_back || !hammer_ready))
			boutput(user, SPAN_NOTICE("You need to rack the slide before you can fire!"))
			return
		..()
		src.hammer_ready = FALSE
		if (!is_heavy)
			src.pump_back = TRUE //lighter guns get this half-done for you
		else
			ON_COOLDOWN(src,"rack_delay",rack_delay)
		src.UpdateIcon()


	update_icon()
		. = ..()
		src.icon_state = base_icon_state + (gilded ? "-golden" : "") + ((!pump_back || !has_empty_state) ? "" : "-empty" )



	proc/rack(var/atom/movable/user)
		var/mob/mob_user = null
		if(ismob(user))
			mob_user = user
		if (ON_COOLDOWN(src,"rack_delay",rack_delay))
			return
		if (!src.hammer_ready || src.pump_back) //Are we racked?
			if (src.ammo.amount_left == 0)
				if (!pump_back)
					playsound(user.loc, pumpsound, 50, 1)
					ejectcasings()
				src.pump_back = TRUE
				src.hammer_ready = TRUE
				boutput(mob_user, "<span class ='notice'>You are out of shells!</span>")
				UpdateIcon()
			else
				if (is_heavy)
					if (pump_back)
						src.pump_back = FALSE
						src.hammer_ready = TRUE
						src.icon_state = base_icon_state+"[src.gilded ? "-golden" : ""]" // having UpdateIcon() here breaks
						playsound(user.loc, pushsound, 50, 1)
					else
						ejectcasings()
						src.pump_back = TRUE
						src.hammer_ready = TRUE
						src.icon_state = base_icon_state+"[src.gilded ? "-golden-empty" : "-empty"]" // having UpdateIcon() here breaks
						playsound(user.loc, pumpsound, 50, 1)
				else
					src.hammer_ready = TRUE
					src.pump_back = FALSE
					playsound(user.loc, pumpsound, 50, 1)

					ejectcasings()
					if (src.icon_state == base_icon_state+"[src.gilded ? "-golden" : ""]") //"animated" racking
						animate(icon_state = base_icon_state+"[gilded ? "-golden" : ""]")
					else
						UpdateIcon() // Slide already open? Just close the slide
				boutput(mob_user, SPAN_NOTICE("You rack the slide of the shotgun!"))
