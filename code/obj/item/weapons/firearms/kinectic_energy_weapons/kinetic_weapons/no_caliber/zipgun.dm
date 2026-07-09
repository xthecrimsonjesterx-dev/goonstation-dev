/obj/item/firearm/kinetic/zipgun
	name = "zip gun"
	desc = "An improvised and unreliable gun."
	icon_state = "zipgun"
	force = MELEE_DMG_PISTOL
	contraband = 6
	ammo_cats = list(AMMO_PISTOL_ALL, AMMO_REVOLVER_ALL, AMMO_SMG_9MM, AMMO_TRANQ_ALL, AMMO_RIFLE_308, AMMO_AUTO_308, AMMO_AUTO_556, AMMO_CASELESS_G11, AMMO_FLECHETTE, AMMO_STAPLE)
	max_ammo_capacity = 2
	var/failure_chance = 6
	var/failured = 0
	default_magazine = /obj/item/ammo/bullets/staples
	icon_recoil_cap = 30
	New()

		ammo = new default_magazine
		ammo.amount_left = 1 // start empty
		set_current_projectile(new/datum/projectile/bullet/staple)
		..()

	set_current_projectile(datum/projectile/newProj)
		..()
		if(src.current_projectile.cost > 1)
			if(src.current_projectile.shot_number < src.current_projectile.cost)
				src.current_projectile.power = src.current_projectile.cost/src.current_projectile.shot_number
			src.current_projectile.cost = 1
		if(src.current_projectile.shot_number > 1)
			src.current_projectile.shot_number = 1

	attackby(obj/item/I, mob/user)
		if (istype(I, /obj/item/staple_gun))
			var/obj/item/staple_gun/stapler = I
			if (stapler.ammo <= 0)
				boutput(user, SPAN_ALERT("You try loading staples from \the [I], but it's all out!"))
			else
				var/obj/item/ammo/bullets/staples/temp_ammo = new
				temp_ammo.amount_left = stapler.ammo
				temp_ammo.name = I.name
				src.Attackby(temp_ammo, user)
				temp_ammo.loadammo(temp_ammo, src)
				stapler.ammo = temp_ammo.amount_left
				qdel(temp_ammo)
			return
		if (istype(I, /obj/item/implant/projectile/staple))
			var/obj/item/ammo/bullets/staples/temp_ammo = new
			temp_ammo.amount_left = 1
			src.Attackby(temp_ammo, user)
			temp_ammo.loadammo(temp_ammo, src)
			if (temp_ammo.amount_left == 0)
				qdel(I)
			qdel(temp_ammo)
			return
		. = ..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if(failured)
			if(canshoot(user))
				var/turf/T = get_turf(src)
				explosion(src, T,-1,-1,1,2)
				qdel(src)
			return
		if(ammo?.amount_left && current_projectile.power)
			failure_chance = clamp(round(current_projectile.power/2 - 9), 0, 33)
		if(canshoot(user) && prob(failure_chance)) // Empty zip guns had a chance of blowing up. Stupid (Convair880).
			failured = 1
			if(prob(failure_chance))	// Sometimes the failure is obvious
				playsound(src.loc, 'sound/impact_sounds/Metal_Hit_Heavy_1.ogg', 50, 1)
				boutput(user, SPAN_ALERT("The [src]'s shodilly thrown-together [pick("breech", "barrel", "bullet holder", "firing pin", "striker", "staple-driver mechanism", "bendy metal part", "shooty-bit")][pick("", "...thing")] [pick("cracks", "pops off", "bends nearly in half", "comes loose")]!"))
			else						// Other times, less obvious
				playsound(src.loc, 'sound/impact_sounds/Generic_Snap_1.ogg', 50, 1)
		..()
		return
