/obj/item/firearm/kinetic/single_action/flintlock/rifle
	name = "flintlock rifle"
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "flintlock_rifle"
	item_state = "flintlock_rifle"
	ammo_cats = list(AMMO_FLINTLOCK_RIFLE)
	flags =  TABLEPASS | CONDUCT
	c_flags = ONBACK
	force = MELEE_DMG_RIFLE
	two_handed = TRUE
	w_class = W_CLASS_BULKY
	default_magazine = /obj/item/ammo/bullets/flintlock/rifle/single
	recoil_strength = 18

	New()
		..()
		set_current_projectile(new/datum/projectile/bullet/flintlock/rifle)
