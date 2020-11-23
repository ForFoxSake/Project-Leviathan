/obj/item/device/lighting/flashlight
	name = "Flashlight"
	action_button_name = "Toggle Flashlight"
	var/tick_cost = 0.4

	var/obj/effect/effect/light/light_spot

	var/radiance_power = 0.8
	var/light_spot_power = 2
	var/light_spot_radius = 3

	var/light_spot_range = 3
	var/spot_locked = FALSE		//this flag needed for lightspot to stay in place when player clicked on turf, will reset when moved or turned

	var/light_direction
	var/lightspot_hitObstacle = FALSE

/obj/item/device/lighting/flashlight/Destroy()
	qdel(light_spot)
	return ..()

/obj/item/device/lighting/flashlight/proc/calculate_dir(var/turf/old_loc)
	if (istype(src.loc,/obj/item/weapon/storage) || istype(src.loc,/obj/structure/closet))
		return
	if (istype(src.loc,/mob/living))
		var/mob/living/L = src.loc
		set_dir(L.dir)
	else if (pulledby && old_loc)
		var/x_diff = src.x - old_loc.x
		var/y_diff = src.y - old_loc.y
		if (x_diff > 0)
			set_dir(EAST)
		else if (x_diff < 0)
			set_dir(WEST)
		else if (y_diff > 0)
			set_dir(NORTH)
		else if (y_diff < 0)
			set_dir(SOUTH)

/obj/item/device/lighting/flashlight/set_dir(new_dir)
	var/turf/NT = get_turf(src)	//supposed location for lightspot
	var/turf/L = get_turf(src)	//current location of flashlight in world
	var/hitSomething = FALSE
	light_direction = new_dir

	if (istype(src.loc,/obj/item/weapon/storage) || istype(src.loc,/obj/structure/closet))	//no point in finding spot for light if flashlight is inside container
		place_lightspot(NT)
		return

	switch(light_direction)
		if(NORTH)
			for(var/i = 1,i <= light_spot_range, i++)
				var/turf/T = locate(L.x,L.y + i,L.z)
				if (lightSpotPassable(T))
					if(T.is_space())
						break
					NT = T
				else
					hitSomething = TRUE
					break
		if(SOUTH)
			for(var/i = 1,i <= light_spot_range, i++)
				var/turf/T = locate(L.x,L.y - i,L.z)
				if (lightSpotPassable(T))
					if(T.is_space())
						break
					NT = T
				else
					hitSomething = TRUE
					break
		if(EAST)
			for(var/i = 1,i <= light_spot_range, i++)
				var/turf/T = locate(L.x + i,L.y,L.z)
				if (lightSpotPassable(T))
					if(T.is_space())
						break
					NT = T
				else
					hitSomething = TRUE
					break
		if(WEST)
			for(var/i = 1,i <= light_spot_range, i++)
				var/turf/T = locate(L.x - i,L.y,L.z)
				if (lightSpotPassable(T))
					if(T.is_space())
						break
					NT = T
				else
					hitSomething = TRUE
					break
	lightspot_hitObstacle = hitSomething
	place_lightspot(NT)

	if (!istype(src.loc,/mob/living))
		dir = new_dir

/obj/item/device/lighting/flashlight/proc/place_lightspot(var/turf/T, var/angle = null)
	if (light_spot && on && !T.is_space())
		light_spot.forceMove(T)
		light_spot.icon_state = "nothing"
		light_spot.transform = initial(light_spot.transform)

		if (cell && cell.percent() <= 25)
			apply_power_deficiency()	//onhit brightness increased there
		else if (lightspot_hitObstacle)
			light_spot.set_light(light_spot_radius*radius_multiplier + 1, light_spot_power*brightness_multiplier * 1.25, flashlight_colour)
		else
			light_spot.set_light(light_spot_radius*radius_multiplier, light_spot_power*brightness_multiplier, flashlight_colour)


		if (lightSpotPlaceable(T) && !lightspot_hitObstacle)
			var/distance = get_dist(get_turf(src),T)
			switch(distance)
				if (1)
					light_spot.icon_state = "lightspot_vclose"
				if (2)
					light_spot.icon_state = "lightspot_close"
				if (3)
					light_spot.icon_state = "lightspot_medium"
				if (4)
					light_spot.icon_state = "lightspot_far"
		if(angle)
			light_spot.transform = turn(light_spot.transform, angle)
		else
			switch(light_direction)	//icon pointing north by default
				if(SOUTH)
					light_spot.transform = turn(light_spot.transform, 180)
				if(EAST)
					light_spot.transform = turn(light_spot.transform, 90)
				if(WEST)
					light_spot.transform = turn(light_spot.transform, -90)

/obj/item/device/lighting/flashlight/proc/lightSpotPassable(var/atom/A)
	if(!A || z != A.z)
		return TRUE
	if (A.opacity)
		return FALSE
	for(var/obj/O in A.contents)
		if (O.opacity)
			return FALSE
	return TRUE

/obj/item/device/lighting/flashlight/proc/lightSpotPlaceable(var/turf/T)	//check if we can place icon there, light will be still applied
	if(T == get_turf(src) || !isfloor(T))
		return FALSE
	for(var/obj/O in T)
		if(istype(O, /obj/structure/window))
			return FALSE
	return TRUE

/obj/item/device/lighting/flashlight/Moved(mob/user, old_loc)
	spot_locked = FALSE
	calculate_dir()

