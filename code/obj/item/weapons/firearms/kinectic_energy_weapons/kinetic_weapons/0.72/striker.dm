/obj/item/firearm/kinetic/striker
	name = "\improper Striker-7"
	desc = "A terrifying looking drum shotgun, legally declared as a 'destructive device'."
	icon = 'icons/obj/items/guns/kinetic48x32.dmi'
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "striker12"
	item_state = "striker"
	flags =  TABLEPASS | CONDUCT
	c_flags = EQUIPPED_WHILE_HELD
	force = MELEE_DMG_RIFLE
	contraband = 7
	ammo_cats = list(AMMO_SHOTGUN_AUTOMATIC)
	max_ammo_capacity = 7
	max_move_amount = 1
	reload_cooldown = 8 DECI SECONDS
	auto_eject = FALSE
	can_dual_wield = FALSE
	two_handed = TRUE
	has_empty_state = FALSE
	fire_animation = TRUE
	default_magazine = /obj/item/ammo/bullets/a12/bird/seven

	var/is_loading = FALSE //are we reloading?

	shoot(var/atom/target, var/atom/start, var/mob/user, var/POX, var/POY, var/is_dual_wield)
		if (src.is_loading)
			return
		if (casings_to_eject > 0) //bully gun nerds 2day (striker doesnt auto-	eject your first shell)
			auto_eject = TRUE
		else
			auto_eject = FALSE
		..()


	attackby(obj/item/b, mob/user)
		if (istype(b, /obj/item/ammo/bullets) && !src.is_loading)
			if (!ON_COOLDOWN(src, "reload_spam", src.reload_cooldown))
				boutput(user, "<span class='alert'>It's too [pick("fiddly","frustrating","awkward")] to load \the [src] like this! You'll need to lower it first.</span>")
			return
		..()

	canshoot(mob/user)
		return(..() && !src.is_loading)

	New()
		ammo = new default_magazine
		set_current_projectile(new /datum/projectile/special/spreader/uniform_burst/bird12)
		..()

	attack_self(mob/user as mob)
		if (is_loading)
			if (setTwoHanded(TRUE))
				is_loading = FALSE
				src.transform = src.transform.Turn(-45)
				boutput(user, "<span class='alert'>You raise the striker, ready to shoot!</span>")
			else
				boutput(user, "<span class='alert'>Can't switch to 2-handed while your other hand is full.</span>")
		else
			boutput(user, "<span class='alert'>You lower the [src] for reloading.</span>")
			setTwoHanded(FALSE)
			is_loading = TRUE
			src.transform = src.transform.Turn(45)
