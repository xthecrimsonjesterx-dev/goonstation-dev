/obj/item/firearm/kinetic/sawnoff/quadbarrel //for salvagers

	name = "\improper Four Letter Word"
	desc = "For when you REALLY need to get the point across."
	icon = 'icons/obj/large/64x32.dmi'
	icon_state = "quadb"
	item_state = "quadbarrel" //custom inhands, though.
	default_magazine = /obj/item/ammo/bullets/a12/bird/four

	camera_recoil_sway_min = 10 //VIOLENCE!
	recoil_strength = 15
	recoil_max = 60

	var/guaranteed_uses = MAX_USES	// allows for just over two volleys before it starts breaking
	var/firemode = ONE_BARREL
	var/priorammo

	force = MELEE_DMG_RIFLE
	max_ammo_capacity = 4
	two_handed = TRUE

	New()
		..()
		ammo = new default_magazine
		set_current_projectile(new /datum/projectile/special/spreader/uniform_burst/bird12)
		name = initial(name) //I kinda like the fact that it'll pull from the DB name pool buuut I kinda don't.
		UpdateIcon()

	get_help_message(dist, mob/user)
		.+= "You can use a <b>welding tool</b> to repair its state. \n You can also use a <b>screwdriver</b> to cycle firing modes."

	examine()
		. = ..()
		. += "\n \n It is set to fire " //differentiate the FLW examine text from the default gun examine text
		switch(firemode)
			if(ONE_BARREL)
				. += "one barrel."
			if(TWO_BARRELS)
				. += "two barrels."
			if(ALL_BARRELS)
				. += "all four barrels!"
		if (guaranteed_uses == MAX_USES)
			. += "It's in perfect condition!"
		else if (guaranteed_uses <= 0) //negative damage
			. += " It seems severely damaged!"
		else if (guaranteed_uses < 4) //0-4
			. += " It seems pretty damaged."
		else if(guaranteed_uses < 7) //4-7
			. += " It's damaged."
		else  //7+
			. += " It's barely damaged."


	update_icon()
		. = ..()
		src.icon_state = "quadb" + (!src.broke_open ? "" : "-empty" )

	shoot(var/target, var/start, var/mob/user)

		priorammo = src.ammo.amount_left

		//Go up to the limit defined by the firing mode, but don't exceed however many bullets are in the gun BEFORE we started firing
		for(var/i=1, ((i <= priorammo) && (i <= firemode)), i++)
			..() //shoot an additional ith time (just goes once if it's in single shot)
			guaranteed_uses-- //damage the gun an additional ith time

		//check the gun's condition, break as needed
		if((priorammo > 0) && !(src.broke_open)) //make sure the gun isn't empty and also closed (shooting conditions) before we roll to break
			//you're shooting multiple shotgun shells out of a garbage gun at the same time. don't think there won't be consequences
			if((firemode != ONE_BARREL) && (priorammo == 2)) // two shells are shot, can be in 2 or 4 mode
				boutput(user, SPAN_ALERT("The [src] jumps in your hands!"))
				user.do_disorient(stamina_damage = 20, knockdown = 0, stunned = 0, disorient = 5, remove_stamina_below_zero = 0)
			else if((firemode == ALL_BARRELS) && (priorammo >= 3)) //3 or more shells, can only be in all barrel mode
				SPAWN(0.3 DECI SECONDS) //give it a micro-delay
				if (src.canshoot(user))
					boutput(user, SPAN_ALERT("The [src] kicks like a damn mule!"))
					//this might seem punishing but keep in mind it's FOUR whole shotgun shells at once.
					user.do_disorient(stamina_damage = 40, knockdown = 0, stunned = 0, disorient = 20, remove_stamina_below_zero = 0)

			if(guaranteed_uses < 0)
				//warn the user that they're in the danger zone
				playsound(src.loc, 'sound/impact_sounds/Generic_Snap_1.ogg', 50, 1)
				user.visible_message(SPAN_COMBAT("The [src] [pick(list("rattles!", "bulges!", "pops!", "thunks!", "jolts!", "makes a concerning click...", "cracks!"))]"))
				if (prob(guaranteed_uses*-5)) //roll for failure. Since [uses] is now negative, we need another minus sign to cancel out

					user.visible_message(SPAN_ALERT("[user]'s [src] makes a severe-sounding bang!"), SPAN_ALERT("The [src] gives out!"))

					if((firemode == ALL_BARRELS) && (priorammo == 4)) //ohhh, you REALLY fucked up now.
						explosion(src, get_turf(src), 0, 0.5, 1.5, 4)

					//replace the gun with broken version
					var/obj/item/brokenquadbarrel/broken = new /obj/item/brokenquadbarrel
					user.drop_item(src)
					user.put_in_hand_or_drop(broken)
					qdel(src)

	proc/repairdamage(obj/item/firearm/kinetic/sawnoff/quadbarrel/Q, mob/user)
		if(guaranteed_uses < MAX_USES)
			Q.guaranteed_uses ++

		if(guaranteed_uses == MAX_USES)
			boutput(user, SPAN_NOTICE("You fully repair the [src]!"))
			actions.interrupt(user, INTERRUPT_ACT) //break the loop
		else if(guaranteed_uses <= 0) //negative
			boutput(user, SPAN_NOTICE("You patch up some of the cracks and bulges on the [src]. It's still severely damaged..."))
		else if(guaranteed_uses < 5) //0-4
			boutput(user, SPAN_NOTICE("You patch up some of the cracks and bulges on the [src]. It's still pretty damaged..."))
		else //5+
			boutput(user, SPAN_NOTICE("You patch up some of the cracks and bulges on the [src]. It's starting to look better..."))

	proc/get_welding_positions()

		var/startpos = list(rand(7, 16), rand(4, -4))
		var/stoppos = list(rand(7, 16), rand(4, -4))
		return list(startpos, stoppos)

	attackby(obj/item/I, mob/user)

		//are we repairing?
		if (isweldingtool(I))
			var/obj/item/weldingtool/welder = I
			if(guaranteed_uses == MAX_USES)
				boutput(user, SPAN_NOTICE("The [src] doesn't seem to be all that damaged."))
			else //We are good to repair!
				var/datum/action/bar/icon/callback/action_bar
				boutput(user, SPAN_NOTICE("You start to repair the [src]..."))

				//create the action bar
				var/positions = src.get_welding_positions()
				action_bar = new /datum/action/bar/private/welding/loop(user, src, 1.5 SECONDS, \
				proc_path = /obj/item/firearm/kinetic/sawnoff/quadbarrel/proc/repairdamage, \
				proc_args=list(src, user), \
				start = positions[1], \
				stop = positions[2], \
				tool = welder, \
				cost = 2)

				//begin repairing!
				actions.start(action_bar, user)
		//are we cycling through firing modes?
		else if(isscrewingtool(I))
			if(firemode == ONE_BARREL)
				firemode = TWO_BARRELS
				boutput(user, SPAN_NOTICE("You set [src] to fire two barrels at a time."))
			else if(firemode == TWO_BARRELS)
				firemode = ALL_BARRELS
				boutput(user, SPAN_NOTICE("You set [src] to fire all four barrels! You're not so sure about this..."))
			else
				firemode = ONE_BARREL
				boutput(user, SPAN_NOTICE("You set [src] to fire one barrel at a time."))
		else //no special interactions, so default to whatever
			..()

