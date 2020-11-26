#define FIREFUEL_MAX 30
#define FIREFUEL_MIN 5

/obj/item/weapon/flamethrower
	name = "flamethrower"
	desc = "You are a firestarter!"
	icon = 'icons/obj/flamethrower.dmi'
	icon_state = "flamethrowerbase"
	item_icons = list(
			slot_l_hand_str = 'icons/mob/items/lefthand_guns.dmi',
			slot_r_hand_str = 'icons/mob/items/righthand_guns.dmi',
			)
	item_state = "flamethrower_0"
	force = 3.0
	throwforce = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = ITEMSIZE_NORMAL
	origin_tech = list(TECH_COMBAT = 1, TECH_PHORON = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 500)
	var/status = 0
	var/throw_amount = 10
	var/lit = 0	//on or off
	var/operating = 0//cooldown
	var/ready_at = 0//ok so we had first cooldown but how about second cooldown?
	var/obj/item/weapon/weldingtool/weldtool = null
	var/obj/item/device/assembly/igniter/igniter = null
	var/obj/item/weapon/reagent_containers/fueltank = null


/obj/item/weapon/flamethrower/Destroy()
	QDEL_NULL(weldtool)
	QDEL_NULL(igniter)
	QDEL_NULL(fueltank)
	. = ..()

/obj/item/weapon/flamethrower/process()
	if(!lit)
		src.force = initial(src.force)
		src.damtype = "brute"
		src.w_class = initial(src.w_class)
		src.hitsound = initial(src.hitsound)
		STOP_PROCESSING(SSobj, src)
		return null
	var/turf/location = loc
	if(istype(location, /mob/))
		var/mob/living/M = location
		if(M.item_is_in_hands(src))
			location = M.loc
	if(isturf(location)) //start a fire if possible
		location.hotspot_expose(700, 2)
	return


/obj/item/weapon/flamethrower/update_icon()
	overlays.Cut()
	if(igniter)
		overlays += "+igniter[status]"
	if(fueltank)
		overlays += "+ptank"
	if(lit)
		overlays += "+lit"
		item_state = "flamethrower_1"
	else
		item_state = "flamethrower_0"
	return

/obj/item/weapon/flamethrower/afterattack(atom/target, mob/user, proximity)
	if(proximity) return // We don't burn things in melee range.
	if(world.time < ready_at) return // We don't fire as fast as we can click.
	// Make sure our user is still holding us
	if(fueltank && fueltank.reagents.total_volume > 0 && user && user.get_active_hand() == src)
		var/turf/target_turf = get_turf(target)
		if(target_turf)
			//var/turflist = getline(user, target_turf)
			//flame_turf(turflist)
			log_and_message_admins("has fired a flamethrower! [ADMIN_JMP(user.loc)]", user)
			playsound(src, 'sound/effects/spray.ogg', 50, 1, -6)
			var/distance = max(1, round(throw_amount / 5))
			spawn(0)
				var/obj/effect/effect/water/fuelpuff/D = new/obj/effect/effect/water/fuelpuff(get_turf(src))
				D.burning = lit && ((fueltank.reagents.has_reagent("fuel", 1) || fueltank.reagents.has_reagent("phoron", 1)) && (!fueltank.reagents.has_reagent("water", 1) && !fueltank.reagents.has_reagent("firefoam", 1)))
				if(D.burning)
					D.name = "burning fuel"
				D.create_reagents(throw_amount)
				if(!src)
					return
				fueltank.reagents.trans_to_obj(D, throw_amount)
				D.set_color()
				D.set_up(target_turf, distance, 5)
	ready_at = world.time + 1.5 SECONDS

