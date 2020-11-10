/* TUTORIAL
	"icon" is the file with the HUD/ground icon for the item
	"icon_state" is the iconstate in this file for the item
	"icon_override" is the file with the on-mob icons, can be the same file (Except for glasses, shoes, and masks.)
	"item_state" is the iconstate for the on-mob icons:
		item_state_s is used for worn uniforms on mobs
		item_state_r and item_state_l are for being held in each hand

	"item_state_slots" can replace "item_state", it is a list:
		item_state_slots["slotname1"] = "item state for that slot"
		item_state_slots["slotname2"] = "item state for that slot"
*/
/* TEMPLATE
//ckey:Character Name
/obj/item/clothing/type/fluff/charactername
	name = ""
	desc = ""

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "myicon"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "myicon"

*/

// --- --- MISC GENERAL USE SECTION --- --- \\

//For general use
/obj/item/clothing/accessory/fluff/smilepin
	name = "Smiley Pin"
	desc = "A pin with a stupid grin on its face"

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "smilepin"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	overlay_state = "" //They don't have one

//For general use
/obj/item/clothing/accessory/fluff/heartpin
	name = "Love Pin"
	desc = "A cute heart pin."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "heartpin"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	overlay_state = "" //They don't have one

//HOS Hardsuit
/obj/item/clothing/suit/space/void/security/fluff/hos // ToDo: Rig version.
	name = "\improper prototype voidsuit"
	desc = "A customized security voidsuit made to match the Head of Operations' obession with black. Has additional composite armor."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "rig-hos"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "rig-hos_mob"

	species_restricted = null

//HOS Hardsuit Helmet
/obj/item/clothing/head/helmet/space/void/security/fluff/hos // ToDo: Rig version.
	name = "\improper prototype voidsuit helmet"
	desc = "A customized security voidsuit helmet customized to include the Head of Operations' signature hat. Has additional composite armor."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "rig0-hos"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "rig0-hos_mob"

	species_restricted = null

/obj/item/clothing/shoes/black/cuffs
	name = "gilded leg wraps"
	desc = "Ankle coverings for digitigrade creatures. Gilded!"
	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "gildedcuffs"

	icon_override = 'icons/vore/custom_onmob_vr.dmi'
	item_icons = list()

	body_parts_covered = 0

/obj/item/clothing/shoes/black/cuffs/red
	name = "red leg wraps"
	desc = "Ankle coverings for digitigrade creatures. Red!"
	icon_state = "redcuffs"

/obj/item/clothing/shoes/black/cuffs/blue
	name = "blue leg wraps"
	desc = "Ankle coverings for digitigrade creatures. Blue!"
	icon_state = "bluecuffs"

// Departamental Swimsuits, I guess???

/obj/item/clothing/under/swimsuit/fluff/
	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/fluff/engineering
	name = "Engineering Swimsuit"
	desc = "It's an orange high visibility swimsuit worn by engineers. It lacks radiation, or any, shielding."
	icon_state = "swimsuit_engineering"
	item_state = "swimsuit_engineering_mob"

/obj/item/clothing/under/swimsuit/fluff/science
	name = "Science Swimsuit"
	desc = "It's made of a special fiber that provides no protection whatsoever, but its hydrophobic. It has markings that denote the wearer as a scientist."
	icon_state = "swimsuit_science"
	item_state = "swimsuit_science_mob"

/obj/item/clothing/under/swimsuit/fluff/security
	name = "Security Swimsuit"
	desc = "It's made of a slightly sturdier material than standard swimsuits, to allow for a more robust appearance."
	icon_state = "swimsuit_security"
	item_state = "swimsuit_security_mob"

/obj/item/clothing/under/swimsuit/fluff/medical
	name = "Medical Swimsuit"
	desc = "It's made of a special fiber that provides no protection whatsoever, but its elastic. It has a cross on the back denoting that the wearer is trained medical personnel."
	icon_state = "swimsuit_medical"
	item_state = "swimsuit_medical_mob"

/obj/item/clothing/suit/storage/fluff/jacket/field //Just here so it can be seen and easily recognized under /spawn.
	name = "Field Jacket"

/obj/item/clothing/suit/storage/fluff/jacket/air_cavalry
	name = "Air Cavalry Jacket"
	desc = "A jacket worn by the 1st Cavalry Division on Earth."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "acjacket"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "acjacket_mob"

/obj/item/clothing/suit/storage/fluff/jacket/air_force
	name = "Air Force Jacket"
	desc = "A jacket worn by the Earth Air Force."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "afjacket"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "afjacket_mob"

