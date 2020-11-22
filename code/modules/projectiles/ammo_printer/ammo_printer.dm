/obj/machinery/ammo_printer
	name = "ammolathe"
	desc = "It produces bullets from mere sheet metal."
	icon_state = "autolathe"
	density = 1
	anchored = 1
	use_power = USE_POWER_IDLE
	idle_power_usage = 10
	active_power_usage = 2000
	clicksound = "keyboard"
	clickvol = 30

	circuit = /obj/item/weapon/circuitboard/ammo_printer
	var/list/stored_material =  list(DEFAULT_WALL_MATERIAL = 0, "glass" = 0)
	var/list/storage_capacity = list(DEFAULT_WALL_MATERIAL = 0, "glass" = 0)
	var/list/obj/item/ammo_disk/disks = list()
	var/obj/item/ammo_magazine/magazine = null

	var/hacked = 0
	var/disabled = 0
	var/shocked = 0
	var/busy = 0

	var/mat_efficiency = 1
	var/build_time = 50

	var/datum/wires/ammo_printer/wires = null

	var/filtertext

/obj/machinery/ammo_printer/Initialize()
	. = ..()
	wires = new(src)
	default_apply_parts()
	RefreshParts()
	for(var/obj/item/ammo_disk/disk in loc) // Absorb any disks we spawn on!
		if(disk.blueprint)
			disk.forceMove(src)
			disks.Add(disk)
	sortdisks()

/obj/machinery/ammo_printer/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/machinery/ammo_printer/proc/attempt_magazine_insert(var/obj/item/ammo_magazine/mag)
	if(!magazine && mag && mag.max_ammo > mag.stored_ammo.len)
		mag.forceMove(src)
		magazine = mag
		src.visible_message("\The [mag] drops smoothly into \the [src]!", "You hear a metalic rattling.")
		return 1
	else
		src.visible_message("\The [src] clunks as [mag] bounces off it.", "You hear a soft clunk.")
		return 0

/obj/machinery/ammo_printer/Bumped(var/atom/A)
	if(istype(A, /obj/item/ammo_magazine))
		if(attempt_magazine_insert(A))
			return 0
		else
			return ..()
	else
		return ..()

/obj/machinery/ammo_printer/interact(mob/user as mob)
	if(..() || (disabled && !panel_open))
		to_chat(user, "<span class='danger'>\The [src] is disabled!</span>")
		return

	if(shocked)
		shock(user, 50)
	var/list/dat = list()
	dat += "<center><h1>Ammolathe Control Panel</h1><hr/>"

	var/multiplier = 1
	if(magazine)
		if(magazine.max_ammo > magazine.stored_ammo.len)
			multiplier = magazine.max_ammo - magazine.stored_ammo.len
		else
			magazine.forceMove(loc)
			magazine = null

	if(!disabled)
		dat += "<table width = '100%'>"
		var/list/material_top = list("<tr>")
		var/list/material_bottom = list("<tr>")

		for(var/material in stored_material)
			material_top += "<td width = '25%' align = center><b>[material]</b></td>"
			material_bottom += "<td width = '25%' align = center>[stored_material[material]]<b>/[storage_capacity[material]]</b></td>"

		dat += "[material_top.Join()]</tr>[material_bottom.Join()]</tr></table><hr>"
		dat += "<b>Filter:</b> <a href='?src=\ref[src];setfilter=1'>[filtertext ? filtertext : "None Set"]</a><br>"
		dat += "<h2>Printable Designs</h2>"
		if (magazine)
			dat += "<h3>[magazine] is loaded. <a href='?src=\ref[src];eject=1'>Eject</a></h3>"
		dat += "</center><table width = '100%'>"

		for(var/obj/item/ammo_disk/D in disks)
			if((D.hidden && !hacked) || (!D.blueprint) || (magazine && magazine.caliber != D.blueprint.caliber) || (filtertext && findtext(D.ammo_name, filtertext) == 0))
				continue
			var/can_make = 1
			var/list/material_string = list()
			var/list/multiplier_string = list()
			var/max_sheets
			var/comma
			if(!D.blueprint.matter || !D.blueprint.matter.len)
				material_string += "No resources required.</td>"
			else
				//Make sure it's buildable and list requires resources.
				for(var/material in D.blueprint.matter)
					var/sheets = round(stored_material[material]/round(D.blueprint.matter[material]*mat_efficiency))
					if(isnull(max_sheets) || max_sheets > sheets)
						max_sheets = sheets
					if(!isnull(stored_material[material]) && stored_material[material] < round(D.blueprint.matter[material]*mat_efficiency)*multiplier)
						can_make = 0
					if(!comma)
						comma = 1
					else
						material_string += ", "
					material_string += "[round(D.blueprint.matter[material] * mat_efficiency) * multiplier] [material]"
				material_string += ".<br></td>"

			dat += "<tr><td width = 180>[D.hidden ? "<font color = 'red'>*</font>" : ""]<b>[can_make ? "<a href='?src=\ref[src];make=\ref[D];multiplier=[multiplier]'>" : "<span class='linkOff'>"][D.ammo_name][can_make ? "</a>" : "</span>"]</b>[D.hidden ? "<font color = 'red'>*</font>" : ""][multiplier_string.Join()]</td><td align = right>[material_string.Join()]</tr>"

		dat += "</table><hr>"

	dat = jointext(dat, null)
	var/datum/browser/popup = new(user, "ammolathe", "Ammolathe Production Menu", 550, 700)
	popup.set_content(dat)
	popup.open()

