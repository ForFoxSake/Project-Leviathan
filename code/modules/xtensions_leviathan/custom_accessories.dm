// Custom accessories for Project Leviathan specific uniform decorations.
// These will mostly be medals, ribbons and pips.

/obj/item/clothing/accessory/pip
	name = "Rank Pips"
	desc = "These pips denote that the wearer has no rank... Wait, what?"
	slot = ACCESSORY_SLOT_RANK

	icon = 'icons/leviathan/accessory_pl.dmi'
	icon_state = ""

	icon_override = 'icons/leviathan/accessory_pl.dmi'
	overlay_state = ""

	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/pip/cmd
	name = "Command Pips"
	desc = "These pips denote that the wearer is an officer."

	icon_state = "cmdpip"
	overlay_state = "cmdpip_om"

/obj/item/clothing/accessory/pip/crw
	name = "Enlisted Pips"
	desc = "These pips denote that the wearer is enlisted."

	icon_state = "crwpip"
	overlay_state = "crwpip_om"

/obj/item/clothing/accessory/sribbon
	name = "Service Ribbon"
	desc = "A service ribbon."
	slot = ACCESSORY_SLOT_MEDAL

	icon = 'icons/leviathan/accessory_pl.dmi'
	icon_state = ""

	icon_override = 'icons/leviathan/accessory_pl.dmi'
	overlay_state = ""

	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/sribbon/pheart
	name = "Purple Heart"
	desc = "A service ribbon awarded to those injured or killed on duty."

	icon_state = "pheart"
	overlay_state = "pheart_om"

/obj/item/clothing/accessory/sribbon/fluff/alyona_ribbons
	name = "Alyona Fuchs' Ribbon Patch"
	desc = "A set of service ribbons."

	icon_state = "afnr"
	overlay_state = "afnr_om"