/obj/item/clothing/suit/storage/fluff/jacket/navy
	name = "Navy Jacket"
	desc = "A jacket worn by the Earth's Navy. It's adorned with reflective straps."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "navyjacket"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "navyjacket_mob"

/obj/item/clothing/suit/storage/fluff/jacket/special_forces
	name = "Special Forces Jacket"
	desc = "A durable jacket worn by the Earth's special forces."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "sfjacket"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "sfjacket_mob"

//General use
/obj/item/clothing/head/fluff/headbando
	name = "basic headband"
	desc = "Perfect for martial artists, sweaty rogue operators, and tunnel gangsters."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "headbando"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "headbando"

/obj/item/clothing/suit/storage/fluff/gntop
	name = "GN crop jacket"
	desc = "A nifty little jacket. At least it keeps your shoulders warm."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "gntop"
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "gntop"

/obj/item/clothing/under/fluff/gnshorts
	name = "GN shorts"
	desc = "Stylish white shorts with pockets, stripes, and even a belt."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "gnshorts"
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "gnshorts"

/obj/item/clothing/under/fluff/v_nanovest
	name = "Varmacorp nanovest"
	desc = "A nifty little vest optimized for nanite contact."
	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "nanovest"
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "nanovest"

//General use
/obj/item/clothing/suit/storage/fluff/loincloth
	name = "Loincloth"
	desc = "A primitive piece of oak-brown clothing wrapped firmly around the waist. A few bones line the edges. Comes with a primitive outfit to boot."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "loincloth"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "loincloth"

//For general use maybe
/obj/item/clothing/under/batter //I guess we're going OFF limits.
	name = "Worn baseball outfit"
	desc = "<b>Purification in progress...</b>"
	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "batter"
	item_state = "batter_mob"

//KotetsuRedwood:Latex Maid Dresses, for everyone to 'enjoy'. :3c
/obj/item/clothing/under/fluff/latexmaid
	name = "latex maid dress"
	desc = "Squeak! A shiny outfit for cleaning, made by people with dirty minds."

	item_icons = list(slot_w_uniform_str = 'icons/vore/custom_clothes_vr.dmi')
	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "latexmaid"
	item_state = "latexmaid_mob"

	sprite_sheets = list(
			"Teshari" = 'icons/vore/custom_clothes_tesh_vr.dmi'
			)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

// --- --- TREKKIE STUFF --- --- \\

//For general use
/obj/item/clothing/suit/storage/fluff/fedcoat
	name = "Federation Uniform Jacket (Red)"
	desc = "A uniform jacket from the United Federation. Starfleet still uses this uniform and there are variations of it. Set phasers to awesome."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "fedcoat"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "fedcoat"

	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	allowed = list(
				/obj/item/weapon/tank/emergency/oxygen,
				/obj/item/device/flashlight,
				/obj/item/weapon/gun/energy,
				/obj/item/weapon/gun/projectile,
				/obj/item/ammo_magazine,
				/obj/item/ammo_casing,
//				/obj/item/weapon/storage/fancy/shotgun_ammo,
				/obj/item/weapon/melee/baton,
				/obj/item/weapon/handcuffs,
//				/obj/item/device/detective_scanner,
				/obj/item/device/taperecorder)
	armor = list(melee = 50, bullet = 15, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0)
	var/unbuttoned = 0

/obj/item/clothing/suit/storage/fluff/fedcoat/verb/toggle()
	set name = "Toggle coat buttons"
	set category = "Object"
	set src in usr

	if(!usr.canmove || usr.stat || usr.restrained())
		return 0

	switch(unbuttoned)
		if(0)
			icon_state = "[initial(icon_state)]_open"
			item_state = "[initial(item_state)]_open"
			unbuttoned = 1
			to_chat(usr, "You unbutton the coat.")
		if(1)
			icon_state = "[initial(icon_state)]"
			item_state = "[initial(item_state)]"
			unbuttoned = 0
			to_chat(usr, "You button up the coat.")
	usr.update_inv_wear_suit()

	//Variants
/obj/item/clothing/suit/storage/fluff/fedcoat/fedblue
	name = "Federation Uniform Jacket (Blue)"
	desc = "A uniform jacket from the United Federation. Starfleet still uses this uniform and there are variations of it. Wearing this may make you feel all scientific."
	icon_state = "fedblue"
	item_state = "fedblue"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)

