/decl/hierarchy/outfit/job/security
	hierarchy_type = /decl/hierarchy/outfit/job/security
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	l_ear = /obj/item/device/radio/headset/headset_sec/alt
	gloves = /obj/item/clothing/gloves/rugged/combat
	shoes = /obj/item/clothing/shoes/boots/jackboots
	backpack = /obj/item/weapon/storage/backpack/security
	satchel_one = /obj/item/weapon/storage/backpack/satchel/sec
	backpack_contents = list(/obj/item/weapon/material/knife/tacknife/combatknife = 1, /obj/item/weapon/gun/projectile/p92x = 1, /obj/item/ammo_magazine/m9mm = 1, /obj/item/weapon/handcuffs = 1)
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/sec

/decl/hierarchy/outfit/job/security/hos
	name = OUTFIT_JOB_NAME("Head of operations")
	l_ear = /obj/item/device/radio/headset/heads/hos/alt
	uniform = /obj/item/clothing/under/rank/head_of_security
	suit = /obj/item/clothing/suit/armor/pcarrier/medium/security
	suit_store = /obj/item/clothing/head/helmet
	id_type = /obj/item/weapon/card/id/security/head
	pda_type = /obj/item/device/pda/heads/hos

/decl/hierarchy/outfit/job/security/hos/post_equip(var/mob/living/carbon/human/H)
	..()
	var/obj/item/clothing/uniform = H.w_uniform
	if(uniform)
		var/obj/item/clothing/accessory/pip/cmd/pips = new()
		if(uniform.can_attach_accessory(pips))
			uniform.attach_accessory(null, pips)
		else
			qdel(pips)

/decl/hierarchy/outfit/job/security/warden
	name = OUTFIT_JOB_NAME("Warden")
	uniform = /obj/item/clothing/under/rank/warden
	suit = /obj/item/clothing/suit/armor/pcarrier/medium/security
	suit_store = /obj/item/clothing/head/helmet
	l_pocket = /obj/item/device/flash
	id_type = /obj/item/weapon/card/id/security
	pda_type = /obj/item/device/pda/warden

/decl/hierarchy/outfit/job/security/detective
	name = OUTFIT_JOB_NAME("Detective")
	l_ear = /obj/item/device/radio/headset/headset_sec
	head = /obj/item/clothing/head/det
	uniform = /obj/item/clothing/under/det
	suit = /obj/item/clothing/suit/storage/det_trench
	l_pocket = /obj/item/weapon/flame/lighter/zippo
	gloves = /obj/item/clothing/gloves/forensic
	shoes = /obj/item/clothing/shoes/laceup
	r_hand = /obj/item/weapon/storage/briefcase/crimekit
	id_type = /obj/item/weapon/card/id/security
	pda_type = /obj/item/device/pda/detective
	backpack = /obj/item/weapon/storage/backpack
	satchel_one = /obj/item/weapon/storage/backpack/satchel/norm
	backpack_contents = list(/obj/item/weapon/storage/box/evidence = 1, /obj/item/weapon/gun/projectile/colt/detective = 1, /obj/item/ammo_magazine/m45 = 1)

//VOREStation Edit - More cyberpunky
/decl/hierarchy/outfit/job/security/detective/forensic
	name = OUTFIT_JOB_NAME("Forensic technician")
	head = /obj/item/clothing/head/helmet/detective_alt
	suit = /datum/gear/uniform/detective_alt2
	uniform = /obj/item/clothing/under/det
//VOREStation Edit End

/decl/hierarchy/outfit/job/security/guard
	name = OUTFIT_JOB_NAME("Guard")
	uniform = /obj/item/clothing/under/rank/security
	suit = /obj/item/clothing/suit/armor/pcarrier/medium/security
	suit_store = /obj/item/clothing/head/helmet
	l_pocket = /obj/item/device/lighting/flare
	id_type = /obj/item/weapon/card/id/security
	pda_type = /obj/item/device/pda/security
