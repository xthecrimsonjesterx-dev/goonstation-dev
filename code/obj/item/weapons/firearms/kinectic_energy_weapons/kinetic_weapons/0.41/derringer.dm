/obj/item/firearm/kinetic/derringer
	name = "derringer"
	desc = "The Deadlock .41, a small and easy-to-hide gun from Cormorant Precision Arms. Loaded with 2 shots, brutal at close range."
	icon_state = "derringer"
	force = MELEE_DMG_PISTOL
	ammo_cats = list(AMMO_PISTOL_41)
	max_ammo_capacity = 2
	w_class = W_CLASS_SMALL
	muzzle_flash = null
	default_magazine = /obj/item/ammo/bullets/derringer
	fire_animation = TRUE
	HELP_MESSAGE_OVERRIDE(null)
	recoil_strength = 6

	get_help_message(dist, mob/user)
		var/keybind = "Default CTRL + W"
		var/datum/keymap/current_keymap = user.client.keymap
		for (var/key in current_keymap.keys)
			if (current_keymap.keys[key] == "wink")
				keybind = current_keymap.unparse_keybind(key)
				break
		return "Hit the gun on a piece of clothing to hide it inside. Retrieve it by using the <b>*wink</b> ([keybind]) emote."

	afterattack(obj/O as obj, mob/user as mob)
		if (O.loc == user && O != src && istype(O, /obj/item/clothing))
			boutput(user, SPAN_HINT("You hide the derringer inside \the [O]. (Use the wink emote while wearing the clothing item to retrieve it.)"))
			user.u_equip(src)
			src.set_loc(O)
			src.dropped(user)
		else
			..()
		return

	New()
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/derringer)
		..()

/obj/item/firearm/kinetic/derringer/empty
	New()
		..()
		ammo.amount_left = 0
		UpdateIcon()
