/obj/item/firearm/kinetic/uzi
	desc = "A stamped metal PDW, produced to respond to Mortian raids. A favorite of armed bodyguards, hired muscle, henchmen, and gangsters."
	name = "\improper MOR-30"
	icon_state = "uzi"
	item_state = "uzi"
	spread_angle = 8
	shoot_delay = 5
	has_empty_state = TRUE
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_PISTOL
	ammo_cats = list(AMMO_SMG_9MM)
	max_ammo_capacity = 30
	auto_eject = TRUE
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/nine_mm_surplus/mag_mor
	icon_recoil_cap = 15
	tooltip_flags = REBUILD_USER
	get_desc(dist, mob/user)
		if (user.get_gang() != null)
			. += "For when you need MOR' DAKKA. Uses 9mm Surplus rounds."
		else
			. += "Its firemodes are labelled 'DAKKA' and 'MOR'... Uses 9mm Surplus rounds."

	New()
		ammo = new default_magazine

		set_current_projectile(new/datum/projectile/bullet/nine_mm_surplus/burst)
		projectiles = list(current_projectile, new/datum/projectile/bullet/nine_mm_surplus/auto)
		AddComponent(/datum/component/holdertargeting/fullauto, 1.5)
		..()

	attack_self(mob/user)
		..()	//burst shot has a slight spread.
		if (istype(current_projectile, /datum/projectile/bullet/nine_mm_surplus/auto))
			spread_angle = 10
			shoot_delay = 4
		else
			spread_angle = 8
			shoot_delay = 5

	//warcrimes brought to you by bullets telling guns how to shoot!
	attackby(obj/item/ammo/bullets/b, mob/user)
		var/obj/previous_ammo = ammo
		var/mode_was_auto = current_projectile.fullauto_valid
		..()
		if(previous_ammo.type != ammo.type)  // we switched ammo types
			if(istype(ammo, /obj/item/ammo/bullets/nine_mm_surplus))
				if(mode_was_auto)
					set_current_projectile(new/datum/projectile/bullet/nine_mm_surplus/auto)
					projectiles = list(new/datum/projectile/bullet/nine_mm_surplus/burst, current_projectile)
				else
					set_current_projectile(new/datum/projectile/bullet/nine_mm_surplus/burst)
					projectiles = list(current_projectile, new/datum/projectile/bullet/nine_mm_surplus/auto)
			else if(istype(ammo, /obj/item/ammo/bullets/bullet_9mm/smg))
				if(mode_was_auto)
					set_current_projectile(new/datum/projectile/bullet/bullet_9mm/smg/auto)
					projectiles = list(new/datum/projectile/bullet/bullet_9mm/smg, current_projectile)
				else
					set_current_projectile(new/datum/projectile/bullet/bullet_9mm/smg)
					projectiles = list(current_projectile, new/datum/projectile/bullet/bullet_9mm/smg/auto)
