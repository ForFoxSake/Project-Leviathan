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
/obj/item/weapon/fluff/charactername
	name = ""
	desc = ""

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "myicon"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "myicon"

*/

//For general use
/obj/item/device/modkit_conversion
	name = "modification kit"
	desc = "A kit containing all the needed tools and parts to modify a suit and helmet."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "modkit"
	var/parts = 3
	var/from_helmet = /obj/item/clothing/head/helmet/space/void
	var/from_suit = /obj/item/clothing/suit/space/void
	var/to_helmet = /obj/item/clothing/head/cardborg
	var/to_suit = /obj/item/clothing/suit/cardborg

	//conversion costs. refunds all parts by default, but can be tweaked per-kit
	var/from_helmet_cost = 1
	var/from_suit_cost = 2
	var/to_helmet_cost = -1
	var/to_suit_cost = -2

	var/owner_ckey = null		//ckey of the kit owner as a string
	var/skip_content_check = FALSE	//can we skip the contents check? we generally shouldn't, but this is necessary for rigs/coats with hoods/etc.
	var/transfer_contents = FALSE	//should we transfer the contents across before deleting? we generally shouldn't, esp. in the case of rigs/coats with hoods/etc. note this does nothing if skip is FALSE.
	var/can_repair = FALSE		//can we be used to repair damaged voidsuits when converting them?
	var/can_revert = TRUE		//can we revert items, or is it a one-way trip?
	var/delete_on_empty = FALSE	//do we self-delete when emptied?

	//Conversion proc
/obj/item/device/modkit_conversion/afterattack(obj/O, mob/user as mob)
	var/cost
	var/to_type
	var/keycheck

	if(isturf(O)) //silently fail if you click on a turf. shouldn't work anyway because turfs aren't objects but if I don't do this it spits runtimes.
		return
	if(istype(O,/obj/item/clothing/suit/space/void/) && !can_repair) //check if we're a voidsuit and if we're allowed to repair
		var/obj/item/clothing/suit/space/void/SS = O
		if(LAZYLEN(SS.breaches))
			to_chat(user, "<span class='warning'>You should probably repair that before you start tinkering with it.</span>")
			return
	if(O.blood_DNA || O.contaminated) //check if we're bloody or gooey or whatever, so modkits can't be used to hide crimes easily.
		to_chat(user, "<span class='warning'>You should probably clean that up before you start tinkering with it.</span>")
		return
	//we have to check that it's not the original type first, because otherwise it might convert wrong based on pathing; the subtype can still count as the basetype
	if(istype(O,to_helmet) && can_revert)
		cost = to_helmet_cost
		to_type = from_helmet
	else if(istype(O,to_suit) && can_revert)
		cost = to_suit_cost
		to_type = from_suit
	else if(!can_revert && (istype(O,to_helmet) || istype (O,to_suit)))
		to_chat(user, "<span class='warning'>This kit doesn't seem to have the tools necessary to revert changes to modified items.</span>")
		return
	else if(istype(O,from_helmet))
		cost = from_helmet_cost
		to_type = to_helmet
		keycheck = TRUE
	else if(istype(O,from_suit))
		cost = from_suit_cost
		to_type = to_suit
		keycheck = TRUE
	else
		return
	if(!isturf(O.loc))
		to_chat(user, "<span class='warning'>You need to put \the [O] on the ground, a table, or other worksurface before modifying it.</span>")
		return
	if(!skip_content_check && O.contents.len) //check if we're loaded/modified, in the event of gun/suit kits, to avoid purging stuff like ammo, badges, armbands, or suit helmets
		to_chat(user, "<span class='warning'>You should probably remove any attached items or loaded ammunition before trying to modify that!</span>")
		return
	if(cost > parts)
		to_chat(user, "<span class='warning'>The kit doesn't have enough parts left to modify that.</span>")
		if(can_revert && ((to_helmet_cost || to_suit_cost) < 0))
			to_chat(user, "<span class='notice'> You can recover parts by using the kit on an already-modified item.</span>")
		return
	if(keycheck && owner_ckey) //check if we're supposed to care
		if(user.ckey != owner_ckey) //ERROR: UNAUTHORIZED USER
			to_chat(user, "<span class='warning'>You probably shouldn't mess with all these strange tools and parts...</span>") //give them a slightly fluffy explanation as to why it didn't work
			return
	playsound(src, 'sound/items/Screwdriver.ogg', 100, 1)
	var/obj/N = new to_type(O.loc)
	user.visible_message("<span class='notice'>[user] opens \the [src] and modifies \the [O] into \the [N].</span>","<span class='notice'>You open \the [src] and modify \the [O] into \the [N].</span>")

	//crude, but transfer prints and fibers to avoid forensics abuse, same as the bloody/gooey check above
	N.fingerprints = O.fingerprints
	N.fingerprintshidden = O.fingerprintshidden
	N.fingerprintslast = O.fingerprintslast
	N.suit_fibers = O.suit_fibers

	//transfer logic could technically be made more thorough and handle stuff like helmet/boots/tank vars for suits, but in those cases you should be removing the items first anyway
	if(skip_content_check && transfer_contents)
		N.contents = O.contents
		if(istype(N,/obj/item/weapon/gun/projectile/))
			var/obj/item/weapon/gun/projectile/NN = N
			var/obj/item/weapon/gun/projectile/OO = O
			NN.magazine_type = OO.magazine_type
			NN.ammo_magazine = OO.ammo_magazine
		if(istype(N,/obj/item/weapon/gun/energy/))
			var/obj/item/weapon/gun/energy/NE = N
			var/obj/item/weapon/gun/energy/OE = O
			NE.cell_type = OE.cell_type
	else
		if(istype(N,/obj/item/weapon/gun/projectile/))
			var/obj/item/weapon/gun/projectile/NM = N
			NM.contents = list()
			NM.magazine_type = null
			NM.ammo_magazine = null
		if(istype(N,/obj/item/weapon/gun/energy/))
			var/obj/item/weapon/gun/energy/NO = N
			NO.contents = list()
			NO.cell_type = null

	qdel(O)
	parts -= cost
	if(!parts && delete_on_empty)
		qdel(src)

