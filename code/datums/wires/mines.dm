/datum/wires/mines
	wire_count = 6
	randomize = TRUE
	holder_type = /obj/effect/mine
	proper_name = "Explosive Wires"

/datum/wires/mines/New(atom/_holder)
	wires = list(WIRE_EXPLODE, WIRE_EXPLODE_DELAY, WIRE_DISARM, WIRE_BADDISARM)
	return ..()

/datum/wires/mines/get_status()
	. = ..()
	. += "\[Warning: detonation may occur even with proper equipment.]"

/datum/wires/mines/proc/explode()
	return

/datum/wires/mines/on_cut(wire, mend)
	var/obj/effect/mine/C = holder

	switch(wire)
		if(WIRE_EXPLODE)
			C.visible_message("[bicon(C)] *BEEE-*", "[bicon(C)] *BEEE-*")
			C.explode()

		if(WIRE_EXPLODE_DELAY)
			C.visible_message("[bicon(C)] *BEEE-*", "[bicon(C)] *BEEE-*")
			C.explode()

		if(WIRE_DISARM)
			C.visible_message("[bicon(C)] *click!*", "[bicon(C)] *click!*")
			new C.mineitemtype(get_turf(C))
			spawn(0)
				qdel(C)

		if(WIRE_BADDISARM)
			C.visible_message("[bicon(C)] *BEEPBEEPBEEP*", "[bicon(C)] *BEEPBEEPBEEP*")
			spawn(20)
				C.explode()
	..()

/datum/wires/mines/on_pulse(wire)
	var/obj/effect/mine/C = holder
	if(is_cut(wire))
		return
	switch(wire)
		if(WIRE_EXPLODE)
			C.visible_message("[bicon(C)] *beep*", "[bicon(C)] *beep*")

		if(WIRE_EXPLODE_DELAY)
			C.visible_message("[bicon(C)] *BEEPBEEPBEEP*", "[bicon(C)] *BEEPBEEPBEEP*")
			spawn(20)
				C.explode()

		if(WIRE_DISARM)
			C.visible_message("[bicon(C)] *ping*", "[bicon(C)] *ping*")

		if(WIRE_BADDISARM)
			C.visible_message("[bicon(C)] *ping*", "[bicon(C)] *ping*")
	..()

/datum/wires/mines/interactable(mob/user)
	var/obj/effect/mine/M = holder
	return M.panel_open