/obj/item/brokenquadbarrel
	two_handed = TRUE
	icon = 'icons/obj/large/64x32.dmi'
	icon_state = "quadb-broken"
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi' //gotta make it use gun inhands
	item_state = "quadbarrel"
	name = "Broken Four Letter Word"
	desc = "This thing is TOTALED well beyond repair. You feel like you can recover a slamgun from it, though."
	force = MELEE_DMG_RIFLE

	attack_self(mob/user as mob)

		user.drop_item(src) //clear hands
		boutput(user, SPAN_NOTICE("You rip apart the [src]!"))
		playsound(src.loc, 'sound/impact_sounds/Machinery_Break_1.ogg', 40, 1)

		// give an OPEN slamgun
		var/obj/item/firearm/kinetic/slamgun/newgun = new /obj/item/firearm/kinetic/slamgun
		user.put_in_hand_or_drop(newgun)
		newgun.AttackSelf(user)

		//give some other random junk that'd reasonably be pulled off, for flavor
		var/turf/T = get_turf(src)

		var/obj/item/raw_material/scrap_metal/W = new /obj/item/raw_material/scrap_metal
		W.setMaterial(getMaterial("wood"))
		W.name = "mangled chunk of wood"
		W.desc = "If you tilt your head and squint, it looks like it possibly might've been a stock at one point."
		W.icon = 'icons/obj/items/materials/materials.dmi'
		W.icon_state = "scrap4"

		var/obj/decal/cleanable/machine_debris/G = new /obj/decal/cleanable/machine_debris
		G.icon_state = "gib1"

		var/obj/item/rods/steel/R = new /obj/item/rods/steel
		var/obj/item/scrap/S1 = new /obj/item/scrap
		S1.icon_state = "2metal0"

		var/flavordebris = list(W, G, R, S1)
		var/obj/item/currentitem
		var/i
		for(i=1, i<=4, i++)
			currentitem = flavordebris[i]
			currentitem.set_loc(T)
			currentitem.pixel_x = rand(-8,8)
			currentitem.pixel_y = rand(-8,8)

		qdel(src)
