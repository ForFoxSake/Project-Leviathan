/obj/item/clothing/gloves/rugged
	desc = "These rugged gloves are especially designed to protect the wearer's hands from hazardous environments."
	name = "black gloves"
	icon_state = "fingerlessgloves"
	//item_state = "fingerless"
	permeability_coefficient = 0.05

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

	armor = list(melee = 5, bullet = 5, laser = 5, energy = 5, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/gloves/rugged/work
	desc = "These rugged gloves are especially designed to protect the wearer's hands from industrial machinery."
	name = "rugged work gloves"
	icon = 'icons/leviathan/gloves_pl.dmi'
	icon_state = "work"
	item_state = "wgloves"
	siemens_coefficient = 0
	armor = list(melee = 10, bullet = 5, laser = 5, energy = 0, bomb = 0, bio = 0, rad = 5)

/obj/item/clothing/gloves/rugged/combat
	desc = "These rugged gloves are especially designed to protect the wearer's hands from harsh combat environments."
	name = "rugged combat gloves"
	icon_state = "swat"
	item_state = "swat"
	armor = list(melee = 10, bullet = 10, laser = 5, energy = 5, bomb = 0, bio = 0, rad = 0)