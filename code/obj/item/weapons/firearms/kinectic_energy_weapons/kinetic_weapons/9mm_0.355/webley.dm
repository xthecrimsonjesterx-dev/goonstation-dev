/obj/item/firearm/kinetic/webley
	name = "Webley 'Holdout' Snubnose"
	desc = "A cut down Webley break-action revolver. There's some extra weight in the grip for spinning action."
	icon_state = "webleysnub"
	force = MELEE_DMG_REVOLVER
	ammo_cats = list(AMMO_WEBLEY)
	w_class = W_CLASS_SMALL
	fire_animation = TRUE
	has_fire_anim_state = TRUE
	fire_anim_state = "webleysnubfire"
	max_ammo_capacity = 6
	auto_eject = FALSE
	can_dual_wield = FALSE
	two_handed = FALSE
	add_residue = TRUE
	gildable = TRUE
	spread_angle = 2
	default_magazine = /obj/item/ammo/bullets/webley
	safe_spin = TRUE // so you dont shoot yourself drawing the gun

	HELP_MESSAGE_OVERRIDE({"If your hands are empty, drawing this gun from a pocket grants a brief, large firerate increase, at the cost of accuracy."})

	var/broke_open = FALSE
	var/locked_shut = FALSE // stop folk doing weird stuff while fanning the hammer
	var/shells_to_eject = 0

	New() //uses a special box of ammo that only starts with 2 shells to prevent issues with overloading
		ammo = new/obj/item/ammo/bullets/webley
		set_current_projectile(new/datum/projectile/bullet/webley)
		..()

	update_icon()
		. = ..()
		src.icon_state = "webleysnub" + (!src.broke_open ? "" : "open" )

	canshoot(mob/user)
		if (!src.broke_open)
			return TRUE
		..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (src.broke_open)
			boutput(user, SPAN_ALERT("You need to close [src] before you can fire!"))
		if (!src.broke_open && src.ammo.amount_left > 0)
			src.shells_to_eject++
		..()

	attack_self(mob/user)
		src.toggle_action(user)
		..()

	attackby(obj/item/I, mob/user)
		if (istype(I, /obj/item/ammo/bullets) && !src.broke_open)
			boutput(user, SPAN_ALERT("You can't load rounds into the cylinder! You'll have to open [src] first!"))
			return
		..()

	attack_hand(mob/user)
		if (!src.broke_open && user.find_in_hand(src))
			boutput(user, SPAN_ALERT("[src] is still closed, you need to open the action to take the rounds out!"))
			return
		..()

	on_spin_emote(mob/living/carbon/human/user)
		if(src.broke_open) // Only allow spinning to close the gun, doesn't make as much sense spinning it open.
			src.toggle_action(user)
			user.visible_message(SPAN_ALERT("<b>[user]</b> snaps shut [src] with a [pick("spin", "twirl")]!"))
		..()
	attack_hand(mob/user)
		if (ishuman(loc))
			var/mob/living/carbon/human/H = src.loc
			if ( (H.l_store == src || H.r_store == src) && H.l_hand == null && H.r_hand == null)
				fan_the_hammer(user)
		..()

	proc/fan_the_hammer(mob/user)
		if (!ON_COOLDOWN(src, "twirl_spam", 2 SECONDS))
			src.on_spin_emote(user)
			animate_spin(src, prob(50) ? "L" : "R", 1, 0)
			locked_shut = TRUE
			shoot_delay = 2
			spread_angle = 15
			user.show_message(SPAN_ALERT("[user] whips \the [src] out of [his_or_her(user)] pocket, seating their free hand over the hammer!"), 1)
			src.current_projectile.power *= 0.7 //a full pelting puts you INCHES from death
			SPAWN (4 SECONDS)
				locked_shut = FALSE
				spread_angle = 2
				shoot_delay = 4
				src.current_projectile.generate_stats() //regenerate power

	proc/toggle_action(mob/user)
		if (locked_shut)
			return
		if (!src.broke_open)
			src.casings_to_eject = src.shells_to_eject

			if (src.casings_to_eject > 0) //this code exists because without it the gun ejects double the amount of shells
				src.ejectcasings()
				src.shells_to_eject = 0
		src.broke_open = !src.broke_open

		playsound(user.loc, 'sound/weapons/gunload_click.ogg', 15, TRUE)

		UpdateIcon()
