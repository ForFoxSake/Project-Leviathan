/obj/item/ammo_disk
	name = "ammo disk"
	desc = "Contains ammunition production data."
	icon = 'icons/obj/discs_vr.dmi'
	icon_state = "data-purple"
	item_state = "card-id"
	w_class = ITEMSIZE_SMALL
	matter = list(DEFAULT_WALL_MATERIAL = 30, "glass" = 10)
	var/obj/item/ammo_casing/blueprint = null
	var/ammo_name = null
	var/hidden = FALSE // For hackable designs, I guess?
	var/debug = FALSE // Sneaky variable to allow admin hax / testing

/obj/item/ammo_disk/Initialize()
	. = ..()
	if (blueprint)
		blueprint = new blueprint(src)
	update_name()

/obj/item/ammo_disk/proc/update_name()
	if (!ammo_name && blueprint && blueprint.caliber)
		ammo_name = blueprint.caliber
	if (ammo_name)
		if (hidden)
			name = "illicit [initial(name)] ([ammo_name])"
		else
			name = "[initial(name)] ([ammo_name])"
	else
		name = "[initial(name)] (blank)"

// Pre-configured ammo disks below!

// .357
/obj/item/ammo_disk/a357
	blueprint = /obj/item/ammo_casing/a357

// .38
/obj/item/ammo_disk/a38
	ammo_name = ".38"
	blueprint = /obj/item/ammo_casing/a38

/obj/item/ammo_disk/a38/rubber
	ammo_name = ".38 Rubber"
	blueprint = /obj/item/ammo_casing/a38/rubber

/obj/item/ammo_disk/a38/emp
	ammo_name = ".38 Haywire"
	blueprint = /obj/item/ammo_casing/a38/emp

/obj/item/ammo_disk/a38/hacked
	hidden = TRUE

// .44
/obj/item/ammo_disk/a44
	blueprint = /obj/item/ammo_casing/a44

/obj/item/ammo_disk/a44/rubber
	ammo_name = ".44 Rubber"
	blueprint = /obj/item/ammo_casing/a44/rubber

/obj/item/ammo_disk/a44/rifle
	ammo_name = ".44 Rifle"
	blueprint = /obj/item/ammo_casing/a44/rifle

/obj/item/ammo_disk/a44/hacked
	hidden = TRUE

// .75 Gyrojet
/obj/item/ammo_disk/a75
	ammo_name = ".75 Gyrojet"
	blueprint = /obj/item/ammo_casing/a75

// 9mm
/obj/item/ammo_disk/a9mm
	ammo_name = "9mm FMJ"
	blueprint = /obj/item/ammo_casing/a9mm

/obj/item/ammo_disk/a9mm/ap
	ammo_name = "9mm AP"
	blueprint = /obj/item/ammo_casing/a9mm/ap

/obj/item/ammo_disk/a9mm/hp
	ammo_name = "9mm JHP"
	blueprint = /obj/item/ammo_casing/a9mm/hp

/obj/item/ammo_disk/a9mm/flash
	ammo_name = "9mm Flash"
	blueprint = /obj/item/ammo_casing/a9mm/flash

/obj/item/ammo_disk/a9mm/rubber
	ammo_name = "9mm Rubber"
	blueprint = /obj/item/ammo_casing/a9mm/rubber

/obj/item/ammo_disk/a9mm/practice
	ammo_name = "9mm Practice"
	blueprint = /obj/item/ammo_casing/a9mm/practice

/obj/item/ammo_disk/a9mm/hacked
	hidden = TRUE

// .45
/obj/item/ammo_disk/a45
	ammo_name = ".45 FMJ"
	blueprint = /obj/item/ammo_casing/a45

/obj/item/ammo_disk/a45/ap
	ammo_name = ".45 AP"
	blueprint = /obj/item/ammo_casing/a45/ap

/obj/item/ammo_disk/a45/hp
	ammo_name = ".45 JHP"
	blueprint = /obj/item/ammo_casing/a45/hp

/obj/item/ammo_disk/a45/flash
	ammo_name = ".45 Flash"
	blueprint = /obj/item/ammo_casing/a45/flash

/obj/item/ammo_disk/a45/rubber
	ammo_name = ".45 Rubber"
	blueprint = /obj/item/ammo_casing/a45/rubber

/obj/item/ammo_disk/a45/practice
	ammo_name = ".45 Practice"
	blueprint = /obj/item/ammo_casing/a45/practice

