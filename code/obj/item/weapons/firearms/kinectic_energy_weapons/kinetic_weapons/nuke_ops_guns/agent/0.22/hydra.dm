/obj/item/firearm/kinetic/pistol/smart/hydra_mkII
	name = "\improper Hydra smart pistol"
	desc = "A pistol capable of locking onto multiple targets and firing on them in rapid sequence. \"Anderson Para-Munitions\" is engraved on the slide."
	icon_state = "smartgun"
	max_ammo_capacity = 20
	ammo_cats = list(AMMO_PISTOL_22)
	default_magazine = /obj/item/ammo/bullets/bullet_22/smartgun
	ammobag_magazines = list(/obj/item/ammo/bullets/bullet_22/smartgun)
	recoil_enabled = 0

	New()
		..()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/bullet_22/smartgun)
		AddComponent(/datum/component/holdertargeting/smartgun/nukeop, 4)


/datum/component/holdertargeting/smartgun/nukeop/is_valid_target(mob/user, mob/M)
	return ..() && !(istype(M.get_id(), /obj/item/card/id/syndicate) || isnukeopgunbot(M) || istype(M, /mob/living/critter/robotic/sawfly))
