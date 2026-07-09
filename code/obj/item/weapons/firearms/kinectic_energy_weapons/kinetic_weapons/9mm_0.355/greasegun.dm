/obj/item/firearm/kinetic/greasegun
	name = "\improper Grease Gun"
	desc = "A really clunky stamped-metal SMG. Tons of these were mass-produced in Mars colony machine shops during the War, and many have ended up in the Frontier."
	icon_state = "grease"
	item_state = "grease"
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	spread_angle = 14
	shoot_delay = 5
	has_empty_state = TRUE
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_PISTOL
	ammo_cats = list(AMMO_SMG_9MM)
	max_ammo_capacity = 30
	auto_eject = TRUE
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/nine_mm_surplus/mag_grease
	var/grease = 0 //guh
	icon_recoil_cap = 20

	New()
		if (prob(33))
			name = "\improper [pick ("Greafe","Grief","Greef","Griff","Greece")] Gun"
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/nine_mm_surplus/auto)
		var/datum/callback/delay_callback = new(src, PROC_REF(set_auto_delay))
		AddComponent(/datum/component/holdertargeting/fullauto/callback, 1.2, delay_callback)
		..()

	get_desc(dist, mob/user)
		if (grease == 0)
			. += "It's all seized up and could do with maintenance."
		else if (grease < 0)
			. += "It's, er, all sticky and covered glue. WHY is it covered with glue???"
		else
			. += "It's greasy, alright..."

	attack_self(mob/user as mob)
		if(ishuman(user))
			if(two_handed)
				setTwoHanded(0) //Go 1-handed.
				src.spread_angle = initial(src.spread_angle)
				icon_recoil_cap = initial(src.icon_recoil_cap)
				recoil_max = initial(src.recoil_max)
				icon_state = "grease"
			else
				if(!setTwoHanded(1)) //Go 2-handed.
					boutput(user, SPAN_ALERT("Can't switch to 2-handed while your other hand is full."))
				else
					icon_recoil_cap = 10
					icon_state = "greaseunfolded"
					recoil_max = 100 // double how easy it is to control
					src.spread_angle = 6
		..()

	reagent_act(reagent_id,volume)
		if ((reagent_id in list("oil","lube", "superlube", "grease", "badgrease", "fishoil")) && volume >= 5)
			grease = 15
		if (reagent_id == "spaceglue" && volume >= 5)
			grease = -30

	//copy pastes brought to you by bullets telling guns how to shoot!
	attackby(obj/item/ammo/bullets/b, mob/user)
		var/obj/previous_ammo = ammo
		..()
		if(previous_ammo.type != ammo.type)  // we switched ammo types
			if(istype(ammo, /obj/item/ammo/bullets/nine_mm_surplus))
				set_current_projectile(new/datum/projectile/bullet/nine_mm_surplus/auto)
			else if(istype(ammo, /obj/item/ammo/bullets/bullet_9mm/smg))
				set_current_projectile(new/datum/projectile/bullet/bullet_9mm/smg/auto)

	proc/set_auto_delay(delay)
		. = delay * 10
		if (grease > 0)
			. = 18 - (grease)
			grease--
		else if (grease < 0)
			. = 30
			grease++
		else
			. = clamp(. + rand(-8,8),10,26)
		. /= 10
