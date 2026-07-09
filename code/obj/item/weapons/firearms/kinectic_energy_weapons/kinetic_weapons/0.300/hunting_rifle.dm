/obj/item/firearm/kinetic/hunting_rifle
	name = "old hunting rifle"
	desc = "The Kittiwake .308 from Cormorant Precision Arms, a classic high-powered hunting and police rifle, reliable in almost any environment. The scope is in fine condition."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "ohr"
	item_state = "ohr"
	wear_state = "ohr" // prevent empty state from breaking the worn image
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags =  TABLEPASS | CONDUCT | USEDELAY
	c_flags = ONBACK
	force = MELEE_DMG_RIFLE
	contraband = 8
	ammo_cats = list(AMMO_RIFLE_308)
	max_ammo_capacity = 4 // It's magazine-fed (Convair880).
	auto_eject = 1
	can_dual_wield = 0
	two_handed = 1
	has_empty_state = 1
	gildable = 1
	default_magazine = /obj/item/ammo/bullets/rifle_3006
	fire_animation = TRUE
	recoil_strength = 14
	recoil_max = 14
	recoil_inaccuracy_max = 20
	rarity = 3
	abilities = list(/obj/ability_button/toggle_scope)

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/rifle_3006)
		AddComponent(/datum/component/holdertargeting/sniper_scope, 8, 0, /datum/overlayComposition/sniper_scope, 'sound/weapons/scope.ogg')
		..()
