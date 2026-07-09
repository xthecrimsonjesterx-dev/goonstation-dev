/obj/item/firearm/kinetic/antisingularity
	desc = "An experimental rocket launcher designed to deliver various payloads in rocket format."
	name = "\improper Singularity Buster rocket launcher"
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "ntlauncher"
	item_state = "ntlauncher"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags =  TABLEPASS | CONDUCT | USEDELAY
	c_flags = EQUIPPED_WHILE_HELD | ONBACK
	w_class = W_CLASS_BULKY
	throw_speed = 2
	throw_range = 4
	force = MELEE_DMG_LARGE
	ammo_cats = list(AMMO_ROCKET_ALL)//based on the fact that it's funny to fire an RPG rocket out of this thing
	max_ammo_capacity = 1
	can_dual_wield = 0
	two_handed = 1
	muzzle_flash = "muzzle_flash_launch"
	default_magazine = /obj/item/ammo/bullets/antisingularity
	recoil_strength = 12

	New()
		ammo = new default_magazine
		ammo.amount_left = 0 // Spawn empty.
		set_current_projectile(new /datum/projectile/bullet/antisingularity)
		..()
		return

	setupProperties()
		..()
		setProperty("carried_movespeed", 0.8)
