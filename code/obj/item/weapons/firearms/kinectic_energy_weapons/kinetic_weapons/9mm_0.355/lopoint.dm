/obj/item/firearm/kinetic/lopoint
	desc = "Cheap and disposable, having a Lo-Point is the first step towards a life of crime. Just remember to throw it away when you're done."
	name = "Lo-Point"
	icon_state = "hipoint"
	item_state = "hipoint"
	shoot_delay = 4
	spread_angle = 3
	throwforce = 14 // literally throw it away
	w_class = W_CLASS_SMALL
	force = MELEE_DMG_PISTOL
	ammo_cats = list(AMMO_PISTOL_9MM)
	fire_animation = TRUE
	max_ammo_capacity = 10
	auto_eject = TRUE
	has_empty_state = TRUE
	gildable = FALSE
	default_magazine = /obj/item/ammo/bullets/bullet_9mm/lopoint

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/bullet_9mm)
		RegisterSignal(src, COMSIG_MOVABLE_HIT_THROWN, PROC_REF(selfdestruct))
		..()

	// teehee. get it? 'throw' it away?
	proc/selfdestruct(obj/item/parent, atom/target, mob/user, reach, params)
		if(!isliving(target) || src.ammo?.amount_left > 0)
			return
		var/mob/living/H = target
		H.changeStatus("knockdown", 3 SECONDS)
		H.force_laydown_standup()
		src.visible_message("<span class='alert'>The [src] hits [target] <b>hard</b>, shattering into dozens of tiny pieces!</span>")
		playsound(src.loc, 'sound/impact_sounds/Generic_Hit_Heavy_1.ogg', 40, TRUE)
		var/obj/decal/cleanable/gib = make_cleanable( /obj/decal/cleanable/machine_debris,src.loc)
		gib.streak_cleanable()
		qdel(src)