/obj/item/weapon/flamethrower/attackby(obj/item/W as obj, mob/user as mob)
	if(user.stat || user.restrained() || user.lying)	return
	if(W.is_wrench() && !status)//Taking this apart
		var/turf/T = get_turf(src)
		if(weldtool)
			weldtool.forceMove(T)
			weldtool = null
		if(igniter)
			igniter.forceMove(T)
			igniter = null
		if(fueltank)
			fueltank.forceMove(T)
			fueltank = null
		new /obj/item/stack/rods(T)
		qdel(src)
		return

	if(W.is_screwdriver() && igniter && !lit)
		status = !status
		to_chat(user, "<span class='notice'>[igniter] is now [status ? "secured" : "unsecured"]!</span>")
		update_icon()
		return

	if(isigniter(W))
		var/obj/item/device/assembly/igniter/I = W
		if(igniter) // Already have one, thanks.
			return
		if(I.secured) // They've forgotten to unscrew the damn thing. Lets tell them.
			to_chat(user, "<span class='notice'>[igniter] is not ready.</span>")
			return
		user.drop_item()
		I.loc = src
		igniter = I
		update_icon()
		return

	// May wanna limit this to not literally anything.
	if(istype(W,/obj/item/weapon/reagent_containers/))
		if(fueltank)
			to_chat(user, "<span class='notice'>There appears to already be a fuel container loaded in [src]!</span>")
			return
		user.drop_item()
		fueltank = W
		W.forceMove(src)
		update_icon()
		return

	// Come back to this one. Maybe a reagent scanner?
	/*if(istype(W, /obj/item/device/analyzer))
		var/obj/item/device/analyzer/A = W
		A.analyze_gases(src, user)
		return*/
	..()
	return


/obj/item/weapon/flamethrower/attack_self(mob/user as mob)
	if(user.stat || user.restrained() || user.lying)	return
	user.set_machine(src)
	/*if(!fueltank)
		to_chat(user, "<span class='notice'>Attach a fuel container first!</span>")
		return*/
	var/throw_links = "<BR>\nAmount to throw: [throw_amount - 10 > FIREFUEL_MIN ? "<A HREF='?src=\ref[src];amount=-10'>-</A>" : "-"] [throw_amount - 5 > FIREFUEL_MIN ? "<A HREF='?src=\ref[src];amount=-5'>-</A>" : "-"] [throw_amount - 1 > FIREFUEL_MIN ? "<A HREF='?src=\ref[src];amount=-1'>-</A>" : "-"] [throw_amount] [throw_amount + 1 <= FIREFUEL_MAX ? "<A HREF='?src=\ref[src];amount=1'>+</A>" : "+"] [throw_amount + 5 <= FIREFUEL_MAX ? "<A HREF='?src=\ref[src];amount=5'>+</A>" : "+"] [throw_amount + 10 <= FIREFUEL_MAX ? "<A HREF='?src=\ref[src];amount=10'>+</A>" : "+"]"
	var/remove_link = "<A HREF='?src=\ref[src];remove=1'>Remove fuel container</A>"
	var/dat = text("<TT><B>(<A HREF='?src=\ref[src];light=1'>[lit ? "<font color='red'>Lit</font>" : "Unlit"]</a>)</B><BR>\n Fuel Level: [fueltank ? fueltank.reagents.total_volume : "0"][fueltank ? throw_links : ""]<BR>\n[fueltank ? remove_link : "No container"] - <A HREF='?src=\ref[src];close=1'>Close</A></TT>")
	var/datum/browser/popup = new(user, "flamethrower", "Flamethrower", 310, 140)
	popup.set_content(dat)
	popup.open()
	onclose(user, "flamethrower")
	return


