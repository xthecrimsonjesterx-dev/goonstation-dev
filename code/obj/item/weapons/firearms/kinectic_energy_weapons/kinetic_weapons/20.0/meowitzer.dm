/obj/item/firearm/kinetic/meowitzer
	name = "\improper Meowitzer"
	desc = "It purrs gently in your hands."
	icon = 'icons/obj/items/mining.dmi'
	icon_state = "blaster"

	color = "#ff7b00"
	force = MELEE_DMG_LARGE
	ammo_cats = list(AMMO_HOWITZER)
	max_ammo_capacity = 1
	auto_eject = 0
	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	spread_angle = 0
	can_dual_wield = 0
	slowdown = 0
	slowdown_time = 0
	two_handed = 1
	w_class = W_CLASS_BULKY
	default_magazine = /obj/item/ammo/bullets/meowitzer
	recoil_strength = 17

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/special/meowitzer)
		..()

	afterattack(atom/A, mob/user as mob)
		if(src.ammo.amount_left < max_ammo_capacity && istype(A, /mob/living/critter/small_animal/cat))
			src.ammo.amount_left += 1
			user.visible_message(SPAN_ALERT("[user] loads \the [A] into \the [src]."), SPAN_ALERT("You load \the [A] into \the [src]."))
			src.current_projectile.icon_state = A.icon_state //match the cat sprite that we load
			qdel(A)
			return
		else
			..()

/obj/item/firearm/kinetic/meowitzer/inert
	default_magazine = /obj/item/ammo/bullets/meowitzer
	New()
		..()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/special/meowitzer/inert)
