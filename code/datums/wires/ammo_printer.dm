/datum/wires/ammo_printer
	holder_type = /obj/machinery/ammo_printer
	wire_count = 6
	proper_name = "Autolathe"

/datum/wires/ammo_printer/New(atom/_holder)
	wires = list(WIRE_AUTOLATHE_HACK, WIRE_ELECTRIFY, WIRE_AUTOLATHE_DISABLE)
	return ..()

/datum/wires/ammo_printer/get_status()
	. = ..()
	var/obj/machinery/ammo_printer/A = holder
	. += "The red light is [A.disabled ? "off" : "on"]."
	. += "The green light is [A.shocked ? "off" : "on"]."
	. += "The blue light is [A.hacked ? "off" : "on"]."

/datum/wires/ammo_printer/interactable(mob/user)
	var/obj/machinery/ammo_printer/A = holder
	if(A.panel_open)
		return TRUE
	return FALSE

/datum/wires/ammo_printer/on_cut(wire, mend)
	var/obj/machinery/ammo_printer/A = holder
	switch(wire)
		if(WIRE_AUTOLATHE_HACK)
			A.hacked = !mend
		if(WIRE_ELECTRIFY)
			A.shocked = !mend
		if(WIRE_AUTOLATHE_DISABLE)
			A.disabled = !mend
	..()

/datum/wires/ammo_printer/on_pulse(wire)
	if(is_cut(wire))
		return
	var/obj/machinery/ammo_printer/A = holder
	switch(wire)
		if(WIRE_AUTOLATHE_HACK)
			A.hacked = !A.hacked
			spawn(50)
				if(A && !is_cut(wire))
					A.hacked = 0
		if(WIRE_ELECTRIFY)
			A.shocked = !A.shocked
			spawn(50)
				if(A && !is_cut(wire))
					A.shocked = 0
		if(WIRE_AUTOLATHE_DISABLE)
			A.disabled = !A.disabled
			spawn(50)
				if(A && !is_cut(wire))
					A.disabled = 0
	..()