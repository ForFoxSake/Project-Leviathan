// Note for newly added fluff items: Ckeys should not contain any spaces, underscores or capitalizations,
// or else the item will not be usable.
// Example: Someone whose username is "Mister Friend_Man" should be written as "misterfriendman" instead
// Note: Do not use characters such as # in the display_name. It will cause the item to be unable to be selected.

/datum/gear/fluff
	path = /obj/item
	sort_category = "Fluff Items"
	display_name = "If this item can be chosen or seen, ping a coder immediately!"
	ckeywhitelist = list("This entry should never be choosable with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard
	character_name = list("This entry should never be choosable with this variable set.")
	cost = 0

// Test floof item.
/datum/gear/fluff/alyona_serviceribbon
	path = /obj/item/clothing/accessory/sribbon/fluff/alyona_ribbons
	display_name = "Alyona's Service Ribbon"
	slot = slot_tie
	ckeywhitelist = list("forfoxsake")
	character_name = list("Alyona Fuchs")