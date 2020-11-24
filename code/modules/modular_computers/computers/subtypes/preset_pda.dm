/obj/item/modular_computer/pda/install_default_hardware()
	..()
	network_card = new network_card_type(src)
	hard_drive = new hard_drive_type(src)
	processor_unit = new processor_unit_type(src)
	card_slot = new /obj/item/weapon/computer_hardware/card_slot(src)
	battery_module = new /obj/item/weapon/computer_hardware/battery_module/micro(src)
	if(battery_module.battery) // Automatically fill the battery so crew don't start with pdas at 0% battery.
		battery_module.battery.charge = battery_module.battery_rating
	led = new /obj/item/weapon/computer_hardware/led(src)
	if(scanner_type)
		scanner = new scanner_type(src)
	if(tesla_link_type)
		tesla_link = new tesla_link_type(src)


/obj/item/modular_computer/pda/install_default_programs()
	..()

	hard_drive.store_file(new /datum/computer_file/program/chatclient())
	hard_drive.store_file(new /datum/computer_file/program/email_client())
	hard_drive.store_file(new /datum/computer_file/program/crew_manifest())
	hard_drive.store_file(new /datum/computer_file/program/wordprocessor())
	hard_drive.store_file(new /datum/computer_file/program/uplink()) // totally harmless tax software
	if(scanner)
		hard_drive.store_file(new /datum/computer_file/program/scanner())

// PDA types

/obj/item/modular_computer/pda/engineering
	icon_state = "pda-e"
	icon_state_unpowered = "pda-e"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/atmos

/obj/item/modular_computer/pda/security
	icon_state = "pda-s"
	icon_state_unpowered = "pda-s"

/obj/item/modular_computer/pda/forensics
	icon_state = "pda-s"
	icon_state_unpowered = "pda-s"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/reagent

/obj/item/modular_computer/pda/exploration
	icon_state = "pda-exp"
	icon_state_unpowered = "pda-exp"

/obj/item/modular_computer/pda/medical
	icon_state = "pda-m"
	icon_state_unpowered = "pda-m"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/medical

/obj/item/modular_computer/pda/chemistry
	icon_state = "pda-m"
	icon_state_unpowered = "pda-m"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/reagent

/obj/item/modular_computer/pda/roboticist
	icon_state = "pda-robot"
	icon_state_unpowered = "pda-robot"


/obj/item/modular_computer/pda/chaplain
	icon_state = "pda-neo"
	icon_state_unpowered = "pda-neo"


/obj/item/modular_computer/pda/heads
	name = "command PDA"
	icon_state = "pda-h"
	icon_state_unpowered = "pda-h"
	hard_drive_type = /obj/item/weapon/computer_hardware/hard_drive/small
	network_card_type = /obj/item/weapon/computer_hardware/network_card/advanced
	tesla_link_type = /obj/item/weapon/computer_hardware/tesla_link
	scanner_type = /obj/item/weapon/computer_hardware/scanner/paper

/obj/item/modular_computer/pda/heads/hop
	icon_state = "pda-hop"
	icon_state_unpowered = "pda-hop"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/paper

/obj/item/modular_computer/pda/heads/hos
	icon_state = "pda-hos"
	icon_state_unpowered = "pda-hos"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/paper

/obj/item/modular_computer/pda/heads/ce
	icon_state = "pda-ce"
	icon_state_unpowered = "pda-ce"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/atmos

/obj/item/modular_computer/pda/heads/cmo
	icon_state = "pda-cmo"
	icon_state_unpowered = "pda-cmo"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/medical

/obj/item/modular_computer/pda/heads/qm
	icon_state = "pda-qm"
	icon_state_unpowered = "pda-qm"
	scanner_type = /obj/item/weapon/computer_hardware/scanner/reagent

/obj/item/modular_computer/pda/heads/captain
	icon_state = "pda-c"
	icon_state_unpowered = "pda-c"
	hard_drive_type = /obj/item/weapon/computer_hardware/hard_drive/small
	processor_unit_type = /obj/item/weapon/computer_hardware/processor_unit/photonic/small
	network_card_type = /obj/item/weapon/computer_hardware/network_card/advanced
	tesla_link_type = /obj/item/weapon/computer_hardware/tesla_link
	scanner_type = /obj/item/weapon/computer_hardware/scanner/paper

/obj/item/modular_computer/pda/ert
	icon_state = "pda-h"
	icon_state_unpowered = "pda-h"
	hard_drive_type = /obj/item/weapon/computer_hardware/hard_drive/small
	processor_unit_type = /obj/item/weapon/computer_hardware/processor_unit/photonic/small
	network_card_type = /obj/item/weapon/computer_hardware/network_card/advanced
	tesla_link_type = /obj/item/weapon/computer_hardware/tesla_link

/obj/item/modular_computer/pda/logistics
	icon_state = "pda-sup"
	icon_state_unpowered = "pda-sup"

/obj/item/modular_computer/pda/syndicate
	icon_state = "pda-syn"
	icon_state_unpowered = "pda-syn"
	hard_drive_type = /obj/item/weapon/computer_hardware/hard_drive/small
	processor_unit_type = /obj/item/weapon/computer_hardware/processor_unit/photonic/small
	network_card_type = /obj/item/weapon/computer_hardware/network_card/advanced
	tesla_link_type = /obj/item/weapon/computer_hardware/tesla_link

/obj/item/modular_computer/pda/service
	icon_state = "pda-club"
	icon_state_unpowered = "pda-club"

// PDA box
/obj/item/weapon/storage/box/PDAs
	name = "box of spare PDAs"
	desc = "A box of spare PDA microcomputers."
	icon = 'icons/obj/pda.dmi'
	icon_state = "pdabox"

	New()
		..()
		new /obj/item/modular_computer/pda(src)
		new /obj/item/modular_computer/pda(src)
		new /obj/item/modular_computer/pda(src)
		new /obj/item/modular_computer/pda(src)
		new /obj/item/modular_computer/pda(src)