/obj/item/device/lighting/flashlight/pickup(mob/user)
	spot_locked = FALSE
	calculate_dir()
	return ..()

/obj/item/device/lighting/flashlight/dropped(mob/user as mob)
	if(light_direction)
		set_dir(light_direction)

/obj/item/device/lighting/flashlight/afterattack(atom/A, mob/user)
	var/turf/T = get_turf(A)
	if(can_see(user,T) && light_spot_range >= get_dist(get_turf(src),T))
		lightspot_hitObstacle = FALSE
		if (!lightSpotPassable(T))
			lightspot_hitObstacle = TRUE
			T = get_step_towards(T,get_turf(src))
			if(!lightSpotPassable(T))
				return
		spot_locked = TRUE
		light_direction = get_dir(src,T)
		place_lightspot(T,Get_Angle(get_turf(src),T))

/obj/item/device/lighting/flashlight/attack_self(mob/user)
	if(..())
		if(!on && light_spot)
			qdel(light_spot)
			light_spot = null
		else
			light_spot = new(get_turf(src),light_spot_radius, light_spot_power, flashlight_colour)
			if (cell.percent() <= 25)
				apply_power_deficiency()
			calculate_dir()
		return 1
	else
		return 0

/obj/item/device/lighting/flashlight/proc/apply_power_deficiency()
	if (!cell || !light_spot)
		return
	var/hit_brightness_multiplier = 1
	var/hit_radius_addition = 0
	if(lightspot_hitObstacle)
		hit_brightness_multiplier = 1.25
		hit_radius_addition = 1

	switch (cell.percent())
		if(0 to 10)
			light_spot.set_light(max(2, round((light_spot_radius*radius_multiplier)/100 * 15) + hit_radius_addition), (light_spot_power*brightness_multiplier)/100 * 30 * hit_brightness_multiplier, flashlight_colour)
			set_light(l_power = (radiance_power*brightness_multiplier)/100 * 15, l_color = flashlight_colour)
		if(10 to 15)
			light_spot.set_light(max(2, round((light_spot_radius*radius_multiplier)/100 * 40) + hit_radius_addition), (light_spot_power*brightness_multiplier)/100 * 50 * hit_brightness_multiplier, flashlight_colour)
			set_light(l_power = (radiance_power*brightness_multiplier)/100 * 40, l_color = flashlight_colour)
		if(15 to 25)
			light_spot.set_light(max(2, round((light_spot_radius*radius_multiplier)/100 * 70) + hit_radius_addition), (light_spot_power*brightness_multiplier)/100 * 70 * hit_brightness_multiplier, flashlight_colour)
			set_light(l_power = (radiance_power*brightness_multiplier)/100 * 70, l_color = flashlight_colour)


/obj/item/device/lighting/flashlight/process()
	. = ..()
	if(on)
		if(!spot_locked)
			calculate_dir()
		if (cell && cell.percent() <= 25)
			apply_power_deficiency()
	else if(light_spot)
		qdel(light_spot)
		light_spot = null
	return .

/obj/item/device/lighting/flashlight/MouseDrop(over_object)
	if((src.loc == usr) && istype(over_object, /obj/screen/inventory/hand))
		cell.forceMove(usr)
		usr.put_in_hands(cell)
		cell = null
	else
		return ..()

/obj/item/device/lighting/flashlight/pen
	name = "penlight"
	desc = "A pen-sized light, used by medical staff."
	icon_state = "penlight"
	item_state = "pen"
	slot_flags = SLOT_EARS
	brightness_on = 2
	radiance_power = 0.4
	light_spot_radius = 2
	light_spot_power = 2
	light_spot_range = 1
	w_class = ITEMSIZE_TINY
	power_use = 0

/obj/item/device/lighting/flashlight/color	//Default color is blue, just roll with it.
	name = "blue flashlight"
	desc = "A hand-held emergency light. This one is blue."
	icon_state = "flashlight_blue"
	flashlight_colour = "#488BDB"

/obj/item/device/lighting/flashlight/color/red
	name = "red flashlight"
	desc = "A hand-held emergency light. This one is red."
	icon_state = "flashlight_red"
	flashlight_colour = "#D54D4D"

/obj/item/device/lighting/flashlight/color/orange
	name = "orange flashlight"
	desc = "A hand-held emergency light. This one is orange."
	icon_state = "flashlight_orange"
	flashlight_colour = "#EC9D46"

/obj/item/device/lighting/flashlight/color/yellow
	name = "yellow flashlight"
	desc = "A hand-held emergency light. This one is yellow."
	icon_state = "flashlight_yellow"
	flashlight_colour = "#D7D75E"

/obj/item/device/lighting/flashlight/maglight
	name = "maglight"
	desc = "A very, very heavy duty flashlight."
	icon_state = "maglight"
	flashlight_colour = LIGHT_COLOR_FLUORESCENT_FLASHLIGHT
	force = 10
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_SMALL
	attack_verb = list ("smacked", "thwacked", "thunked")
	matter = list(DEFAULT_WALL_MATERIAL = 200,"glass" = 50)
	hitsound = "swing_hit"

/obj/item/device/lighting/flashlight/heavy
	name = "heavy duty flashlight"
	desc = "A hand-held heavy-duty light."
	icon_state = "heavyduty"
	item_state = "heavyduty"
	radiance_power = 1
	light_spot_radius = 4
	light_spot_power = 3
	light_spot_range = 4
	tick_cost = 0.8
//	suitable_cell = /obj/item/weapon/cell/medium