//General Use
/obj/item/weapon/flag
	name = "Nanotrasen Banner"
	desc = "I pledge allegiance to the flag of a megacorporation in space."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "Flag_Nanotrasen"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "Flag_Nanotrasen_mob"

/obj/item/weapon/flag/attack_self(mob/user as mob)
	if(isliving(user))
		user.visible_message("<span class='warning'>[user] waves their Banner around!</span>","<span class='warning'>You wave your Banner around.</span>")

/obj/item/weapon/flag/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message("<span class='warning'>[user] invades [M]'s personal space, thrusting [src] into their face insistently.</span>","<span class='warning'>You invade [M]'s personal space, thrusting [src] into their face insistently.</span>")


/obj/item/weapon/flag/federation
	name = "Federation Banner"
	desc = "Space, The Final Frontier. Sorta. Just go with it and say the damn oath."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "flag_federation"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "flag_federation_mob"

/obj/item/weapon/flag/xcom
	name = "Alien Combat Command Banner"
	desc = "A banner bearing the symbol of a task force fighting an unknown alien power."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "flag_xcom"
	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "flag_xcom_mob"

/obj/item/weapon/flag/advent
	name = "ALIEN Coalition Banner"
	desc = "A banner belonging to traitors who work for an unknown alien power."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "flag_advent"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "flag_advent_mob"

/obj/item/weapon/melee/fluff/holochain
	name = "Holographic Chain"
	desc = "A High Tech solution to simple perversions. It has a red faux leather handle and an aluminium base."

	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "holochain"

	icon_override = 'icons/vore/custom_items_vr.dmi'
	item_state = "holochain_mob"

	flags = NOBLOODY
	slot_flags = SLOT_BELT
	force = 6
	throwforce = 3
	w_class = ITEMSIZE_NORMAL
	damtype = HALLOSS
	attack_verb = list("flogged", "whipped", "lashed", "disciplined", "chastised", "flayed")

//General use, Verk felt like sharing.
/obj/item/clothing/glasses/fluff/science_proper
	name = "Aesthetic Science Goggles"
	desc = "The goggles really do nothing this time!"
	icon_state = "purple"
	item_state_slots = list(slot_r_hand_str = "glasses", slot_l_hand_str = "glasses")
	item_flags = AIRTIGHT

//General use, Verk felt like sharing.
/obj/item/clothing/glasses/fluff/spiffygogs
	name = "Orange Goggles"
	desc = "You can almost feel the raw power radiating off these strange specs."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "spiffygogs"
	slot_flags = SLOT_EYES | SLOT_EARS
	item_state_slots = list(slot_r_hand_str = "glasses", slot_l_hand_str = "glasses")
	toggleable = 1
	off_state = "spiffygogsup"

//General use
/obj/item/clothing/accessory/tronket
	name = "metal necklace"
	desc = "A shiny steel chain with a vague metallic object dangling off it."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "tronket"
	item_state = "tronket"
	overlay_state = "tronket"
	slot_flags = SLOT_TIE
	slot = ACCESSORY_SLOT_DECOR

/obj/item/clothing/accessory/flops
	name = "drop straps"
	desc = "Wearing suspenders over shoulders? That's been so out for centuries and you know better."
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_override = 'icons/vore/custom_clothes_vr.dmi'
	icon_state = "flops"
	item_state = "flops"
	overlay_state = "flops"
	slot_flags = SLOT_TIE
	slot = ACCESSORY_SLOT_DECOR

//For 2 handed fluff weapons.
/obj/item/weapon/material/twohanded/fluff //Twohanded fluff items.
	name = "fluff."
	desc = "This object is so fluffy. Just from the sight of it, you know that either something went wrong or someone spawned the incorrect item."
	icon = 'icons/vore/custom_items_vr.dmi'
	item_icons = list(
				slot_l_hand_str = 'icons/vore/custom_items_left_hand_vr.dmi',
				slot_r_hand_str = 'icons/vore/custom_items_right_hand_vr.dmi',
				)

/obj/item/weapon/material/twohanded/fluff/New(var/newloc)
	..(newloc," ") //See materials_vr_dmi for more information as to why this is a blank space.

//General use.
/obj/item/weapon/material/twohanded/fluff/riding_crop
	name = "riding crop"
	desc = "A steel rod, a little over a foot long with a widened grip and a thick, leather patch at the end. Made to smack naughty submissives."
	//force_wielded = 0.05 //Stings, but does jack shit for damage, provided you don't hit someone 100 times. 1 damage with hardness of 60.
	force_divisor = 0.05 //Required in order for the X attacks Y message to pop up.
	unwielded_force_divisor = 1 // One here, too.
	applies_material_colour = 0
	unbreakable = 1
	base_icon = "riding_crop"
	icon_state = "riding_crop0"
	attack_verb = list("cropped","spanked","swatted","smacked","peppered")
