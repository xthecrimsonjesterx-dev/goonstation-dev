/obj/item/firearm/kinetic/pumpweapon/ks23
	name = "Kuvalda Carbine"
	desc = "A *huge* 4-gauge shotgun built with a repurposed 23mm cannon barrel. It's unlikely there's any moral justification for using this against humans."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "ks23"
	item_state = "ks23"
	wear_state = "ks23" // prevent empty state from breaking the worn image
	base_icon_state = "ks23"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	flags = TABLEPASS | CONDUCT | USEDELAY
	c_flags = ONBACK
	force = MELEE_DMG_RIFLE
	contraband = 6
	is_heavy = TRUE
	ammo_cats = list(AMMO_KUVALDA)
	max_ammo_capacity = 4
	reload_cooldown = 12 DECI SECONDS
	auto_eject = FALSE
	can_dual_wield = FALSE
	two_handed = TRUE
	has_empty_state = TRUE
	gildable = TRUE
	recoil_reset = 15 DECI SECONDS
	default_magazine = /obj/item/ammo/bullets/kuvalda
	recoil_strength = 18
	recoil_max = 40
	max_move_amount = 1
	rack_delay = 5
	pumpsound = 'sound/weapons/kuvalda_pull2.ogg'
	pushsound = 'sound/weapons/kuvalda_push2.ogg'
	empty
		default_magazine = /obj/item/ammo/bullets/kuvalda/empty

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/special/spreader/uniform_burst/kuvalda_shrapnel)
		..()
