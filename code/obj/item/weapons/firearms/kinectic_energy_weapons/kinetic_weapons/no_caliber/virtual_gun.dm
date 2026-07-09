/obj/item/firearm/kinetic/vgun
	name = "virtual pistol"
	desc = "This thing would be better if it wasn't such a piece of shit."
	icon = 'icons/obj/items/guns/energy.dmi'
	icon_state = "railgun"
	force = MELEE_DMG_PISTOL
	contraband = 0
	max_ammo_capacity = 200
	default_magazine = /obj/item/ammo/bullets/vbullet

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/vbullet)
		..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		var/turf/T = get_turf(src)

		if (!istype(T.loc, /area/sim))
			boutput(user, SPAN_ALERT("You can't use the guns outside of the combat simulation, fuckhead!"))
			return
		else
			..()

/obj/item/firearm/kinetic/revolver/vr
	icon = 'icons/effects/VR.dmi'