/obj/machinery/ammo_printer/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(busy)
		to_chat(user, "<span class='notice'>\The [src] is busy. Please wait for completion of previous operation.</span>")
		return

	if(default_deconstruction_screwdriver(user, O))
		updateUsrDialog()
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return

	if(stat)
		return

	if(panel_open)
		//Don't eat multitools or wirecutters used on an open lathe.
		if(O.is_multitool() || O.is_wirecutter())
			wires.Interact(user)
			return

	if(O.loc != user && !(istype(O,/obj/item/stack)))
		return 0

	if(is_robot_module(O))
		return 0

	if(istype(O, /obj/item/ammo_magazine/handful))
		var/obj/item/ammo_magazine/handful/mag = O
		for(var/obj/item/ammo_casing/round in mag.stored_ammo)
			round.forceMove(loc)
			eat(round, user)
		mag.stored_ammo.Cut()
		user.remove_from_mob(mag)
		qdel(mag)
		to_chat(user, "You feed \the [mag] into \the [src]!")
		updateUsrDialog()
		return 0

	if(istype(O, /obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/mag = O
		if(!magazine && mag && mag.max_ammo > mag.stored_ammo.len)
			user.remove_from_mob(mag)
			attempt_magazine_insert(mag)
		else
			to_chat(user, "\The [src] rejects \the [mag]!")

	if(istype(O,/obj/item/ammo_disk))
		var/obj/item/ammo_disk/disk = O
		if(disk.blueprint)
			user.remove_from_mob(disk)
			disk.forceMove(src)
			disks.Add(disk)
			sortdisks()
			to_chat(user, "You insert \the [disk] into \the [src]!")
		else
			to_chat(user, "\The [src] rejects \the [disk]!")

	if(istype(O,/obj/item/stack) || istype(O,/obj/item/ammo_casing))
		eat(O, user)
	
	if(istype(O,/obj/item/weapon/storage))
		var/obj/item/weapon/storage/box = O
		for(var/obj/item/ammo_casing/round in box.contents)
			round.forceMove(loc)
			eat(round, user)
		box.update_icon() // Fix trash bags!

	updateUsrDialog()
	return

/obj/machinery/ammo_printer/proc/eat(var/obj/item/O as obj, var/mob/user as mob)
	//Resources are being loaded.
	var/obj/item/eating = O
	if(!eating.matter)
		if(istype(eating,/obj/item/ammo_casing))
			qdel(eating)
		return

	var/filltype = 0       // Used to determine message.
	var/total_used = 0     // Amount of material used.
	var/mass_per_sheet = 0 // Amount of material constituting one sheet.

	for(var/material in eating.matter)

		if(isnull(stored_material[material]) || isnull(storage_capacity[material]))
			continue

		if(stored_material[material] >= storage_capacity[material])
			continue

		var/total_material = eating.matter[material]

		//If it's a stack, we eat multiple sheets.
		if(istype(eating,/obj/item/stack))
			var/obj/item/stack/stack = eating
			total_material *= stack.get_amount()

		if(stored_material[material] + total_material > storage_capacity[material])
			total_material = storage_capacity[material] - stored_material[material]
			filltype = 1
		else
			filltype = 2

		stored_material[material] += total_material
		total_used += total_material
		mass_per_sheet += eating.matter[material]

	if(!filltype)
		to_chat(user, "<span class='notice'>\The [src] is full. Please remove material from the autolathe in order to insert more.</span>")
		return
	else if(filltype == 1)
		to_chat(user, "You fill \the [src] to capacity with \the [eating].")
	else
		to_chat(user, "You fill \the [src] with \the [eating].")

	flick("autolathe_loading", src) // Plays metal insertion animation. Work out a good way to work out a fitting animation. ~Z

	if(istype(eating,/obj/item/stack))
		var/obj/item/stack/stack = eating
		stack.use(max(1, round(total_used/mass_per_sheet))) // Always use at least 1 to prevent infinite materials.
	else
		user.remove_from_mob(eating)
		qdel(eating)

/obj/machinery/ammo_printer/attack_hand(mob/user as mob)
	user.set_machine(src)
	interact(user)

/obj/machinery/ammo_printer/Topic(href, href_list)
	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	if(busy)
		to_chat(usr, "<span class='notice'>The ammolathe is busy. Please wait for completion of previous operation.</span>")
		return

	else if(href_list["setfilter"])
		var/filterstring = input(usr, "Input a filter string, or blank to not filter:", "Design Filter", filtertext) as null|text
		if(!Adjacent(usr))
			return
		if(isnull(filterstring)) //Clicked Cancel
			return
		if(filterstring == "") //Cleared value
			filtertext = null
		filtertext = sanitize(filterstring, 25)

	if(href_list["eject"])
		magazine.forceMove(loc)
		magazine = null

	if(href_list["make"])
		var/multiplier = text2num(href_list["multiplier"])
		var/obj/item/ammo_disk/making = locate(href_list["make"]) in disks

		if(magazine)
			if(magazine.caliber == making.blueprint.caliber && magazine.max_ammo > magazine.stored_ammo.len)
				var/maxfill = magazine.max_ammo - magazine.stored_ammo.len
				if(!multiplier || multiplier > maxfill)
					multiplier = maxfill
			else
				magazine.forceMove(loc)
				magazine = null

		//Exploit detection, not sure if necessary after rewrite.
		if(!making || multiplier < 0 || multiplier > 1000)
			var/turf/exploit_loc = get_turf(usr)
			message_admins("[key_name_admin(usr)] tried to exploit an autolathe to duplicate an item! ([exploit_loc ? "<a href='?_src_=holder;adminplayerobservecoodjump=1;X=[exploit_loc.x];Y=[exploit_loc.y];Z=[exploit_loc.z]'>JMP</a>" : "null"])", 0)
			log_admin("EXPLOIT : [key_name(usr)] tried to exploit an autolathe to duplicate an item!")
			return

		busy = TRUE
		update_use_power(USE_POWER_ACTIVE)

		//Check if we still have the materials.
		for(var/material in making.blueprint.matter)
			if(!isnull(stored_material[material]))
				if(stored_material[material] < round(making.blueprint.matter[material] * mat_efficiency) * multiplier)
					busy = FALSE
					return

		//Consume materials.
		for(var/material in making.blueprint.matter)
			if(!isnull(stored_material[material]))
				stored_material[material] = max(0, stored_material[material] - round(making.blueprint.matter[material] * mat_efficiency) * multiplier)

		update_icon() // So lid closes

		sleep(build_time)

		busy = FALSE
		update_use_power(USE_POWER_IDLE)
		update_icon() // So lid opens

		//Sanity check.
		if(!making || !src) return

		if(TRUE) // Saving indentation for implementing stack ejecting.
			for(multiplier; multiplier > 0; --multiplier)
				if(magazine && magazine.max_ammo > magazine.stored_ammo.len)
					var/round = new making.blueprint.type(magazine)
					magazine.stored_ammo.Add(round)
				else
					new making.blueprint.type(src.loc)
			if(magazine)
				magazine.update_icon()
				magazine.forceMove(loc)
				magazine = null
//		else
//			var/obj/item/stack/S = I
//			S.amount = multiplier
		flick("[initial(icon_state)]_finish", src)

	updateUsrDialog()

/obj/machinery/ammo_printer/update_icon()
	overlays.Cut()

	icon_state = initial(icon_state)

	if(panel_open)
		overlays.Add(image(icon, "[icon_state]_panel"))
	if(stat & NOPOWER)
		return
	if(busy)
		icon_state = "[icon_state]_work"

//Updates overall lathe storage size.
/obj/machinery/ammo_printer/RefreshParts()
	..()
	var/mb_rating = 0
	var/man_rating = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/MB in component_parts)
		mb_rating += MB.rating
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating

	storage_capacity[DEFAULT_WALL_MATERIAL] = mb_rating  * 25000
	storage_capacity["glass"] = mb_rating  * 12500
	build_time = 50 / man_rating
	mat_efficiency = 1.1 - man_rating * 0.1// Normally, price is 1.25 the amount of material, so this shouldn't go higher than 0.6. Maximum rating of parts is 5

/obj/machinery/ammo_printer/dismantle()
	for(var/mat in stored_material)
		var/material/M = get_material_by_name(mat)
		if(!istype(M))
			continue
		var/obj/item/stack/material/S = new M.stack_type(get_turf(src))
		if(stored_material[mat] > S.perunit)
			S.amount = round(stored_material[mat] / S.perunit)
		else
			qdel(S)
	for(var/obj/item/ammo_disk/disk in disks)
		disks -= disk
		if(!disk.hidden) // illicit disks get destroyed, I guess
			disk.loc = loc
		else
			qdel(disk)
	..()
	return 1

/obj/machinery/ammo_printer/proc/sortdisks()
	if(disks.len < 2) // Nothing to sort
		return
	var/list/disklist = list()
	for(var/obj/item/ammo_disk/disk in disks)
		disklist[++disklist.len] = list("name" = disk.ammo_name, "disk" = disk)
	var/sortedlist = sortByKey(disklist, "name")
	if(sortedlist)
		disks = list()
		for(var/list/disk in sortedlist)
			disks.Add(disk["disk"])

/obj/item/weapon/circuitboard/ammo_printer
	name = T_BOARD("ammolathe")
	build_path = /obj/machinery/ammo_printer
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_ENGINEERING = 2, TECH_DATA = 2)
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 3,
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)