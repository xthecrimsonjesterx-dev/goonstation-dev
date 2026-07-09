// WIP //////////////////////////////////
/obj/item/firearm/kinetic/antiair
	name = "MORS-X anti-air rifle"
	desc = "A ruthlessly powerful rifle firing .50 caliber frag rounds. Built to swat down UFOs out of the sky."
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "antiair"
	item_state = "antiair"
	wear_image_icon = 'icons/mob/clothing/back.dmi'
	force = 10
	contraband = 50
	rarity = 5
	ammo_cats = list(AMMO_DEAGLE) // whatever close enough
	max_ammo_capacity = 4
	auto_eject = 1
	gildable = 1

	flags =  TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY
	c_flags = EQUIPPED_WHILE_HELD | ONBACK

	can_dual_wield = 0

	slowdown = 5
	slowdown_time = 10

	recoil_strength = 19
	recoil_inaccuracy_max = 12
	icon_recoil_cap = 30

	two_handed = 1
	w_class = W_CLASS_BULKY
	muzzle_flash = "muzzle_flash_launch"
	abilities = list(/obj/ability_button/toggle_scope)


	New()
		ammo = new/obj/item/ammo/bullets/antiair
		set_current_projectile(new/datum/projectile/special/spreader/buckshot_burst/antiair)
		AddComponent(/datum/component/holdertargeting/sniper_scope, 10, 0, /datum/overlayComposition/sniper_scope, 'sound/weapons/scope.ogg')
		..()


	setupProperties()
		..()
		setProperty("carried_movespeed", 1)

/obj/item/firearm/kinetic/sawnoff
	name = "\improper Fulmar 1881 coach gun"
	desc = "A stylish historic-reproduction short-barreled shotgun from Cormorant Precision Arms, a favorite of the Bartender's Guild."
	inhand_image_icon = 'icons/mob/inhand/hand_guns.dmi'
	item_state = "coachgun"
	icon_state = "coachgun"
	force = MELEE_DMG_REVOLVER //it's one handed, no reason for it to be rifle-levels of melee damage
	contraband = 4
	ammo_cats = list(AMMO_SHOTGUN_ALL)
	max_ammo_capacity = 2
	auto_eject = FALSE
	can_dual_wield = FALSE
	two_handed = FALSE
	add_residue = TRUE
	gildable = TRUE
	sound_load_override = 'sound/weapons/gunload_sawnoff.ogg'
	recoil_strength = 10
	recoil_max = 60
	default_magazine = /obj/item/ammo/bullets/abg/punchy/two
	var/broke_open = FALSE
	var/shells_to_eject = 0

	New() //uses a special box of ammo that only starts with 2 shells to prevent issues with overloading
		if (prob(25))
			name = pick ("Bessie", "Mule", "Loud Louis", "Boomstick", "Coach Gun", "Shorty", "Sawn-off Shotgun", "Street Sweeper", "Street Howitzer", "Big Boy", "Slugger", "Closing Time", "Garbage Day", "Rooty Tooty Point and Shooty", "Twin 12 Gauge", "Master Blaster", "Ass Blaster", "Blunderbuss", "Dr. Bullous' Thunder-Clapper", "Super Shotgun", "Insurance Policy", "Last Call", "Super-Duper Shotgun")
		else if (prob(1))
			desc = "Actually the Fulmar 1881 can't be called a true coach gun if it's sawn off, that would by definition make it a sawn-off. Meh, semantics."
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/abg/punchy)
		..()

	birdshot
		default_magazine = /obj/item/ammo/bullets/a12/bird/two
		New()
			..()
			set_current_projectile(new/datum/projectile/special/spreader/uniform_burst/bird12)

	update_icon()
		. = ..()
		src.icon_state = initial(src.icon_state) + (gilded ? "-golden" : "") + (!src.broke_open ? "" : "-empty" )

	canshoot(mob/user)
		if (!src.broke_open)
			return TRUE
		..()

	shoot(turf/target, turf/start, mob/user, POX, POY, is_dual_wield, atom/called_target = null)
		if (src.broke_open)
			src.toggle_action(user)
			if (src.ammo.amount_left > 0)
				user.visible_message(SPAN_ALERT("<b>[user]</b> slams shut [src] and fires in one fluid motion. Wow!"))
		if (!src.broke_open && src.ammo.amount_left > 0)
			src.shells_to_eject++
		..()

	attack_self(mob/user)
		src.toggle_action(user)
		..()

	attackby(obj/item/I, mob/user)
		if (istype(I, /obj/item/ammo/bullets) && !src.broke_open)
			boutput(user, SPAN_ALERT("You can't load shells into the chambers! You'll have to open [src] first!"))
			return
		..()

	attack_hand(mob/user)
		if (!src.broke_open && user.find_in_hand(src))
			boutput(user, SPAN_ALERT("[src] is still closed, you need to open the action to take the shells out!"))
			return
		..()

	alter_projectile(obj/projectile/P)
		. = ..()
		P.proj_data.shot_sound = 'sound/weapons/sawnoff.ogg'

	on_spin_emote(mob/living/carbon/human/user)
		if(src.broke_open) // Only allow spinning to close the gun, doesn't make as much sense spinning it open.
			src.toggle_action(user)
			user.visible_message(SPAN_ALERT("<b>[user]</b> snaps shut [src] with a [pick("spin", "twirl")]!"))
		. = ..()

	proc/toggle_action(mob/user)
		if (!src.broke_open)
			src.casings_to_eject = src.shells_to_eject

			if (src.casings_to_eject > 0) //this code exists because without it the gun ejects double the amount of shells
				src.ejectcasings()
				src.shells_to_eject = 0
		src.broke_open = !src.broke_open

		playsound(user.loc, 'sound/weapons/gunload_click.ogg', 15, TRUE)

		UpdateIcon()

/obj/item/firearm/kinetic/sawnoff/long_barrel
	name = "\improper Double Barrel Shotgun"
	desc = "A bloody and worn double barreled shotgun. Details indicate recent usage in a last stand fight."
	item_state = "double_barrel"
	icon = 'icons/obj/items/guns/kinetic64x32.dmi'
	icon_state = "double_barrel"
	gildable = FALSE
	recoil_strength = 20
	two_handed = TRUE
	contraband = 5
	force = MELEE_DMG_RIFLE
	default_magazine = /obj/item/ammo/bullets/a12/bird/two

	New()
		..()
		src.name = "\improper Double Barrel Shotgun"
		if (prob(25))
			src.name = pick("Last Stand", "Zombie Slayer", "Head Popper")
		set_current_projectile(new/datum/projectile/special/spreader/uniform_burst/bird12)
	alter_projectile(obj/projectile/P)
		. = ..()
		P.proj_data.shot_sound = 'sound/weapons/long_barrel.ogg'