/obj/item/clothing/suit/storage/fluff/fedcoat/fedeng
	name = "Federation Uniform Jacket (Yellow)"
	desc = "A uniform jacket from the United Federation. Starfleet still uses this uniform and there are variations of it.Wearing it may make you feel like checking a warp core, whatever that is."
	icon_state = "fedeng"
	item_state = "fedeng"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 10, bomb = 0, bio = 30, rad = 35)

/obj/item/clothing/suit/storage/fluff/fedcoat/fedcapt
	name = "Federation Uniform Jacket (Command)"
	desc = "A uniform jacket from the United Federation. Starfleet still uses this uniform and there are variations of it. You feel like a commanding officer of Starfleet."
	icon_state = "fedcapt"
	item_state = "fedcapt"
	armor = list(melee = 50, bullet = 5, laser = 15,energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/fluff/modernfedcoat
	name = "Modern Federation Uniform Jacket (Command)"
	desc = "A modern uniform jacket from the United Federation. Their Starfleet had recently started using these uniforms. Wearing this makes you feel like a competant commander."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "fedmodern"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "fedmodern"

	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	allowed = list(
				/obj/item/weapon/tank/emergency/oxygen,
				/obj/item/device/flashlight,
				/obj/item/weapon/gun/energy,
				/obj/item/weapon/gun/projectile,
				/obj/item/ammo_magazine,
				/obj/item/ammo_casing,
//				/obj/item/weapon/storage/fancy/shotgun_ammo,
				/obj/item/weapon/melee/baton,
				/obj/item/weapon/handcuffs,
//				/obj/item/device/detective_scanner,
				/obj/item/device/taperecorder)
	armor = list(melee = 50, bullet = 15, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0)

	//Variants
/obj/item/clothing/suit/storage/fluff/modernfedcoat/modernfedblue
	name = "Modern Federation Uniform Jacket (Blue)"
	desc = "A modern uniform jacket from the United Federation. Their Starfleet had recently started using these uniforms. Wearing this makes you feel like a scientist or a pilot."
	icon_state = "fedmodernblue"
	item_state = "fedmodernblue"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)

/obj/item/clothing/suit/storage/fluff/modernfedcoat/modernfedeng
	name = "Modern Federation Uniform Jacket (Yellow)"
	desc = "A modern uniform jacket from the United Federation. Their Starfleet had recently started using these uniforms. You feel like you can handle any type of technical engineering problems."
	icon_state = "fedmoderneng"
	item_state = "fedmoderneng"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 10, bomb = 0, bio = 30, rad = 35)

/obj/item/clothing/suit/storage/fluff/modernfedcoat/modernfedsec
	name = "Modern Federation Uniform Jacket (Red)"
	desc = "A modern uniform jacket from the United Federation. Their Starfleet had recently started using these uniforms. This uniform makes you want to protect and serve as an officer."
	icon_state = "fedmodernsec"
	item_state = "fedmodernsec"
	armor = list(melee = 50, bullet = 5, laser = 15,energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/head/caphat/formal/fedcover
	name = "Federation Officer's Cap"
	desc = "An officer's cap that demands discipline from the one who wears it."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "fedcapofficer"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "fedcapofficer_mob"

	//Variants
/obj/item/clothing/head/caphat/formal/fedcover/fedcoverblue
	name = "Federation Officer's Cap (Blue)"
	desc = "An officer's cap that demands discipline from the one who wears it."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "fedcapsci"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "fedcapsci_mob"

/obj/item/clothing/head/caphat/formal/fedcover/fedcovereng
	name = "Federation Officer's Cap (Yellow)"
	desc = "An officer's cap that demands discipline from the one who wears it."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "fedcapeng"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "fedcapeng_mob"

/obj/item/clothing/head/caphat/formal/fedcover/fedcoversec
	name = "Federation Officer's Cap (Red)"
	desc = "An officer's cap that demands discipline from the one who wears it."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "fedcapsec"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "fedcapsec_mob"

/obj/item/clothing/head/caphat/formal/fedcover/police
	name = "Police Officer's Cap"
	desc = "A Police Officer's cap that demands discipline from the one who wears it."

	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "policecover"

	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "policecover_mob"

/obj/item/clothing/under/rank/trek
	name = "Section 31 Uniform"
	desc = "Oooh... right."
	icon = 'icons/vore/custom_clothes_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	item_state = ""

//TOS
/obj/item/clothing/under/rank/trek/command
	name = "Command Uniform"
	desc = "The uniform worn by command officers in the mid 2260s."
	icon_state = "trek_command"
	item_state = "trek_command"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0) // Considering only staff heads get to pick it