/obj/item/weapon/flamethrower/Topic(href,href_list[])
	if(href_list["close"] || usr.stat || usr.restrained() || usr.lying || (get_dist(src, usr) > 1))
		usr.unset_machine()
		usr << browse(null, "window=flamethrower")
		return
	usr.set_machine(src)
	if(href_list["light"])
		if(!status)	return
		lit = !lit
		if(lit)
			src.force = 15
			src.damtype = "fire"
			src.w_class = ITEMSIZE_LARGE
			src.hitsound = 'sound/items/welder.ogg'
			START_PROCESSING(SSobj, src)
	if(href_list["amount"])
		if(!fueltank)	return
		throw_amount = between(FIREFUEL_MIN, throw_amount + text2num(href_list["amount"]), FIREFUEL_MAX)
	if(href_list["remove"])
		if(!fueltank)	return
		usr.put_in_hands(fueltank)
		fueltank = null
		lit = 0
		usr.unset_machine()
		usr << browse(null, "window=flamethrower")
	for(var/mob/M in viewers(1, loc))
		if((M.client && M.machine == src))
			attack_self(M)
	update_icon()
	return


/*//Called from turf.dm turf/dblclick
/obj/item/weapon/flamethrower/proc/flame_turf(turflist)
	if(operating)	return
	operating = 1
	var/turf/previousturf = null
	var/turfcount = LAZYLEN(turflist)
	turfcount 
	var/thrown_amount = turfcount > 2 ? throw_amount / (turfcount - 1) : throw_amount // Amount of reagents consumed each turf.
	for(var/turf/T in turflist)
		if(T.density || istype(T, /turf/space))
			break
		if(!previousturf && length(turflist)>1)
			previousturf = get_turf(src)
			continue	//so we don't burn the tile we be standin on
		if(previousturf && LinkBlocked(previousturf, T))
			break
		//ignite_turf(T)
		thrown_amount = between(0, thrown_amount, fueltank.reagents.total_volume)
		if(thrown_amount < 1) // Out of fuel!
			break
		// Check if contents can burn before potentially exhausting them.
		var/flamable = ((fueltank.reagents.has_reagent("fuel", 1) || fueltank.reagents.has_reagent("phoron", 1)) &&
						(!fueltank.reagents.has_reagent("water", 1) && !fueltank.reagents.has_reagent("firefoam", 1)))
		for(var/atom/A in T)
			fueltank.reagents.touch(A, thrown_amount) // Brush past all items on the tile.
		fueltank.reagents.splash(T, thrown_amount) // Finally land on tile.
		if(lit && flamable)
			T.hotspot_expose(700, throw_amount * 10) // Reagents have been passed through a flame, and should probably light up anything they touch.
		sleep(1)
	previousturf = null
	operating = 0
	for(var/mob/M in viewers(1, loc))
		if((M.client && M.machine == src))
			attack_self(M)
	return */

/obj/item/weapon/flamethrower/full/New(var/loc)
	..()
	weldtool = new /obj/item/weapon/weldingtool(src)
	weldtool.status = 0
	igniter = new /obj/item/device/assembly/igniter(src)
	igniter.secured = 0
	status = 1
	update_icon()
	return

/obj/effect/effect/water/fuelpuff
	name = "fuel"
	icon = 'icons/obj/chempuff.dmi'
	icon_state = ""
	var/burning = FALSE

/obj/effect/effect/water/fuelpuff/set_up(var/turf/target, var/step_count = 5, var/delay = 5)
	if(!target)
		return
	if(!reagents) return
	var/step_contents = reagents.total_volume / step_count
	for(var/i = 1 to step_count)
		if(!loc)
			return
		step_towards(src, target)
		var/turf/T = get_turf(src)
		if(T)
			step_contents = between(0, step_contents, reagents.total_volume)
			if (!step_contents)
				break
			reagents.touch_turf(T, step_contents) //VOREStation Add
			if(burning)
				T.hotspot_expose(700, step_contents * 10)
			var/mob/M
			for(var/atom/A in T)
				if(!ismob(A) && A.simulated) // Mobs are handled differently
					reagents.touch(A, step_contents)
				else if(ismob(A) && !M)
					M = A
			if(M)
				reagents.splash(M, reagents.total_volume)
				break
			if(T == get_turf(target))
				break
		sleep(delay)
	sleep(10)
	qdel(src)

#undef FIREFUEL_MAX
#undef FIREFUEL_MIN