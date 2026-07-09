/obj/item/firearm/kinetic/clock_188
	desc = "A NATO-surplus 9mm sidearm, still popular with Frontier military-police and peacekeeping forces. Highly customizable, often issued with frangible rounds for use in pressurized compartments."
	name = "\improper Clock 188"
	icon_state = "glock"
	item_state = "glock"
	shoot_delay = 2
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_PISTOL
	ammo_cats = list(AMMO_PISTOL_9MM_ALL)
	max_ammo_capacity = 18
	auto_eject = 1
	has_empty_state = 1
	gildable = 1
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/nine_mm_NATO
	recoil_stacking_enabled = TRUE
	recoil_strength = 6
	icon_recoil_cap = 30
	New()
		if (prob(70))
			icon_state = "glocktan"
			item_state = "glocktan"

		if(throw_return)
			default_magazine = /obj/item/ammo/bullets/nine_mm_NATO/boomerang
		ammo = new default_magazine

		set_current_projectile(new/datum/projectile/bullet/nine_mm_NATO)

		if(throw_return)
			projectiles = list(current_projectile)
		else
			projectiles = list(current_projectile, new/datum/projectile/bullet/nine_mm_NATO/auto)
			AddComponent(/datum/component/holdertargeting/fullauto, 1.2)
		..()

	attack_self(mob/user as mob)
		..()	//burst shot has a slight spread.
		if (istype(current_projectile, /datum/projectile/bullet/nine_mm_NATO/auto))
			spread_angle = 10
			shoot_delay = 4
		else
			spread_angle = 0
			shoot_delay = 2

/obj/item/firearm/kinetic/clock_188/boomerang
	desc = "Jokingly called a \"Gunarang\" in some circles. Uses 9mm NATO rounds."
	name = "\improper Clock 180"
	force = MELEE_DMG_PISTOL
	throw_range = 10
	throwforce = 1
	throw_speed = 1
	throw_return = 1
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/nine_mm_NATO
	var/prob_clonk = 0

	throw_begin(atom/target)
		playsound(src.loc, "rustle", 50, 1)
		return ..(target)

	throw_impact(atom/hit_atom, datum/thrown_thing/thr)
		var/mob/user = thr.user
		if(hit_atom == user)
			if(prob(prob_clonk))
				user.visible_message(SPAN_ALERT("<B>[user] fumbles the catch and accidentally discharges [src]!</B>"))
				src.ShootPointBlank(user, user)
				user.force_laydown_standup()
			else
				src.Attackhand(user)
			return
		else
			var/mob/M = hit_atom
			if(istype(M))
				var/mob/living/carbon/human/H = user
				if(istype(H) && istype(H.wear_suit, /obj/item/clothing/suit/security_badge))
					src.silenced = 1
					src.ShootPointBlank(M, M)
					M.visible_message(SPAN_ALERT("<B>[src] fires, hitting [M] point blank!</B>"))
					src.silenced = initial(src.silenced)

			prob_clonk = min(prob_clonk + 5, 100)
			SPAWN(1 SECONDS)
				prob_clonk = max(prob_clonk - 5, 0)

		return ..(hit_atom)

	ntso // A Clock 180 that comes preloaded with 9mm rounds for NTSOs.
		desc = "Jokingly called a \"Gunarang\" in some circles. Uses 9mm rounds."

		New()
			..()
			default_magazine = /obj/item/ammo/bullets/bullet_9mm
			ammo = new default_magazine
			set_current_projectile(new/datum/projectile/bullet/bullet_9mm)
			projectiles = list(current_projectile)
			UpdateIcon()
