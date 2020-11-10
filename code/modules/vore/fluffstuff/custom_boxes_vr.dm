// BEGIN - DO NOT EDIT PROTOTYPE
/obj/item/weapon/storage/box/fluff
	name = "Undefined Fluff Box"
	desc = "This should have a description. Tell an admin."
	storage_slots = 7
	var/list/has_items = list()

/obj/item/weapon/storage/box/fluff/New()
	storage_slots = has_items.len
	allowed = list()
	for(var/P in has_items)
		allowed += P
		new P(src)
	..()
	return
// END - DO NOT EDIT PROTOTYPE

/*
Swimsuits, for general use, to avoid arriving to work with your swimsuit.
*/
/obj/item/weapon/storage/box/fluff/swimsuit
	name = "Black Swimsuit capsule"
	desc = "A little capsule where a swimsuit is usually stored."
	storage_slots = 1
	icon = 'icons/vore/custom_items_vr.dmi'
	icon_state = "capsule"
	foldable = null
	w_class = ITEMSIZE_SMALL
	max_w_class = ITEMSIZE_NORMAL
	can_hold = list(/obj/item/clothing/under/swimsuit/)
	has_items = list(/obj/item/clothing/under/swimsuit/black)

/obj/item/weapon/storage/box/fluff/swimsuit/blue
	name = "Blue Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/blue)

/obj/item/weapon/storage/box/fluff/swimsuit/purple
	name = "Purple Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/purple)

/obj/item/weapon/storage/box/fluff/swimsuit/green
	name = "Green Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/green)

/obj/item/weapon/storage/box/fluff/swimsuit/red
	name = "Red Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/red)

/obj/item/weapon/storage/box/fluff/swimsuit/white
	name = "White Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/white)

/obj/item/weapon/storage/box/fluff/swimsuit/blue
	name = "Striped Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/striped)

/obj/item/weapon/storage/box/fluff/swimsuit/earth
	name = "Earthen Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/earth)

/obj/item/weapon/storage/box/fluff/swimsuit/engineering
	name = "Engineering Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/fluff/engineering)

/obj/item/weapon/storage/box/fluff/swimsuit/science
	name = "Science Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/fluff/science)

/obj/item/weapon/storage/box/fluff/swimsuit/security
	name = "Security Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/fluff/security)

/obj/item/weapon/storage/box/fluff/swimsuit/medical
	name = "Medical Swimsuit capsule"
	has_items = list(/obj/item/clothing/under/swimsuit/fluff/medical)

//Monkey boxes for the new primals we have
/obj/item/weapon/storage/box/monkeycubes/sobakacubes
	name = "sobaka cube box"
	desc = "Drymate brand sobaka cubes. Just add water!"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/sobakacube = 4)

/obj/item/weapon/storage/box/monkeycubes/sarucubes
	name = "saru cube box"
	desc = "Drymate brand saru cubes. Just add water!"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/sarucube = 4)

/obj/item/weapon/storage/box/monkeycubes/sparracubes
	name = "sparra cube box"
	desc = "Drymate brand sparra cubes. Just add water!"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/sparracube = 4)

/obj/item/weapon/storage/box/monkeycubes/wolpincubes
	name = "wolpin cube box"
	desc = "Drymate brand wolpin cubes. Just add water!"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/wolpincube = 4)