/obj/item/ammo_disk/a45/emp
	ammo_name = ".45 Haywire"
	blueprint = /obj/item/ammo_casing/a45/emp

/obj/item/ammo_disk/a45/hacked
	hidden = TRUE

// 10mm
/obj/item/ammo_disk/a10mm
	ammo_name = "10mm"
	blueprint = /obj/item/ammo_casing/a10mm

/obj/item/ammo_disk/a10mm/emp
	ammo_name = "10mm Haywire"
	blueprint = /obj/item/ammo_casing/a10mm/emp

/obj/item/ammo_disk/a10mm/hacked
	hidden = TRUE

// 12g
/obj/item/ammo_disk/a12g
	ammo_name = "12g Slug"
	blueprint = /obj/item/ammo_casing/a12g

/obj/item/ammo_disk/a12g/pellet
	ammo_name = "12g Pellet"
	blueprint = /obj/item/ammo_casing/a12g/pellet

/obj/item/ammo_disk/a12g/blank
	ammo_name = "12g Blank"
	blueprint = /obj/item/ammo_casing/a12g/blank

/obj/item/ammo_disk/a12g/practice
	ammo_name = "12g Practice"
	blueprint = /obj/item/ammo_casing/a12g/practice

/obj/item/ammo_disk/a12g/beanbag
	ammo_name = "12g Beanbag"
	blueprint = /obj/item/ammo_casing/a12g/beanbag

/obj/item/ammo_disk/a12g/stunshell
	ammo_name = "12g Stun"
	blueprint = /obj/item/ammo_casing/a12g/stunshell

/obj/item/ammo_disk/a12g/flash
	ammo_name = "12g Flash"
	blueprint = /obj/item/ammo_casing/a12g/flash

/obj/item/ammo_disk/a12g/emp
	ammo_name = "12g Ion"
	blueprint = /obj/item/ammo_casing/a12g/emp

/obj/item/ammo_disk/a12g/hacked
	hidden = TRUE

/obj/item/ammo_disk/a12g/pellet/hacked
	hidden = TRUE

// 7.62mm
/obj/item/ammo_disk/a762
	ammo_name = "7.62mm FMJ"
	blueprint = /obj/item/ammo_casing/a762

/obj/item/ammo_disk/a762/ap
	ammo_name = "7.62mm AP"
	blueprint = /obj/item/ammo_casing/a762/ap

/obj/item/ammo_disk/a762/hp
	ammo_name = "7.62mm JHP"
	blueprint = /obj/item/ammo_casing/a762/hp

/obj/item/ammo_disk/a762/blank
	ammo_name = "7.62mm Blank"
	blueprint = /obj/item/ammo_casing/a762/blank

/obj/item/ammo_disk/a762/practice
	ammo_name = "7.62mm Practice"
	blueprint = /obj/item/ammo_casing/a762/practice

/obj/item/ammo_disk/a762/hunter
	ammo_name = "7.62mm Hunting"
	blueprint = /obj/item/ammo_casing/a762/hunter

// 5.45mm
/obj/item/ammo_disk/a545
	ammo_name = "5.45mm FMJ"
	blueprint = /obj/item/ammo_casing/a545

/obj/item/ammo_disk/a545/ap
	ammo_name = "5.45mm AP"
	blueprint = /obj/item/ammo_casing/a545/ap

/obj/item/ammo_disk/a545/hp
	ammo_name = "5.45mm JHP"
	blueprint = /obj/item/ammo_casing/a545/hp

/obj/item/ammo_disk/a545/blank
	ammo_name = "5.45mm Blank"
	blueprint = /obj/item/ammo_casing/a545/blank

/obj/item/ammo_disk/a545/practice
	ammo_name = "5.45mm Practice"
	blueprint = /obj/item/ammo_casing/a545/practice

/obj/item/ammo_disk/a545/hunter
	ammo_name = "5.45mm Hunting"
	blueprint = /obj/item/ammo_casing/a545/hunter

// 14.5mm
/obj/item/ammo_disk/a145
	ammo_name = "14.5mm"
	blueprint = /obj/item/ammo_casing/a145

/obj/item/ammo_disk/a145/highvel
	ammo_name = "14.5mm Sabot"
	blueprint = /obj/item/ammo_casing/a145/highvel

// Caps. :)
/obj/item/ammo_disk/cap
	ammo_name = "Cap"
	blueprint = /obj/item/ammo_casing/cap