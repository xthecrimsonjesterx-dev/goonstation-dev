/obj/item/firearm/kinetic/blowgun
	name = "flute"
	desc = "Wait, this isn't a flute. It's a blowgun!"
	icon = 'icons/obj/items/guns/syringe.dmi'
	icon_state = "blowgun"
	inhand_image_icon = 'icons/mob/inhand/hand_weapons.dmi'
	item_state = "c_tube"
	force = MELEE_DMG_PISTOL
	contraband = 2
	ammo_cats = list(AMMO_DART_ALL)
	max_ammo_capacity = 1.
	can_dual_wield = 0
	hide_attack = ATTACK_FULLY_HIDDEN
	w_class = W_CLASS_SMALL
	muzzle_flash = "muzzle_flash_launch"
	default_magazine = /obj/item/ammo/bullets/tranq_darts/blow_darts/single
	recoil_strength = 4
	click_sound = null

	tranq
		default_magazine = /obj/item/ammo/bullets/tranq_darts/blow_darts/thio/single

	New()
		ammo = new default_magazine
		set_current_projectile(src.ammo.ammo_type)
		..()
