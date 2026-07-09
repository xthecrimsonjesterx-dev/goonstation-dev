/obj/item/firearm/kinetic/single_action/flintlock
	name = "flintlock pistol"
	desc = "In recent years, flintlocks have again become increasingly popular among space privateers due to the replacement of the gun flint with a shaped plasma crystal, resulting in a significantly higher firepower."
	icon_state = "flintlock"
	item_state = "flintlock"
	fire_animation = TRUE
	has_uncocked_state = TRUE
	force = MELEE_DMG_PISTOL
	ammo_cats = list(AMMO_FLINTLOCK)
	max_ammo_capacity = 1
	default_magazine = /obj/item/ammo/bullets/flintlock/single
	recoil_strength = 12

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/flintlock)
		..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		sleep(0.3)
		if (src.canshoot(user) && !isghostdrone(user))
			var/obj/effects/flintlock_smoke/E = new /obj/effects/flintlock_smoke(get_turf(src))
			var/dir_x = target.x + POX/32 - start.x - POY/32
			var/dir_y = target.y - start.y
			var/len = vector_magnitude(dir_x, dir_y)
			dir_x /= len
			dir_y /= len
			E.setdir(dir_x, dir_y)
		. = ..()
