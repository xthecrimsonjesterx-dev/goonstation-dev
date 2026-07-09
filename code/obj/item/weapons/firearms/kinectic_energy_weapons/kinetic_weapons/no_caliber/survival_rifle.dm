/obj/item/firearm/kinetic/survival_rifle
	name = "\improper Efnysien survival rifle"
	desc = "A semi-automatic rifle, renowned for it's easily convertible caliber, developed by Mabinogi Firearms Company. Popular with pilots and scouts."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	icon_state = "survival_rifle_22"
	item_state = "survival_rifle"
	wear_state = "survival_rifle"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = MELEE_DMG_RIFLE
	c_flags = ONBACK
	contraband = 8
	two_handed = TRUE
	can_dual_wield = FALSE
	auto_eject = TRUE
	fire_animation = TRUE
	var/obj/item/survival_rifle_barrel/barrel = new /obj/item/survival_rifle_barrel/barrel_22

	New()
		src.set_barrel_stats(src.barrel)
		ammo = new default_magazine
		..()

	attackby(obj/item/b, mob/user)
		if (istype(b, /obj/item/survival_rifle_barrel))
			var/obj/item/survival_rifle_barrel/new_barrel = b
			src.try_swap_barrel(user, new_barrel, TRUE)
			return
		..()

	afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
		if (istype(target, /obj/item/survival_rifle_barrel))
			var/obj/item/survival_rifle_barrel/new_barrel = target
			src.try_swap_barrel(user, new_barrel, FALSE)
			return
		..()

	proc/try_swap_barrel(var/mob/user, var/obj/item/survival_rifle_barrel/new_barrel, var/holding_barrel)
		if (istype(new_barrel, src.barrel.type))
			user.show_text("There's no point swapping the barrel. They're the same caliber!", "red")
			return
		// Eject the mag first so we don't dissapear ammo
		src.eject_magazine(user)

		// Swap the barrel objs
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		user.visible_message("[user] begins swapping the barrel on [his_or_her(user)] [src].", "You begin swapping the barrel on \the [src].")
		SETUP_GENERIC_ACTIONBAR(user, src, 5 SECONDS, /obj/item/firearm/kinetic/survival_rifle/proc/swap_barrel, list(user, new_barrel, holding_barrel), src.icon, src.icon_state,"[user] finishes swapping the barrel on [his_or_her(user)] [src].", null)
		return

	proc/swap_barrel(var/mob/user, var/obj/item/survival_rifle_barrel/new_barrel, var/holding_barrel)
		if (holding_barrel)
			// Drop the barrel if you're holding it, so we can set_loc on it
			user.drop_item()
		new_barrel.set_loc(src)
		user.put_in_hand_or_drop(src.barrel)
		src.barrel = new_barrel

		// Set the gun's stats to the new barrel
		src.set_barrel_stats(barrel)
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)

	proc/set_barrel_stats(var/obj/item/survival_rifle_barrel/barrel)
		src.icon_state = barrel.rifle_icon_state
		src.ammo_cats = barrel.ammo_cats
		src.max_ammo_capacity = barrel.max_ammo_capacity
		src.default_magazine = barrel.default_magazine
		src.recoil_strength = barrel.recoil_strength
		set_current_projectile(new barrel.default_projectile)
		src.projectiles = list(current_projectile)
		src.desc = desc = "A semi-automatic rifle, renowned for it's easily convertible caliber, developed by Mabinogi Firearms Company. It's currently fitted with a [src.barrel.name]."
		src.tooltip_rebuild = TRUE


