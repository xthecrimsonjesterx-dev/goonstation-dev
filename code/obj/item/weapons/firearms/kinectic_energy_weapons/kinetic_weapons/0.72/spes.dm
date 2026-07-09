/obj/item/firearm/kinetic/spes
	name = "SPES-12"
	desc = "An expensive imported combat shotgun, popular with frontier militias and private military operators."
	icon_state = "spas"
	item_state = "spas"
	force = MELEE_DMG_RIFLE
	contraband = 7
	ammo_cats = list(AMMO_SHOTGUN_AUTOMATIC)
	max_ammo_capacity = 8
	auto_eject = 1
	can_dual_wield = 0
	default_magazine = /obj/item/ammo/bullets/a12
	ammobag_magazines = list(/obj/item/ammo/bullets/a12, /obj/item/ammo/bullets/aex)
	ammobag_restock_cost = 2
	recoil_strength = 10
	recoil_max = 60

	New()
		if(prob(10))
			name = pick("SPEZZ-12", "SPESS-12", "SPETZ-12", "SPOCK-12", "SCHPATZL-12", "SABRINA-12", "SAURUS-12", "SABER-12", "SOSIG-12", "DINOHUNTER-12", "COMBAT-12", "SHOTASS-12", "SPES-12", "SHOOTY-12", "BLAM-12", "SPICY-12", "ANTKILLER-12", "SLAPS-12", "SPAGOOTER-12", "MARTIANSLAYER-12")
		ammo = new default_magazine
		set_current_projectile(new/datum/projectile/bullet/a12)
		..()

	custom_suicide = 1
	suicide(var/mob/living/carbon/human/user as mob)
		if (!src.user_can_suicide(user))
			return 0
		if (!istype(user) || !src.canshoot(user))//!hasvar(user,"organHolder")) STOP IT STOP IT HOLY SHIT STOP WHY DO YOU USE HASVAR FOR THIS, ONLY HUMANS HAVE ORGANHOLDERS
			return 0

		src.process_ammo(user)
		var/hisher = his_or_her(user)
		user.visible_message(SPAN_ALERT("<b>[user] places [src]'s barrel in [hisher] mouth and pulls the trigger with [hisher] foot!</b>"))
		var/obj/head = user.organHolder.drop_organ("head")
		qdel(head)
		playsound(src, 'sound/weapons/shotgunshot.ogg', 100, TRUE)
		var/obj/decal/cleanable/blood/gibs/gib = make_cleanable( /obj/decal/cleanable/blood/gibs,get_turf(user))
		gib.streak_cleanable(turn(user.dir,180))
		health_update_queue |= user
		return 1

	engineer
		name = "SPES-6"
		ammobag_magazines = list(/obj/item/ammo/bullets/a12/weak, /obj/item/ammo/bullets/a12)
		New()
			..()
			src.name = replacetext("[src.name]", "12", "6") //only half as good
			ammo = new/obj/item/ammo/bullets/a12/weak
			set_current_projectile(new/datum/projectile/bullet/a12/weak)
