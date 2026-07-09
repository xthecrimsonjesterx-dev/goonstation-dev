/obj/item/firearm/kinetic/draco
	name = "\improper Draco Pistol"
	desc = "A full size 7.62x39mm 'Pistol'. With no stock. You should shoot this in bursts."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "draco"
	item_state = "draco"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = MELEE_DMG_RIFLE
	contraband = 8
	ammo_cats = list(AMMO_AUTO_762)
	spread_angle = 3
	shoot_delay = 3
	max_ammo_capacity = 30
	auto_eject = 1
	can_dual_wield = 0
	two_handed = 1
	gildable = 1
	default_magazine = /obj/item/ammo/bullets/akm/draco
	fire_animation = TRUE
	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	w_class = W_CLASS_BULKY
	recoil_strength = 7
	recoil_stacking_enabled = TRUE
	recoil_stacking_max_stacks = 4 //make this thing go HARD if you hold it down
	recoil_stacking_amount = 3
	recoil_inaccuracy_max = 25
	recoil_max = 100 // can eat more recoil for worse effects
	icon_recoil_cap = 30


	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/draco)
		AddComponent(/datum/component/holdertargeting/fullauto, 1.6)
		..()

/obj/item/firearm/kinetic/draco/empty

	New()
		..()
		ammo.amount_left = 0
		UpdateIcon()
