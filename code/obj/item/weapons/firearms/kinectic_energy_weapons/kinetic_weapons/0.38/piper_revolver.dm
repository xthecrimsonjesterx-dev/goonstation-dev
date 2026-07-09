/obj/item/firearm/kinetic/detectiverevolver
	name = "\improper Piper .38 revolver"
	desc = "A snubnosed police-issue revolver developed by Cormorant Precision Arms. Uses .38-Special rounds. A favorite of the Detective's Union, always reliable in times of strife."
	icon_state = "detective"
	item_state = "detective"
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_REVOLVER
	ammo_cats = list(AMMO_REVOLVER_DETECTIVE)
	max_ammo_capacity = 7
	gildable = 1
	default_magazine = /obj/item/ammo/bullets/a38/stun
	fire_animation = TRUE
	recoil_strength = 10

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/revolver_38/stunners)
		src.verbs -= /obj/item/firearm/kinetic/detectiverevolver/verb/claim_colt
		..()

	pickup(mob/user)
		. = ..()
		if (user.mind?.assigned_role == "Detective")
			src.verbs |= /obj/item/firearm/kinetic/detectiverevolver/verb/claim_colt

	dropped(mob/user)
		. = ..()
		src.verbs -= /obj/item/firearm/kinetic/detectiverevolver/verb/claim_colt

	verb/claim_colt()
		set src in usr
		set category = "Local"
		set name = "Convert to Colt"

		var/datum/jobXpReward/reward = global.xpRewards["The Colt"]
		reward.try_claim(usr, FALSE)
