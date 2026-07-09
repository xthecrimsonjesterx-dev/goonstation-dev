/obj/item/firearm/kinetic/four_bore_albatross
	name = "\improper Albatross four-bore rifle"
	desc = "A behemoth of a scoped rifle developed by Cormorant Precision Arms. Intended for suppression or elimination of monstrous targets."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "four_bore"
	item_state = "four_bore"
	w_class = W_CLASS_BULKY
	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = EQUIPPED_WHILE_HELD | ONBACK
	slowdown = 10
	slowdown_time = 8
	force = MELEE_DMG_RIFLE
	two_handed = TRUE
	can_dual_wield = FALSE
	contraband = 7
	ammo_cats = list(AMMO_FOUR_BORE)
	spread_angle = 2
	shoot_delay = 0.8 SECONDS
	max_ammo_capacity = 2
	default_magazine = /obj/item/ammo/bullets/four_bore/stun/two
	fire_animation = FALSE
	recoil_strength = 20
	abilities = list(/obj/ability_button/toggle_scope)

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/four_bore_stunners)
		AddComponent(/datum/component/holdertargeting/sniper_scope, 12, 512, /datum/overlayComposition/sniper_scope, 'sound/weapons/scope.ogg')
		..()

	setupProperties()
		..()
		setProperty("carried_movespeed", 0.6)
