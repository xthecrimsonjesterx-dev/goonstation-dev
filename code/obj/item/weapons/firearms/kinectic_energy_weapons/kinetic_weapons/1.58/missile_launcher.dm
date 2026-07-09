/obj/item/firearm/kinetic/missile_launcher
	name = "pod-targeting missile launcher"
	desc = "A collapsible, infantry portable, pod-targeting missile launcher."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi'
	icon_state = "missile_launcher"
	item_state = "missile_launcher"
	has_empty_state = TRUE
	w_class = W_CLASS_BULKY
	throw_speed = 2
	throw_range = 4
	force = MELEE_DMG_LARGE
	contraband = 8
	ammo_cats = list(AMMO_ROCKET_ALL)
	max_ammo_capacity = 1
	can_dual_wield = FALSE
	two_handed = TRUE
	muzzle_flash = "muzzle_flash_launch"
	default_magazine = /obj/item/ammo/bullets/pod_seeking_missile
	var/collapsed
	recoil_strength = 13

	New()
		ammo = new default_magazine
		ammo.amount_left = 0
		set_current_projectile(new /datum/projectile/bullet/homing/pod_seeking_missile)
		AddComponent(/datum/component/holdertargeting/smartgun/homing/pod, 1)
		src.set_collapsed_state(TRUE)
		..()

	update_icon()
		if (src.collapsed)
			src.icon = 'icons/obj/items/guns/kinetic.dmi'
			src.icon_state = "missile_launcher-collapsed"
			src.item_state = "missile_launcher-collapsed"

		else
			src.icon = 'icons/obj/items/guns/kinetic64x32.dmi'
			src.icon_state = "missile_launcher"

			if (src.ammo.amount_left < 1)
				src.item_state = "missile_launcher-empty"
			else
				src.item_state = "missile_launcher"

		if (ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			H.update_inhands()

		. = ..()

	canshoot(mob/user)
		if (src.collapsed)
			boutput(user, SPAN_ALERT("You need to extend the [src.name] before you can fire!"))
			return FALSE
		. = ..()

	attack_self(mob/user)
		src.set_collapsed_state(!src.collapsed)

		..()

	attackby(obj/item/I, mob/user)
		if (istype(I, /obj/item/ammo/bullets) && src.collapsed)
			boutput(user, SPAN_ALERT("You can't load a missile into the chamber! You'll have to extend the [src.name] first!"))
			return
		..()

	emag_act(mob/user)
		var/datum/component/holdertargeting/smartgun/homing/pod/targeting_comp = src.GetComponent(/datum/component/holdertargeting/smartgun/homing/pod)
		if(istype(targeting_comp, /datum/component/holdertargeting/smartgun/homing/pod/emagged))
			boutput(user, SPAN_ALERT("[src]'s targeting system is already malfunctioning!"))
		else
			targeting_comp.RemoveComponent()
			AddComponent(/datum/component/holdertargeting/smartgun/homing/pod/emagged, 1)
			boutput(user, SPAN_ALERT("You short circuit [src]'s targeting circuit!"))

	proc/set_collapsed_state(var/collapsed)
		if (src.setTwoHanded(!collapsed))
			src.collapsed = collapsed

			if (src.collapsed)
				src.item_function_flags &= ~UNSTORABLE
				src.w_class = W_CLASS_NORMAL
				src.has_empty_state = FALSE

			else
				src.item_function_flags |= UNSTORABLE
				src.w_class = W_CLASS_BULKY
				src.has_empty_state = TRUE

			src.UpdateIcon()
			// Update HUD inhands, as they seem to dislike icon file changes paired with changing twohandedness.
			if (ishuman(src.loc))
				var/mob/living/carbon/human/H = src.loc
				H.updateTwoHanded(src, !src.collapsed)

			if (src.collapsed)
				src.unload()

	proc/unload()
		if (src.ammo.amount_left <= 0)
			return

		var/obj/item/ammo/bullets/missile = new src.ammo.type
		missile.amount_left = src.ammo.amount_left
		missile.name = src.ammo.name
		missile.icon = src.ammo.icon
		missile.icon_state = src.ammo.icon_state
		missile.ammo_type = src.ammo.ammo_type
		missile.UpdateIcon()

		if (ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			H.put_in_hand_or_drop(missile)

		src.ammo.amount_left = 0
		src.ammo.refillable = FALSE
		src.UpdateIcon()
