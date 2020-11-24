/obj/item/modular_computer/pda
	name = "PDA"
	desc = "A very compact computer, designed to keep its user always connected."
	icon = 'icons/obj/modular_pda.dmi'
	icon_state = "pda"
	icon_state_screensaver = "standby"
	icon_state_unpowered = "pda"
	matter = list(MATERIAL_STEEL = 3, MATERIAL_GLASS = 1)
	hardware_flag = PROGRAM_PDA
	max_hardware_size = 1
	w_class = ITEMSIZE_SMALL
	screen_light_strength = 1.1
	screen_light_range = 2
	slot_flags = SLOT_ID | SLOT_BELT
	price_tag = 50

	var/scanner_type = null
	var/tesla_link_type = null
	var/hard_drive_type = /obj/item/weapon/computer_hardware/hard_drive/pda
	var/processor_unit_type = /obj/item/weapon/computer_hardware/processor_unit/small
	var/network_card_type = /obj/item/weapon/computer_hardware/network_card

	var/obj/item/weapon/pen/stored_pen	// A pen!

/obj/item/modular_computer/pda/Initialize()
	. = ..()
	enable_computer()
	if(!stored_pen)
		stored_pen = new(src)

/obj/item/modular_computer/pda/AltClick(var/mob/user)
	if(!CanInteract(user, physical_state))
		return
	if(card_slot && istype(card_slot.stored_card))
		eject_id()
	else
		..()

/obj/item/modular_computer/pda/GetAccess()
	if(card_slot && istype(card_slot.stored_card))
		return card_slot.stored_card.GetAccess()
	else
		return ..()

/obj/item/modular_computer/pda/GetID()
	if(card_slot && istype(card_slot.stored_card))
		return card_slot.stored_card
	else
		return ..()

/obj/item/modular_computer/pda/attackby(atom/A, mob/user as mob)
	if(istype(A, /obj/item/weapon/pen))
		var/obj/item/weapon/pen/O = locate() in src
		if(O)
			to_chat(user, "<span class='notice'>\The [src] already contains \a [O].</span>")
		else
			O = A
			user.drop_item()
			O.forceMove(src)
			to_chat(usr, "<span class='notice'>You insert \the [O] into \the [src].</span>")
		return
	else
		return ..()

/obj/item/modular_computer/pda/proc/remove_pen()
	var/obj/item/weapon/pen/O = locate() in src
	if(O)
		if(istype(loc, /mob))
			var/mob/M = loc
			if(M.get_active_hand() == null)
				M.put_in_hands(O)
				to_chat(usr, "<span class='notice'>You remove \the [O] from \the [src].</span>")
				return
		O.loc = get_turf(src)
	else
		to_chat(usr, "<span class='notice'>This communicator does not have a pen in it.</span>")

/obj/item/modular_computer/pda/CtrlClick()
	if(issilicon(usr))
		return

	if(CanInteract(usr, physical_state))
		remove_pen()
		return
	..()

/obj/item/modular_computer/pda/verb/verb_remove_pen()
	set category = "Object"
	set name = "Remove pen"
	set src in usr

	if(issilicon(usr))
		return

	if(CanInteract(usr, physical_state))
		remove_pen()
	else
		to_chat(usr, "<span class='notice'>You cannot do this while restrained.</span>")

/obj/item/modular_computer/pda/MouseDrop(obj/over_object as obj)
	var/mob/M = usr
	if (!(src.loc == usr) || (src.loc && src.loc.loc == usr))
		return
	if(!istype(over_object, /obj/screen))
		return attack_self(M)
	return