/obj/item/clothing/under/rank/trek/engsec
	name = "Operations Uniform"
	desc = "The uniform worn by operations officers of the mid 2260s. You feel strangely vulnerable just seeing this..."
	icon_state = "trek_engsec"
	item_state = "trek_engsec"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0) // since they're shared between jobs and kinda moot.

/obj/item/clothing/under/rank/trek/medsci
	name = "MedSci Uniform"
	desc = "The uniform worn by medsci officers in the mid 2260s."
	icon_state = "trek_medsci"
	item_state = "trek_medsci"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0) // basically a copy of vanilla sci/med

//TNG
/obj/item/clothing/under/rank/trek/command/next
	desc = "The uniform worn by command officers. This one's from the mid 2360s."
	icon_state = "trek_next_command"
	item_state = "trek_next_command"

/obj/item/clothing/under/rank/trek/engsec/next
	desc = "The uniform worn by operation officers. This one's from the mid 2360s."
	icon_state = "trek_next_engsec"
	item_state = "trek_next_engsec"

/obj/item/clothing/under/rank/trek/medsci/next
	desc = "The uniform worn by medsci officers. This one's from the mid 2360s."
	icon_state = "trek_next_medsci"
	item_state = "trek_next_medsci"

//ENT
/obj/item/clothing/under/rank/trek/command/ent
	desc = "The uniform worn by command officers of the 2140s."
	icon_state = "trek_ent_command"
	item_state = "trek_ent_command"

/obj/item/clothing/under/rank/trek/engsec/ent
	desc = "The uniform worn by operations officers of the 2140s."
	icon_state = "trek_ent_engsec"
	item_state = "trek_ent_engsec"

/obj/item/clothing/under/rank/trek/medsci/ent
	desc = "The uniform worn by medsci officers of the 2140s."
	icon_state = "trek_ent_medsci"
	item_state = "trek_ent_medsci"

//VOY
/obj/item/clothing/under/rank/trek/command/voy
	desc = "The uniform worn by command officers of the 2370s."
	icon_state = "trek_voy_command"
	item_state = "trek_voy_command"

/obj/item/clothing/under/rank/trek/engsec/voy
	desc = "The uniform worn by operations officers of the 2370s."
	icon_state = "trek_voy_engsec"
	item_state = "trek_voy_engsec"

/obj/item/clothing/under/rank/trek/medsci/voy
	desc = "The uniform worn by medsci officers of the 2370s."
	icon_state = "trek_voy_medsci"
	item_state = "trek_voy_medsci"

//DS9

/obj/item/clothing/suit/storage/trek/ds9
	name = "Padded Overcoat"
	desc = "The overcoat worn by all officers of the 2380s."
	icon_state = "trek_ds9_coat"
	icon = 'icons/vore/custom_clothes_vr.dmi'
	item_state = "trek_ds9_coat_mob"
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	permeability_coefficient = 0.50
	allowed = list(
		/obj/item/device/flashlight, /obj/item/device/analyzer,
		/obj/item/device/radio, /obj/item/weapon/tank/emergency/oxygen,
		/obj/item/weapon/reagent_containers/hypospray, /obj/item/device/healthanalyzer,
		/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/reagent_containers/glass/bottle,/obj/item/weapon/reagent_containers/glass/beaker,
		/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/storage/pill_bottle
		)
	armor = list(melee = 20, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 20, rad = 25)

/obj/item/clothing/suit/storage/trek/ds9/admiral // Only for adminuz
	name = "Admiral Overcoat"
	desc = "Admirality specialty coat to keep flag officers fashionable and protected."
	icon_state = "trek_ds9_coat_adm"
	item_state = "trek_ds9_coat_adm_mob"
	armor = list(melee = 45, bullet = 35, laser = 35, energy = 20, bomb = 0, bio = 40, rad = 55)


/obj/item/clothing/under/rank/trek/command/ds9
	desc = "The uniform worn by command officers of the 2380s."
	icon_state = "trek_command"
	item_state = "trek_ds9_command"

/obj/item/clothing/under/rank/trek/engsec/ds9
	desc = "The uniform worn by operations officers of the 2380s."
	icon_state = "trek_engsec"
	item_state = "trek_ds9_engsec"

/obj/item/clothing/under/rank/trek/medsci/ds9
	desc = "The uniform undershit worn by medsci officers of the 2380s."
	icon_state = "trek_medsci"
	item_state = "trek_ds9_medsci"
